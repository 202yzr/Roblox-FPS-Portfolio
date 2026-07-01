local Tool = script.Parent
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local Camera = workspace.CurrentCamera

local Remote = Tool:WaitForChild("ShootEvent")
local Reload = Tool:WaitForChild("ReloadEvent")
local Config = require(Tool:WaitForChild("config"))

local ammo = Config.MAX_AMMO
local canShoot = true
local reloading = false

local function recoil()
	Camera.CFrame = Camera.CFrame * CFrame.Angles(
		math.rad(-1.5),
		math.rad(math.random(-3,3) * 0.2),
		0
	)
end

Tool.Activated:Connect(function()
	if not canShoot or reloading then return end
	if ammo <= 0 then return end

	canShoot = false
	ammo -= 1

	local origin = Camera.CFrame.Position

	local spread = Vector3.new(
		math.random(-Config.SPREAD, Config.SPREAD) * 0.01,
		math.random(-Config.SPREAD, Config.SPREAD) * 0.01,
		0
	)

	local direction = ((Mouse.Hit.Position + spread) - origin).Unit * Config.RANGE

	Remote:FireServer(origin, direction)

	Tool.ShootSound:Play()
	recoil()

	task.wait(Config.FIRE_RATE)
	canShoot = true
end)

-- reload
game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
	if gp then return end

	if input.KeyCode == Enum.KeyCode.R then
		if reloading or ammo == Config.MAX_AMMO then return end

		reloading = true
		Tool.ReloadSound:Play()

		Reload:FireServer()

		task.wait(Config.RELOAD_TIME)
		ammo = Config.MAX_AMMO
		reloading = false
	end
end)
