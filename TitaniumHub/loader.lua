-- [[
--    TITANIUM HUB - PREMIER CHEAT SYSTEM
--    Official Loader v1.0
-- ]]

repeat task.wait() until game:IsLoaded()

local function log(txt)
    print("[TITANIUM] " .. tostring(txt))
end

log("Initializing System...")

-- Global Setup
getgenv().Titanium = {
    Config = {},
    Modules = {},
    Connections = {},
    UI = nil,
    Version = "1.0.0"
}

local repositoryBaseURL = "https://raw.githubusercontent.com/zxcbest957-pixel/ranked/main/TitaniumHub/"

-- Loader UI (Optional but nice)
local function createLoaderUI()
    -- We can add a small progress bar here later
    log("Checking Environment...")
end

createLoaderUI()

-- Module Loading Logic
local function load(path)
    local content = nil
    local success = false
    
    -- 1. Try local file first (for dev)
    if isfile and readfile and isfile("TitaniumHub/" .. path) then
        success, content = pcall(function() return readfile("TitaniumHub/" .. path) end)
    end
    
    -- 2. Fallback to GitHub
    if not success or not content then
        local url = repositoryBaseURL .. path
        success, content = pcall(function() return game:HttpGet(url) end)
    end
    
    if success and content then
        local func, err = loadstring(content)
        if func then
            return func()
        else
            warn("[TITANIUM] Error in " .. path .. ": " .. tostring(err) .. "\nContent snippet: " .. content:sub(1, 100))
        end
    else
        warn("[TITANIUM] Failed to find module: " .. path)
    end
end

-- Start Boot Sequence
task.spawn(function()
    log("Loading Core...")
    _G.Titanium.Theme = load("ui/theme.lua")
    _G.Titanium.UI = load("ui/library.lua")
    
    log("Loading Main Logic...")
    load("main.lua")
    
    log("Successfully Injected!")
end)

