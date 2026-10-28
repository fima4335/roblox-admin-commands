return {
	Name = "bring",
	Aliases = {"tphere"},
	Description = "Притянуть игрока к себе",
	Permission = 1,
	Execute = function(executor, args, targets, utils)
		if not executor.Character or not executor.Character:FindFirstChild("HumanoidRootPart") then
			return
		end

		for _, target in ipairs(targets) do
			if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
				target.Character.HumanoidRootPart.CFrame = executor.Character.HumanoidRootPart.CFrame + Vector3.new(0, 0, 5)
				utils.notify(executor, "Притянут: " .. target.Name)
			end
		end
	end
}
