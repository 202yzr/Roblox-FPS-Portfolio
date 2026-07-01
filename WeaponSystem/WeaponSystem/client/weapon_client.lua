local Tool = script.Parent
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

local Remote = Tool:WaitForChild("ShootEvent")

local cooldown = false

Tool.Activated:Connect(function()
	if cooldown then return end
	cooldown = true

	local origin = workspace.CurrentCamera.CFrame.Position
	local direction = (Mouse.Hit.Position - origin).Unit * 500

	Remote:FireServer(origin, direction)

	task.wait(0.15) -- vitesse de tir
	cooldown = false
end)
