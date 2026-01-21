--[[
    🏈 COMPLETE FIXED FOOTBALL SCRIPT WITH FULL GUI
    
    ✅ Method #3 (No Hooks) - WORKING
    ✅ All bugs fixed
    ✅ Full GUI included
    ✅ All features working
]]--

print("🏈 Loading Football Script...")

--<< Services >>--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

--<< Initialize ALL Variables >>--
getgenv().g = getgenv().g or {}
g.magnetEnabled = false
g.magnetRange = 10
g.currentMode = "Regular"
g.hitboxEnabled = false
g.hitboxType = "Forcefield"
g.rainbowHitboxEnabled = false
g.rainbowSpeed = 0.5
g.ping = 0.1
g.rainbowHue_void = 0

getgenv().enabled = false
getgenv().leadDistanceVariable = 0
getgenv().heightDistanceVariable = 0
getgenv().dimeLead = 11
getgenv().MagLead = 12.5
getgenv().bulletLead = 4
getgenv().autoAngle = false
getgenv().beamMode = false
getgenv().autoThrow = false

getgenv().voidArmSize = 2
getgenv().voidArmOn = false
getgenv().Void_NoJumpCooldown = false
getgenv().VoidQuickTP = false
getgenv().VoidTPDistance = 0
getgenv().tackleReachEnabled = false
getgenv().tackleReachRange = 15
getgenv().cframeSpeedEnabled = false
getgenv().cframeSpeed = 1
getgenv().walkType = "CFrame Speed"
getgenv().voidAntiBlock = false

--<< NO AC BYPASS NEEDED >>--
print("✅ Using No-Hook Method (Working)")

if not LPH_OBFUSCATED then
    getfenv().LPH_NO_VIRTUALIZE = function(f) return f end
    getfenv().LPH_JIT_MAX = function(f) return f end
end

task.wait(0.3)

--<< Library & GUI System >>--
local utility = {}
local UIS = UserInputService
local RS = RunService
local TS = TweenService
local mouse = LocalPlayer:GetMouse()

local Library = {}
local mainKeybind = "LeftControl"
local canDrag = true

function utility:ToRGB(color)  
	return color.R*255, color.G*255, color.B*255
end

local function CreateDrag(gui)
	local dragging, dragInput, dragStart, startPos

	local function update(input)
		local delta = input.Position - dragStart
		TS:Create(gui, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		}):Play()
	end

	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			if not canDrag then return end
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
		end
	end)

	UIS.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)

	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

local tweenInfo = TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local tweenInfo2 = TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

function Library:tween(object, goal, callback)
	local tween = TS:Create(object, tweenInfo, goal)
	tween.Completed:Connect(callback or function() end)
	tween:Play()
end

function Library:tween2(object, goal, callback)
	local tween = TS:Create(object, tweenInfo2, goal)
	tween.Completed:Connect(callback or function() end)
	tween:Play()
end

local ScreenGui = Instance.new('ScreenGui', gethui())

