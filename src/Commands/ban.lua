return {
	Name = "ban",
	Aliases = {"b"},
	Description = "Забанить игрока",
	Permission = 2,
	Execute = function(executor, args, targets, utils)
		local reason = table.concat(args, " ")
		if reason == "" then
			reason = utils.Config.DefaultBanReason
		end

		for _, target in ipairs(targets) do
			if target ~= executor then
				utils.banPlayer(target.UserId, reason, executor.Name)
				target:Kick(reason)
				utils.notify(executor, "Забанен: " .. target.Name)
			end
		end
	end
}
