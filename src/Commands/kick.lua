return {
	Name = "kick",
	Aliases = {"k"},
	Description = "Кикнуть игрока",
	Permission = 1,
	Execute = function(executor, args, targets, utils)
		local reason = table.concat(args, " ")
		if reason == "" then
			reason = utils.Config.DefaultKickReason
		end

		for _, target in ipairs(targets) do
			if target ~= executor then
				target:Kick(reason)
				utils.notify(executor, "Кикнут: " .. target.Name)
			end
		end
	end
}
