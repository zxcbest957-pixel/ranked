-- [[
--    TITANIUM HUB - UI LIBRARY
-- ]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Titanium = getgenv().Titanium or { Theme = {} }
local Theme = Titanium.Theme or {
    Main = Color3.fromRGB(10, 10, 10),
    Accent = Color3.fromRGB(0, 255, 150),
    Text = Color3.fromRGB(255, 255, 255),
    SubText = Color3.fromRGB(160, 160, 160)
}


local Lib = {}

function Lib:CreateWindow(options)
    local Window = {
        Tabs = {}
    }
    
    local Screen = Instance.new("ScreenGui", CoreGui)
    Screen.Name = "Titanium_UI"
    
    local Main = Instance.new("Frame", Screen)
    Main.Size = UDim2.new(0, 550, 0, 380)
    Main.Position = UDim2.new(0.5, -275, 0.5, -190)
    Main.BackgroundColor3 = Theme.Main
    Main.BorderSizePixel = 0
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
    
    local Header = Instance.new("Frame", Main)
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.BackgroundTransparency = 1
    
    local Title = Instance.new("TextLabel", Header)
    Title.Size = UDim2.new(1, -20, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.Text = "TITANIUM <font color='#00FF96'>HUB</font>"
    Title.TextColor3 = Theme.Text
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.RichText = true
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1

    local function makeDraggable(frame, handle)
        local dragging, dragInput, dragStart, startPos
        handle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = frame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then dragging = false end
                end)
            end
        end)
        handle.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
    end

    makeDraggable(Main, Header)

    -- Sidebar
    local Sidebar = Instance.new("Frame", Main)
    Sidebar.Size = UDim2.new(0, 140, 1, -40)
    Sidebar.Position = UDim2.new(0, 0, 0, 40)
    Sidebar.BackgroundTransparency = 1
    
    local SidebarList = Instance.new("UIListLayout", Sidebar)
    SidebarList.Padding = UDim.new(0, 5)
    SidebarList.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local Container = Instance.new("Frame", Main)
    Container.Size = UDim2.new(1, -150, 1, -50)
    Container.Position = UDim2.new(0, 145, 0, 45)
    Container.BackgroundTransparency = 1

    function Window:CreateTab(name)
        local Tab = {
            Name = name,
            Content = Instance.new("ScrollingFrame", Container)
        }
        
        Tab.Content.Size = UDim2.new(1, 0, 1, 0)
        Tab.Content.BackgroundTransparency = 1
        Tab.Content.Visible = (#Window.Tabs == 0)
        Tab.Content.ScrollBarThickness = 0
        Tab.Content.CanvasSize = UDim2.new(0, 0, 0, 0)
        
        local TabList = Instance.new("UIListLayout", Tab.Content)
        TabList.Padding = UDim.new(0, 8)
        TabList.SortOrder = Enum.SortOrder.LayoutOrder
        
        local TabBtn = Instance.new("TextButton", Sidebar)
        TabBtn.Size = UDim2.new(0.9, 0, 0, 35)
        TabBtn.Text = name
        TabBtn.TextColor3 = Tab.Content.Visible and Theme.Text or Theme.SubText
        TabBtn.BackgroundColor3 = Theme.Accent
        TabBtn.BackgroundTransparency = Tab.Content.Visible and 0.8 or 1
        TabBtn.Font = Enum.Font.GothamSemibold
        TabBtn.TextSize = 13
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)
        
        TabBtn.MouseButton1Click:Connect(function()
            for _, t in pairs(Window.Tabs) do
                t.Content.Visible = false
            end
            Tab.Content.Visible = true
            for _, child in pairs(Sidebar:GetChildren()) do
                if child:IsA("TextButton") then
                    TweenService:Create(child, TweenInfo.new(0.3), {BackgroundTransparency = (child == TabBtn and 0.8 or 1), TextColor3 = (child == TabBtn and Theme.Text or Theme.SubText)}):Play()
                end
            end
        end)

        table.insert(Window.Tabs, Tab)
        
        function Tab:CreateToggle(title, callback)
            local Toggle = Instance.new("Frame", Tab.Content)
            Toggle.Size = UDim2.new(1, -10, 0, 40)
            Toggle.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
            Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0, 8)
            
            local Text = Instance.new("TextLabel", Toggle)
            Text.Size = UDim2.new(1, -50, 1, 0)
            Text.Position = UDim2.new(0, 12, 0, 0)
            Text.Text = title
            Text.TextColor3 = Theme.Text
            Text.Font = Enum.Font.Gotham
            Text.TextSize = 13
            Text.TextXAlignment = Enum.TextXAlignment.Left
            Text.BackgroundTransparency = 1
            
            local Btn = Instance.new("TextButton", Toggle)
            Btn.Size = UDim2.new(0, 35, 0, 18)
            Btn.Position = UDim2.new(1, -45, 0.5, -9)
            Btn.Text = ""
            Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
            Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 10)
            
            local Circle = Instance.new("Frame", Btn)
            Circle.Size = UDim2.new(0, 14, 0, 14)
            Circle.Position = UDim2.new(0, 2, 0.5, -7)
            Circle.BackgroundColor3 = Theme.Text
            Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)
            
            local state = false
            Btn.MouseButton1Click:Connect(function()
                state = not state
                TweenService:Create(Btn, TweenInfo.new(0.3), {BackgroundColor3 = state and Theme.Accent or Color3.fromRGB(40, 40, 45)}):Play()
                TweenService:Create(Circle, TweenInfo.new(0.3), {Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)}):Play()
                callback(state)
            end)
            
            Tab.Content.CanvasSize = UDim2.new(0, 0, 0, TabList.AbsoluteContentSize.Y + 10)
        end
        
        function Tab:CreateSlider(title, min, max, default, callback)
            local Slider = Instance.new("Frame", Tab.Content)
            Slider.Size = UDim2.new(1, -10, 0, 50)
            Slider.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
            Instance.new("UICorner", Slider).CornerRadius = UDim.new(0, 8)
            
            local Text = Instance.new("TextLabel", Slider)
            Text.Size = UDim2.new(1, -20, 0, 25)
            Text.Position = UDim2.new(0, 12, 0, 5)
            Text.Text = title .. ": " .. default
            Text.TextColor3 = Theme.Text
            Text.Font = Enum.Font.Gotham
            Text.TextSize = 13
            Text.TextXAlignment = Enum.TextXAlignment.Left
            Text.BackgroundTransparency = 1
            
            local Bar = Instance.new("Frame", Slider)
            Bar.Size = UDim2.new(1, -24, 0, 4)
            Bar.Position = UDim2.new(0, 12, 1, -15)
            Bar.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
            Instance.new("UICorner", Bar)
            
            local Fill = Instance.new("Frame", Bar)
            Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
            Fill.BackgroundColor3 = Theme.Accent
            Instance.new("UICorner", Fill)
            
            local function update(input)
                local pos = math.clamp((input.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
                local val = math.floor(min + (max - min) * pos)
                Fill.Size = UDim2.new(pos, 0, 1, 0)
                Text.Text = title .. ": " .. val
                callback(val)
            end
            
            local sliding = false
            Bar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then sliding = true update(input) end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then sliding = false end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if sliding and input.UserInputType == Enum.UserInputType.MouseMovement then update(input) end
            end)

            Tab.Content.CanvasSize = UDim2.new(0, 0, 0, TabList.AbsoluteContentSize.Y + 10)
        end
        
        return Tab
    end
    
    return Window
end

return Lib
