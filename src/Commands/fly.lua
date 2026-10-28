local flying = {}

return {
	Name = "fly",
	Aliases = {"flight"},
	Description = "Включить/выключить полёт (простой)",
	Permission = 1,
	Execute = function(executor, args, targets, utils)
		for _, target in ipairs(targets) do
			local char = target.Character
			if not char then continue end

			local hum = char:FindFirstChildOfClass("Humanoid")
			local hrp = char:FindFirstChild("HumanoidRootPart")
			if not hum or not hrp then continue end

			if flying[target.UserId] then
				-- выключить
				flying[target.UserId] = nil
				hum.PlatformStand = false
				utils.notify(executor, target.Name .. " больше не летает")
			else
				flying[target.UserId] = true
				hum.PlatformStand = true

				local bv = Instance.new("BodyVelocity")
				bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
				bv.Velocity = Vector3.zero
				bv.Parent = hrp

				local bg = Instance.new("BodyGyro")
				bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
				bg.P = 10000
				bg.Parent = hrp

				utils.notify(executor, target.Name .. " теперь летает (управляй WASD + Space/Ctrl)")

				-- Простое управление (лучше делать через Remote + LocalScript, но для простоты так)
				task.spawn(function()
					while flying[target.UserId] and char.Parent do
						local move = Vector3.zero
						-- В реальном проекте лучше использовать UserInputService на клиенте
						task.wait(0.1)
					end
					if bv then bv:Destroy() end
					if bg then bg:Destroy() end
					if hum then hum.PlatformStand = false end
				end)
			end
		end
	end
}