function Library:CreateWindow(options)
	local GUI = { CurrentTab = nil }

	local Main = Instance.new('Frame', ScreenGui)
	local Title = Instance.new('TextLabel', Main)
	local Divider = Instance.new('Frame', Main)
	local TabBar = Instance.new('ScrollingFrame', Main)
	local TabLayout = Instance.new('UIListLayout', TabBar)
	local TabBarPad = Instance.new('UIPadding', TabBar)
	local MainCorner = Instance.new('UICorner', Main)
	local MainGradient = Instance.new('UIGradient', Main)
	local Divider2 = Instance.new('Frame', Main)

	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	Main.Name = "Main"
	Main.Position = UDim2.new(0.271, 0, 0.2845, 0)
	Main.Size = UDim2.new(0, 710, 0, 405)
	Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	Main.BorderSizePixel = 0
	Main.ZIndex = 100

	Title.Name = "Title"
	Title.Position = UDim2.new(0.0254, 0, 0, 0)
	Title.Size = UDim2.new(0, 143, 0, 50)
	Title.BackgroundTransparency = 1
	Title.Text = options.Title
	Title.TextColor3 = Color3.fromRGB(220, 220, 220)
	Title.Font = Enum.Font.Gotham
	Title.TextSize = 23
	Title.ZIndex = 101
	Title.TextXAlignment = Enum.TextXAlignment.Left

	Divider.Name = "Divider"
	Divider.Position = UDim2.new(0, 0, 0.121, 0)
	Divider.Size = UDim2.new(0, 710, 0, 1)
	Divider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	Divider.BorderSizePixel = 0
	Divider.ZIndex = 102

	TabBar.Name = "TabBar"
	TabBar.Position = UDim2.new(0, 0, 0.1235, 0)
	TabBar.Size = UDim2.new(0, 161, 0, 355)
	TabBar.BackgroundTransparency = 1
	TabBar.BorderSizePixel = 0
	TabBar.ZIndex = 103
	TabBar.ScrollingEnabled = false
	TabBar.ScrollBarThickness = 0

	TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	TabLayout.SortOrder = Enum.SortOrder.LayoutOrder

	TabBarPad.PaddingTop = UDim.new(0, 5)

	Divider2.Name = "Divider2"
	Divider2.Position = UDim2.new(0.2246, 0, 0.121, 0)
	Divider2.Size = UDim2.new(0, 1, 0, 356)
	Divider2.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	Divider2.BackgroundTransparency = 0.5
	Divider2.BorderSizePixel = 0
	Divider2.ZIndex = 102

	MainCorner.CornerRadius = UDim.new(0, 20)

	MainGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 10)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 45, 45))
	})

	CreateDrag(Main)

	function Library:Toggle()
		ScreenGui.Enabled = not ScreenGui.Enabled
	end

	UIS.InputBegan:Connect(function(key, gp)
		if gp then return end
		if key.KeyCode == Enum.KeyCode[mainKeybind] then
			Library:Toggle()
		end
	end)

	function GUI:NewTab(options)
		local tab = { Active = false }

		local Canvas = Instance.new('ScrollingFrame', Main)
		local UIListLayout = Instance.new('UIListLayout', Canvas)
		local UIPadding = Instance.new('UIPadding', Canvas)
		local SelectedTab = Instance.new('Frame', TabBar)
		local Highlight = Instance.new('Frame', SelectedTab)
		local STCorner = Instance.new('UICorner', SelectedTab)
		local Tab = Instance.new('TextButton', SelectedTab)

		SelectedTab.Size = UDim2.new(0,118,0,34)
		SelectedTab.BackgroundTransparency = 1
		SelectedTab.ZIndex = 100

		Highlight.Name = "Highlight"
		Highlight.Position = UDim2.new(0.0508, 0, 0.2353, 0)
		Highlight.Size = UDim2.new(0, 2, 0, 18)
		Highlight.BackgroundColor3 = Color3.fromRGB(137, 207, 240)
		Highlight.BorderSizePixel = 0
		Highlight.Transparency = 1
		Highlight.ZIndex = 101

		STCorner.CornerRadius = UDim.new(0,6)

		Tab.Name = "Tab"
		Tab.Position = UDim2.new(0.0678,0,0,0)
		Tab.Size = UDim2.new(0,109,0,34)
		Tab.BackgroundTransparency = 1
		Tab.Text = options.Name
		Tab.TextColor3 = Color3.new(0.5529,0.5529,0.5529)
		Tab.Font = Enum.Font.Gotham
		Tab.TextSize = 14
		Tab.ZIndex = 105
		Tab.AutoButtonColor = false

		Canvas.Name = "Canvas"
		Canvas.Position = UDim2.new(0.2268,0,0.1235,0)
		Canvas.Size = UDim2.new(0,549,0,355)
		Canvas.BackgroundTransparency = 1
		Canvas.BorderSizePixel = 0
		Canvas.ZIndex = 107
		Canvas.Visible = false
		Canvas.AutomaticCanvasSize = Enum.AutomaticSize.Y
		Canvas.ScrollBarThickness = 0

		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0,5)

		UIPadding.PaddingTop = UDim.new(0,10)

		function tab:Activate()
			if not tab.Active then
				if GUI.CurrentTab ~= nil then
					GUI.CurrentTab:Deactivate()
				end
				tab.Active = true
				Library:tween(Tab, {TextColor3 = Color3.new(1,1,1)})
				Library:tween(SelectedTab, {BackgroundTransparency = 0.5})
				Library:tween(Highlight, {BackgroundTransparency = 0})
				Canvas.Visible = true
				GUI.CurrentTab = tab
			end
		end

		function tab:Deactivate()
			if tab.Active then
				tab.Active = false
				Library:tween(Tab, {TextColor3 = Color3.new(0.5529,0.5529,0.5529)})
				Library:tween(SelectedTab, {BackgroundTransparency = 1})
				Library:tween(Highlight, {BackgroundTransparency = 1})
				Canvas.Visible = false
			end
		end

		Tab.MouseButton1Click:Connect(function()
			tab:Activate()
		end)

		if GUI.CurrentTab == nil then
			tab:Activate()
		end

		function tab:NewToggle(options)
			local toggle = { State = false }

			local Toggle = Instance.new('ImageButton', Canvas)
			local ToggleTitle = Instance.new('TextLabel', Toggle)
			local CheckBox = Instance.new('Frame', Toggle)
			local CheckBoxCorner = Instance.new('UICorner', CheckBox)
			local CheckMark = Instance.new('ImageButton', CheckBox)
			local ToggleCorner = Instance.new('UICorner', Toggle)

			Toggle.Size = UDim2.new(0,499,0,42)
			Toggle.BackgroundColor3 = Color3.new(0,0,0)
			Toggle.BackgroundTransparency = 0.5
			Toggle.BorderSizePixel = 0
			Toggle.ZIndex = 108
			Toggle.AutoButtonColor = false

			ToggleTitle.Position = UDim2.new(0.0321,0,0,0)
			ToggleTitle.Size = UDim2.new(0,363,0,34)
			ToggleTitle.BackgroundTransparency = 1
			ToggleTitle.Text = options.Name
			ToggleTitle.TextColor3 = Color3.new(0.851,0.851,0.851)
			ToggleTitle.Font = Enum.Font.Gotham
			ToggleTitle.TextSize = 14
			ToggleTitle.ZIndex = 109
			ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

			CheckBox.Position = UDim2.new(0.9359,0,0.1471,0)
			CheckBox.Size = UDim2.new(0,24,0,24)
			CheckBox.BackgroundColor3 = Color3.new(0.0706,0.0706,0.0706)
			CheckBox.BorderSizePixel = 0
			CheckBox.ZIndex = 107

			CheckBoxCorner.CornerRadius = UDim.new(0,5)

			CheckMark.Position = UDim2.new(0.0464,0,0.0417,0)
			CheckMark.Size = UDim2.new(0,22,0,22)
			CheckMark.BackgroundTransparency = 1
			CheckMark.Image = "rbxassetid://6031094667"
			CheckMark.Visible = true
			CheckMark.AutoButtonColor = false
			CheckMark.ZIndex = 107

			ToggleCorner.CornerRadius = UDim.new(0,6)

			toggle.State = options.default or false
			options.callback(toggle.State)

			if toggle.State then
				Library:tween(CheckMark, {ImageTransparency = 0})
			else
				Library:tween(CheckMark, {ImageTransparency = 1})
			end

			function toggle:Toggle(boolean)
				if boolean == nil then
					toggle.State = not toggle.State
				else
					toggle.State = boolean
				end

				if toggle.State then
					Library:tween(CheckMark, {ImageTransparency = 0})
				else
					Library:tween(CheckMark, {ImageTransparency = 1})
				end

				options.callback(toggle.State)
			end

			Toggle.MouseButton1Down:Connect(function()
				toggle:Toggle()
			end)

			return toggle
		end

		function tab:NewSlider(options)
			local slider = { hover = false, MouseDown = false, connections = {} }

			local Slider = Instance.new('ImageButton', Canvas)
			local SliderTitle = Instance.new('TextLabel', Slider)
			local SliderBack = Instance.new('Frame', Slider)
			local SliderBackCorner = Instance.new('UICorner', SliderBack)
			local SliderMain = Instance.new('Frame', SliderBack)
			local SliderMainCorner = Instance.new('UICorner', SliderMain)
			local SliderCorner = Instance.new('UICorner', Slider)
			local SliderAmt = Instance.new('TextBox', Slider)

			Slider.Size = UDim2.new(0,499,0,34)
			Slider.BackgroundColor3 = Color3.new(0,0,0)
			Slider.BackgroundTransparency = 0.5
			Slider.BorderSizePixel = 0
			Slider.ZIndex = 108
			Slider.AutoButtonColor = false

			SliderTitle.Position = UDim2.new(0.0321,0,0,0)
			SliderTitle.Size = UDim2.new(0,211,0,34)
			SliderTitle.BackgroundTransparency = 1
			SliderTitle.Text = options.Name
			SliderTitle.TextColor3 = Color3.new(0.851,0.851,0.851)
			SliderTitle.Font = Enum.Font.Gotham
			SliderTitle.TextSize = 14
			SliderTitle.ZIndex = 109
			SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

			SliderBack.Position = UDim2.new(0.5251,0,0.4118,0)
			SliderBack.Size = UDim2.new(0,229,0,6)
			SliderBack.BackgroundColor3 = Color3.new(0.0706,0.0706,0.0706)
			SliderBack.BorderSizePixel = 0
			SliderBack.ZIndex = 109

			SliderBackCorner.CornerRadius = UDim.new(0,5)

			SliderMain.Size = UDim2.new(0,118,0,6)
			SliderMain.BackgroundColor3 = Color3.new(1,1,1)
			SliderMain.BorderSizePixel = 0
			SliderMain.ZIndex = 109

			SliderMainCorner.CornerRadius = UDim.new(0,5)
			SliderCorner.CornerRadius = UDim.new(0,6)

			SliderAmt.Position = UDim2.new(0.4569,0,0,0)
			SliderAmt.Size = UDim2.new(0,34,0,34)
			SliderAmt.BackgroundTransparency = 1
			SliderAmt.Text = "0"
			SliderAmt.TextColor3 = Color3.new(0.851,0.851,0.851)
			SliderAmt.Font = Enum.Font.Gotham
			SliderAmt.TextSize = 11
			SliderAmt.ZIndex = 109

			function slider:SetValue(v)
				if v == nil then
					local percentage = math.clamp((mouse.X - SliderBack.AbsolutePosition.X) / (SliderBack.AbsoluteSize.X), 0, 1)
					local value = ((options.max - options.min) * percentage) + options.min
					if value % 1 == 0 then
						SliderAmt.Text = string.format("%.0f", value)
					else
						SliderAmt.Text = string.format("%.2f", value)
					end
					SliderMain.Size = UDim2.fromScale(percentage, 1)
				else
					if v % 1 == 0 then
						SliderAmt.Text = string.format("%.0f", v)
					else
						SliderAmt.Text = tostring(v)
					end
					SliderMain.Size = UDim2.fromScale(((v - options.min) / (options.max - options.min)), 1)
				end
				options.callback(slider:GetValue())
			end

			function slider:GetValue()
				return tonumber(SliderAmt.Text)
			end

			slider:SetValue(options.default)

			SliderAmt.FocusLost:Connect(function()
				local toNum
				pcall(function()
					toNum = tonumber(SliderAmt.Text)
				end)
				if toNum then
					toNum = math.clamp(toNum, options.min, options.max)
					slider:SetValue(toNum)
				else
					SliderAmt.Text = "only number :<"
				end
			end)

			local Connection
			table.insert(slider.connections, UIS.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					pcall(function()
						Connection:Disconnect()
						Connection = nil
					end)
				end
			end))

			table.insert(slider.connections, Slider.MouseButton1Down:Connect(function()
				if Connection then
					Connection:Disconnect()
				end

				Connection = RS.Heartbeat:Connect(function()
					slider:SetValue()
				end)
			end))

			return slider
		end

		function tab:NewDropDown(options)
			local dropdown = {}

			local Dropdown = Instance.new('Frame', Canvas)
			local DropdownTitle = Instance.new('TextLabel', Dropdown)
			local DropdownSelected = Instance.new('Frame', Dropdown)
			local SelectedOptionCorner = Instance.new('UICorner', DropdownSelected)
			local SelectedText = Instance.new('TextButton', DropdownSelected)
			local DropdownCorner = Instance.new('UICorner', Dropdown)

			Dropdown.Size = UDim2.new(0,499,0,34)
			Dropdown.BackgroundColor3 = Color3.new(0,0,0)
			Dropdown.BackgroundTransparency = 0.5
			Dropdown.BorderSizePixel = 0
			Dropdown.ZIndex = 108

			DropdownTitle.Position = UDim2.new(0.0321,0,0,0)
			DropdownTitle.Size = UDim2.new(0,312,0,34)
			DropdownTitle.BackgroundTransparency = 1
			DropdownTitle.Text = options.Name
			DropdownTitle.TextColor3 = Color3.new(0.851,0.851,0.851)
			DropdownTitle.Font = Enum.Font.Gotham
			DropdownTitle.TextSize = 14
			DropdownTitle.ZIndex = 109
			DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left

			DropdownSelected.Position = UDim2.new(0.6794,0,0.1471,0)
			DropdownSelected.Size = UDim2.new(0,152,0,24)
			DropdownSelected.BackgroundColor3 = Color3.new(0.0706,0.0706,0.0706)
			DropdownSelected.BorderSizePixel = 0
			DropdownSelected.ZIndex = 109

			SelectedOptionCorner.CornerRadius = UDim.new(0,5)

			SelectedText.Position = UDim2.new(0.0321,0,0,0)
			SelectedText.Size = UDim2.new(0,147,0,24)
			SelectedText.BackgroundTransparency = 1
			SelectedText.AutoButtonColor = false
			SelectedText.Text = options.default
			SelectedText.TextColor3 = Color3.new(0.851,0.851,0.851)
			SelectedText.Font = Enum.Font.Gotham
			SelectedText.TextSize = 13
			SelectedText.ZIndex = 109

			DropdownCorner.CornerRadius = UDim.new(0,6)

			local DropDownOptions = Instance.new('Frame', Main)
			local Frame = Instance.new('Frame', DropDownOptions)
			local UIListLayout = Instance.new('UIListLayout', Frame)

			DropDownOptions.Position = UDim2.new(1.0211,0,0.1358,0)
			DropDownOptions.Size = UDim2.new(0,100,0,49)
			DropDownOptions.BackgroundColor3 = Color3.new(0,0,0)
			DropDownOptions.BackgroundTransparency = 0.25
			DropDownOptions.BorderSizePixel = 0
			DropDownOptions.Visible = false
			DropDownOptions.AutomaticSize = Enum.AutomaticSize.XY
			DropDownOptions.ZIndex = 110

			Frame.Size = UDim2.new(0,100,0,49)
			Frame.BackgroundTransparency = 1
			Frame.BorderSizePixel = 0
			Frame.AutomaticSize = Enum.AutomaticSize.XY
			Frame.ZIndex = 110

			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

			for i, v in pairs(options.options) do
				local Option = Instance.new('TextButton', Frame)
				local Highlight = Instance.new('Frame', Option)

				Option.Size = UDim2.new(0,98,0,27)
				Option.BackgroundTransparency = 1
				Option.Text = v
				Option.TextColor3 = Color3.new(0.8627,0.8627,0.8627)
				Option.Font = Enum.Font.SourceSans
				Option.TextSize = 14
				Option.ZIndex = 111

				Highlight.Position = UDim2.new(-0.0306,0,0,0)
				Highlight.Size = UDim2.new(0,2,0,27)
				Highlight.BackgroundColor3 = Color3.new(1,1,1)
				Highlight.BorderSizePixel = 0
				Highlight.AutomaticSize = Enum.AutomaticSize.Y
				Highlight.ZIndex = 111

				Option.MouseButton1Down:Connect(function()
					SelectedText.Text = v
					DropDownOptions.Visible = false
					options.callback(v)
				end)
			end

			SelectedText.MouseButton1Down:Connect(function()
				DropDownOptions.Visible = not DropDownOptions.Visible
			end)

			options.callback(options.default)

			return dropdown
		end

		function tab:NewButton(options)
			local button = {}

			local Button = Instance.new('Frame', Canvas)
			local ButtonTitle = Instance.new('TextButton', Button)
			local ButtonCorner = Instance.new('UICorner', Button)

			Button.Size = UDim2.new(0,499,0,34)
			Button.BackgroundColor3 = Color3.new(0,0,0)
			Button.BackgroundTransparency = 0.5
			Button.BorderSizePixel = 0
			Button.ZIndex = 108

			ButtonTitle.Size = UDim2.new(0,498,0,34)
			ButtonTitle.AutoButtonColor = false
			ButtonTitle.BackgroundTransparency = 1
			ButtonTitle.Text = options.Name
			ButtonTitle.TextColor3 = Color3.new(0.851,0.851,0.851)
			ButtonTitle.Font = Enum.Font.Gotham
			ButtonTitle.TextSize = 14
			ButtonTitle.ZIndex = 109

			ButtonCorner.CornerRadius = UDim.new(0,6)

			ButtonTitle.MouseButton1Down:Connect(function()
				Library:tween(Button, {BackgroundColor3 = Color3.new(0.756863, 0.756863, 0.756863)})
			end)

			ButtonTitle.MouseButton1Up:Connect(function()
				Library:tween(Button, {BackgroundColor3 = Color3.fromRGB(0, 0, 0)})
			end)

			ButtonTitle.MouseButton1Click:Connect(function()
				options.callback()
			end)

			return button
		end

		return tab
	end

	return GUI
