return {
	Name = "tp",
	Aliases = {"teleport", "goto"},
	Description = "Телепорт к игроку",
	Permission = 1,
	Execute = function(executor, args, targets, utils)
		local target = targets[1]
		if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
			utils.notify(executor, "Цель не найдена")
			return
		end

		if executor.Character and executor.Character:FindFirstChild("HumanoidRootPart") then
			executor.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
			utils.notify(executor, "Телепортирован к " .. target.Name)
		end
	end
}
