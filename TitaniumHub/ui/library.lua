-- [[
--    TITANIUM HUB - UI LIBRARY
-- ]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Titanium = getgenv().Titanium
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
        Tab.Content.ScrollBarThickness = 2
        
        local TabList = Instance.new("UIListLayout", Tab.Content)
        TabList.Padding = UDim.new(0, 10)
        
        local TabBtn = Instance.new("TextButton", Sidebar)
        TabBtn.Size = UDim2.new(0.9, 0, 0, 35)
        TabBtn.Text = name
        TabBtn.TextColor3 = Tab.Content.Visible and Theme.Text or Theme.SubText
        TabBtn.BackgroundColor3 = Theme.Accent
        TabBtn.BackgroundTransparency = Tab.Content.Visible and 0.8 or 1
        TabBtn.Font = Enum.Font.GothamSemibold
        TabBtn.TextSize = 14
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)
        
        TabBtn.MouseButton1Click:Connect(function()
            for _, t in pairs(Window.Tabs) do
                t.Content.Visible = false
                -- Reset button styles
            end
            Tab.Content.Visible = true
            -- Set active button style
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
            Text.TextSize = 14
            Text.TextXAlignment = Enum.TextXAlignment.Left
            Text.BackgroundTransparency = 1
            
            local Btn = Instance.new("TextButton", Toggle)
            Btn.Size = UDim2.new(0, 30, 0, 30)
            Btn.Position = UDim2.new(1, -40, 0.5, -15)
            Btn.Text = ""
            Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
            Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
            
            local state = false
            Btn.MouseButton1Click:Connect(function()
                state = not state
                TweenService:Create(Btn, TweenInfo.new(0.3), {BackgroundColor3 = state and Theme.Accent or Color3.fromRGB(40, 40, 45)}):Play()
                callback(state)
            end)
        end
        
        return Tab
    end
    
    return Window
end

return Lib
