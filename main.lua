--[[
🏈 CROOM FOOTBALL SCRIPT — MAIN (RAYFIELD FIXED)
✅ Rayfield loader BUILT-IN
✅ No line 47 errors
✅ Full features
]]--

print("🏈 Loading Croom Football Script...")

--<< SAFE RAYFIELD LOADER (BUILT-IN) >>--
local Rayfield
do
	local ok, res = pcall(function()
		return loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source.lua"))()
	end)
	if not ok then
		warn("❌ Rayfield failed to load. Enable HttpGet in executor.")
		return
	end
	Rayfield = res
end

--<< SERVICES >>--
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

--<< GLOBALS >>--
getgenv().g = getgenv().g or {}
g.magnetEnabled = false
g.magnetRange = 10

getgenv().qbAimbot = false
getgenv().leadDistanceVariable = 10
getgenv().heightDistanceVariable = 2

getgenv().cframeSpeedEnabled = false
getgenv().cframeSpeed = 10

getgenv().tackleReachEnabled = false
getgenv().tackleReachRange = 15

--<< CHARACTER >>--
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
LocalPlayer.CharacterAdded:Connect(function(c) char = c end)

--<< RAYFIELD UI >>--
local Window = Rayfield:CreateWindow({
	Name = "Croom Football",
	LoadingTitle = "Croom Hub",
	LoadingSubtitle = "Football Script",
	ConfigurationSaving = { Enabled = false }
})

local MainTab = Window:CreateTab("Main", 4483362458)
local QBTab = Window:CreateTab("QB", 4483362458)
local MoveTab = Window:CreateTab("Movement", 4483362458)

--<< MAIN TAB >>--
MainTab:CreateToggle({
	Name = "Magnet Catch",
	CurrentValue = false,
	Callback = function(v) g.magnetEnabled = v end
})

MainTab:CreateToggle({
	Name = "Tackle Reach",
	CurrentValue = false,
	Callback = function(v) getgenv().tackleReachEnabled = v end
})

--<< QB TAB >>--
QBTab:CreateToggle({
	Name = "QB Aimbot",
	CurrentValue = false,
	Callback = function(v) getgenv().qbAimbot = v end
})

QBTab:CreateSlider({
	Name = "Lead Distance",
	Range = {0, 20},
	Increment = 1,
	CurrentValue = 10,
	Callback = function(v) getgenv().leadDistanceVariable = v end
})

QBTab:CreateSlider({
	Name = "Height Offset",
	Range = {0, 6},
	Increment = 0.5,
	CurrentValue = 2,
	Callback = function(v) getgenv().heightDistanceVariable = v end
})

--<< MOVEMENT TAB >>--
MoveTab:CreateToggle({
	Name = "CFrame Speed",
	CurrentValue = false,
	Callback = function(v) getgenv().cframeSpeedEnabled = v end
})

MoveTab:CreateSlider({
	Name = "Speed Amount",
	Range = {5, 15},
	Increment = 1,
	CurrentValue = 10,
	Callback = function(v) getgenv().cframeSpeed = v end
})

print("✅ Rayfield UI Loaded")

--<< MAGNET CATCH >>--
local lastTouch = {}
RunService.Heartbeat:Connect(function()
	if not g.magnetEnabled then return end
	local l = char:FindFirstChild("Left Arm") or char:FindFirstChild("LeftHand")
	local r = char:FindFirstChild("Right Arm") or char:FindFirstChild("RightHand")
	if not (l and r) then return end

	for _, b in ipairs(Workspace:GetChildren()) do
		if b:IsA("BasePart") and b.Name == "Football" and not b.Anchored then
			if (b.Position - l.Position).Magnitude <= g.magnetRange then
				if not lastTouch[b] or tick() - lastTouch[b] > 0.05 then
					lastTouch[b] = tick()
					firetouchinterest(l, b, 0); firetouchinterest(l, b, 1)
					firetouchinterest(r, b, 0); firetouchinterest(r, b, 1)
				end
			end
		end
	end
end)

--<< QB AIMBOT >>--
local function getBestReceiver()
	local best, dist = nil, math.huge
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			local d = (Camera.CFrame.Position - p.Character.HumanoidRootPart.Position).Magnitude
			if d < dist then dist = d; best = p end
		end
	end
	return best
end

RunService.RenderStepped:Connect(function()
	if not getgenv().qbAimbot then return end
	local t = getBestReceiver()
	if not (t and t.Character) then return end
	local hrp = t.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local lead =
		hrp.Position
		+ hrp.Velocity * (getgenv().leadDistanceVariable / 10)
		+ Vector3.new(0, getgenv().heightDistanceVariable, 0)

	Camera.CFrame = CFrame.new(Camera.CFrame.Position, lead)
end)

--<< CFRAME SPEED >>--
RunService.Heartbeat:Connect(function(dt)
	if not getgenv().cframeSpeedEnabled then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	local hum = char:FindFirstChild("Humanoid")
	if hrp and hum and hum.MoveDirection.Magnitude > 0 then
		hrp.CFrame += hum.MoveDirection * getgenv().cframeSpeed * dt
	end
end)

--<< TACKLE REACH >>--
RunService.Heartbeat:Connect(function()
	if not getgenv().tackleReachEnabled then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			if (hrp.Position - p.Character.HumanoidRootPart.Position).Magnitude <= getgenv().tackleReachRange then
				for _, limb in ipairs({"Left Arm","Right Arm","LeftHand","RightHand"}) do
					if char:FindFirstChild(limb) and p.Character:FindFirstChild(limb) then
						firetouchinterest(char[limb], p.Character[limb], 0)
						firetouchinterest(char[limb], p.Character[limb], 1)
					end
				end
			end
		end
	end
end)

print("✅ Croom Football Script FULLY READY")
