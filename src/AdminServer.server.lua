--[[
	AdminServer.server.lua
	Положи этот Script в ServerScriptService

	Требует:
	- ModuleScript "Config" в ReplicatedStorage
	- Folder "Commands" рядом с этим скриптом (или в ServerScriptService)
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local TextChatService = game:GetService("TextChatService")

local Config = require(ReplicatedStorage:WaitForChild("Config"))

-- ======================
-- Загрузка команд
-- ======================
local CommandsFolder = script.Parent:FindFirstChild("Commands") or script:FindFirstChild("Commands")
if not CommandsFolder then
	warn("[AdminSystem] Папка Commands не найдена!")
	return
end

local Commands = {}
local CommandList = {} -- для help

for _, module in ipairs(CommandsFolder:GetChildren()) do
	if module:IsA("ModuleScript") then
		local ok, cmd = pcall(require, module)
		if ok and type(cmd) == "table" and cmd.Name and cmd.Execute then
			Commands[cmd.Name:lower()] = cmd
			if cmd.Aliases then
				for _, alias in ipairs(cmd.Aliases) do
					Commands[alias:lower()] = cmd
				end
			end
			table.insert(CommandList, cmd)
		else
			warn("[AdminSystem] Не удалось загрузить команду:", module.Name)
		end
	end
end

-- ======================
-- Система прав
-- ======================
local function getPermissionLevel(player)
	local level = Config.Admins[player.UserId] or 0

	if Config.GroupId > 0 then
		local success, rank = pcall(function()
			return player:GetRankInGroup(Config.GroupId)
		end)
		if success and rank then
			local groupLevel = Config.GroupRanks[rank] or 0
			if groupLevel > level then
				level = groupLevel
			end
		end
	end

	return level
end

local function hasPermission(player, required)
	return getPermissionLevel(player) >= (required or 1)
end

-- ======================
-- Баны
-- ======================
local BanStore = DataStoreService:GetDataStore(Config.BanDataStoreName)

local function isBanned(userId)
	local success, data = pcall(function()
		return BanStore:GetAsync(tostring(userId))
	end)
	return success and data ~= nil
end

local function banPlayer(userId, reason, executorName)
	pcall(function()
		BanStore:SetAsync(tostring(userId), {
			Reason = reason or Config.DefaultBanReason,
			BannedBy = executorName,
			Timestamp = os.time(),
		end)
	end)
end

local function unbanPlayer(userId)
	pcall(function()
		BanStore:RemoveAsync(tostring(userId))
	end)
end

-- Проверка бана при входе
Players.PlayerAdded:Connect(function(player)
	if isBanned(player.UserId) then
		player:Kick(Config.DefaultBanReason)
	end
end)

-- ======================
-- Помощники
-- ======================
local function findPlayers(name, executor)
	if not name or name == "" or name == "me" then
		return {executor}
	end

	name = name:lower()
	local found = {}

	for _, plr in ipairs(Players:GetPlayers()) do
		if plr.Name:lower():sub(1, #name) == name or plr.DisplayName:lower():sub(1, #name) == name then
			table.insert(found, plr)
		end
	end

	return found
end

local function notify(player, message)
	-- Простое уведомление через чат (можно заменить на RemoteEvent + GUI)
	pcall(function()
		TextChatService:DisplayBubble(player.Character and player.Character:FindFirstChild("Head"), message)
	end)
	print("[Admin]", player.Name .. ":", message)
end

-- ======================
-- Обработка команд
-- ======================
local function processCommand(player, message)
	if not message:sub(1, #Config.Prefix) == Config.Prefix then
		return
	end

	local args = {}
	for word in message:sub(#Config.Prefix + 1):gmatch("%S+") do
		table.insert(args, word)
	end

	if #args == 0 then return end

	local cmdName = args[1]:lower()
	table.remove(args, 1)

	local cmd = Commands[cmdName]
	if not cmd then return end

	if not hasPermission(player, cmd.Permission or 1) then
		notify(player, "Недостаточно прав для этой команды")
		return
	end

	-- Специальная обработка help
	if cmdName == "help" or cmdName == "cmds" then
		local list = {}
		for _, c in ipairs(CommandList) do
			if hasPermission(player, c.Permission or 1) then
				table.insert(list, Config.Prefix .. c.Name .. " - " .. (c.Description or ""))
			end
		end
		table.sort(list)
		notify(player, "Доступные команды:\n" .. table.concat(list, "\n"))
		return
	end

	local targets = {}
	if #args > 0 and (cmd.RequiresTarget ~= false) then
		targets = findPlayers(args[1], player)
		if #targets == 0 and cmd.RequiresTarget ~= false then
			notify(player, "Игрок не найден: " .. args[1])
			return
		end
		table.remove(args, 1)
	end

	local success, err = pcall(function()
		cmd.Execute(player, args, targets, {
			banPlayer = banPlayer,
			unbanPlayer = unbanPlayer,
			isBanned = isBanned,
			notify = notify,
			Config = Config,
		})
	end)

	if not success then
		warn("[AdminSystem] Ошибка в команде", cmdName, err)
		notify(player, "Ошибка выполнения команды")
	end
end

-- Подключение к чату (TextChatService + старый чат)
local function onChatted(player, message)
	processCommand(player, message)
end

Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(message)
		onChatted(player, message)
	end)
end)

for _, player in ipairs(Players:GetPlayers()) do
	player.Chatted:Connect(function(message)
		onChatted(player, message)
	end)
end

print("[AdminSystem] Загружено команд:", #CommandList)
