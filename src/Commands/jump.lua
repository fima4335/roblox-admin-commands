return {
	Name = "jump",
	Aliases = {"jp", "jumppower"},
	Description = "Установить JumpPower",
	Permission = 1,
	Execute = function(executor, args, targets, utils)
		local value = tonumber(args[1]) or 50

		for _, target in ipairs(targets) do
			local hum = target.Character and target.Character:FindFirstChildOfClass("Humanoid")
			if hum then
				hum.JumpPower = value
				utils.notify(executor, target.Name .. " JumpPower = " .. value)
			end
		end
	end
}
