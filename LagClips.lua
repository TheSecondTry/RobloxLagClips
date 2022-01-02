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
			jumpTimer = jumpTimer + 1
		end
		if not (UserInputService:IsKeyDown(Enum.KeyCode.W) or UserInputService:IsKeyDown(Enum.KeyCode.A) or UserInputService:IsKeyDown(Enum.KeyCode.S) or UserInputService:IsKeyDown(Enum.KeyCode.D) or UserInputService:IsKeyDown(Enum.KeyCode.Up) or UserInputService:IsKeyDown(Enum.KeyCode.Down)) then
			walkTimer = 0
		else
			walkTimer = walkTimer + 1
		end
		
		touchingWall.Value = wall
		
		local ray = Ray.new(HumanoidRootPart.Position, HumanoidRootPart.CFrame.LookVector)
		wall = workspace:FindPartOnRay(ray)
		
		if wall then
			if wallCanCollide and jumpTimer > 3 and walkTimer <= 3 then
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
