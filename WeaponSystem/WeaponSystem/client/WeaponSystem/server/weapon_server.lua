local Tool = script.Parent
local Remote = Tool:WaitForChild("ShootEvent")

local DAMAGE = 25

Remote.OnServerEvent:Connect(function(player, origin, direction)

	if not player.Character then return end

	local params = RaycastParams.new()
	params.FilterDescendantsInstances = {player.Character}
	params.FilterType = Enum.RaycastFilterType.Blacklist

	local result = workspace:Raycast(origin, direction, params)

	if result then
		local model = result.Instance:FindFirstAncestorOfClass("Model")

		if model then
			local humanoid = model:FindFirstChild("Humanoid")

			if humanoid then
				humanoid:TakeDamage(DAMAGE)
			end
		end
	end
end)
