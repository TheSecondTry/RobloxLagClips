local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local wall
local touchingWall = script.Wall
local wallCanCollide
local jumpTimer = 0
local walkTimer = 0

touchingWall.Changed:connect(function()
	if touchingWall.Value then
		wallCanCollide = touchingWall.Value.CanCollide
	else
		wallCanCollide = false
	end
end)

repeat wait() until game:IsLoaded()
RunService.Stepped:connect(function()
	local character = player.Character
	local humanoid = character:FindFirstChild("Humanoid")
	local HumanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	
	if humanoid and HumanoidRootPart then
		if humanoid.Jump then
			jumpTimer = 0
		else
			jumpTimer += 1
		end
		if humanoid.MoveDirection.Magnitude > 0 then
			walkTimer += 1
		else
			walkTimer = 0
		end
		
		touchingWall.Value = wall
		
		local ray = Ray.new(HumanoidRootPart.Position, HumanoidRootPart.CFrame.LookVector)
		wall = workspace:FindPartOnRay(ray)
		
		if wall then
			if wallCanCollide and jumpTimer > 3 and walkTimer <= 1 then
				local touchingWall2 = touchingWall.Value
				touchingWall.Value.CanCollide = not touchingWall.Value.CanCollide
				wait()
				local collisionPcall = pcall(function()
					touchingWall.Value.CanCollide = not touchingWall.Value.CanCollide
				end)
				if not collisionPcall then
					touchingWall2.CanCollide = true
				end
			end
		end
	end
end)
