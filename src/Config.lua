--[[
	Config.lua
	Положи этот ModuleScript в ReplicatedStorage с именем "Config"
]]

return {
	-- Префикс команд в чате
	Prefix = ";",

	-- Список админов: [UserId] = уровень прав
	-- 1 = обычный админ, 2 = старший админ, 3 = владелец и т.д.
	Admins = {
		-- ПРИМЕР: замени на свой UserId
		-- [123456789] = 3,
	},

	-- ID группы Roblox (если 0 — не используется)
	GroupId = 0,

	-- Ранг в группе -> уровень прав
	GroupRanks = {
		[255] = 3, -- Owner
		[254] = 2, -- Admin
		[253] = 1, -- Moderator
	},

	-- Имя DataStore для банов
	BanDataStoreName = "AdminBans_v1",

	-- Сообщение при кике/бане
	DefaultKickReason = "Вы были кикнуты администратором",
	DefaultBanReason = "Вы забанены администратором",
}