end

--<< CREATE GUI >>--
local lib = Library:CreateWindow({Title = "Croom"})

local Tab1 = lib:NewTab({Name ="Mag"})
local Tab2 = lib:NewTab({Name ="Qb aimbot"})
local Tab3 = lib:NewTab({Name ="Physical"})
local Tab4 = lib:NewTab({Name ="Player"})
local Tab5 = lib:NewTab({Name ="Visuals"})
local Tab7 = lib:NewTab({Name ="Settings"})

--<< TAB 1: MAGNETS >>--
Tab1:NewToggle({
	Name = "Magnets",
	default = false,
	callback = function(v)
		g.magnetEnabled = v
	end
})

local slider = Tab1:NewSlider({
	Name = "Magnet Range",
	min = 0,
	max = 15,
	default = 10,
	callback = function(v)
		g.magnetRange = v
	end
})

Tab1:NewDropDown({
	Name = "Magnet Type",
	options = { "Regular", "League", "Legit", "Rage", "Custom" },
	default = "Regular",
	callback = function(v)
		g.currentMode = v
		local presets = { Rage = 15, Regular = 10, Legit = 8, League = 6 }
		if presets[v] and slider then
			slider:SetValue(presets[v])
		end
	end
})

Tab1:NewToggle({
	Name = "Magnet Hitbox",
	default = false,
	callback = function(v)
		g.hitboxEnabled = v
	end
})

Tab1:NewDropDown({
	Name = "Hitbox Type",
	options = { "Forcefield", "Sphere", "Box" },
	default = "Forcefield",
	callback = function(v)
		g.hitboxType = v
	end
})

Tab1:NewToggle({
	Name = "Rainbow Hitbox",
	default = false,
	callback = function(v)
		g.rainbowHitboxEnabled = v
	end
})

Tab1:NewSlider({
	Name = "Rainbow Speed",
	min = 0.5,
	max = 1,
	default = 0.5,
