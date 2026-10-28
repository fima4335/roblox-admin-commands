return {
	Name = "heal",
	Aliases = {"hp"},
	Description = "Вылечить игрока",
	Permission = 1,
	Execute = function(executor, args, targets, utils)
		for _, target in ipairs(targets) do
			local hum = target.Character and target.Character:FindFirstChildOfClass("Humanoid")
			if hum then
				hum.Health = hum.MaxHealth
				utils.notify(executor, "Вылечен: " .. target.Name)
			end
		end
	end
}
