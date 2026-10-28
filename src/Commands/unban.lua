return {
	Name = "unban",
	Aliases = {"ub"},
	Description = "Разбанить по UserId",
	Permission = 2,
	RequiresTarget = false,
	Execute = function(executor, args, _, utils)
		local userId = tonumber(args[1])
		if not userId then
			utils.notify(executor, "Укажи UserId: ;unban 123456789")
			return
		end

		utils.unbanPlayer(userId)
		utils.notify(executor, "Разбанен UserId: " .. userId)
	end
}
