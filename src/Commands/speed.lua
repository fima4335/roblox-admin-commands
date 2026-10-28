return {
	Name = "speed",
	Aliases = {"ws", "walkspeed"},
	Description = "Установить WalkSpeed",
	Permission = 1,
	Execute = function(executor, args, targets, utils)
		local value = tonumber(args[1]) or 16

		for _, target in ipairs(targets) do
			local hum = target.Character and target.Character:FindFirstChildOfClass("Humanoid")
			if hum then
				hum.WalkSpeed = value
				utils.notify(executor, target.Name .. " WalkSpeed = " .. value)
			end
		end
	end
}
