return {
	Name = "respawn",
	Aliases = {"refresh", "re"},
	Description = "Респавн игрока",
	Permission = 1,
	Execute = function(executor, args, targets, utils)
		for _, target in ipairs(targets) do
			target:LoadCharacter()
			utils.notify(executor, "Респавн: " .. target.Name)
		end
	end
}
