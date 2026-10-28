return {
	Name = "kill",
	Aliases = {"slay"},
	Description = "Убить игрока",
	Permission = 1,
	Execute = function(executor, args, targets, utils)
		for _, target in ipairs(targets) do
			local hum = target.Character and target.Character:FindFirstChildOfClass("Humanoid")
			if hum then
				hum.Health = 0
				utils.notify(executor, "Убит: " .. target.Name)
			end
		end
	end
}
