-- [[
--    TITANIUM HUB - PREMIER CHEAT SYSTEM
--    Official Loader v1.1 [BULLETPROOF]
-- ]]

repeat task.wait() until game:IsLoaded()

-- Use both getgenv and _G for maximum compatibility
local function getTitanium()
    if getgenv().Titanium then return getgenv().Titanium end
    if _G.Titanium then return _G.Titanium end
    return nil
end

local function log(txt)
    print("[TITANIUM] " .. tostring(txt))
end

log("Initializing System...")

-- Initialize Global Table
local Titanium = {
    Config = {},
    Modules = {},
    Connections = {},
    UI = nil,
    Version = "1.1.0"
}
getgenv().Titanium = Titanium
_G.Titanium = Titanium

local repositoryBaseURL = "https://raw.githubusercontent.com/zxcbest957-pixel/ranked/main/TitaniumHub/"

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
            -- Pass Titanium to the module so it doesn't have to guess the environment
            local success, result = pcall(func)
            if success then
                return result
            else
                warn("[TITANIUM] Execution error in " .. path .. ": " .. tostring(result))
            end
        else
            warn("[TITANIUM] Syntax error in " .. path .. ": " .. tostring(err))
        end
    else
        warn("[TITANIUM] Failed to find module: " .. path)
    end
end

-- Start Boot Sequence
task.spawn(function()
    log("Loading Core...")
    
    -- Ensure Titanium is available in this thread
    local T = getTitanium()
    
    T.Theme = load("ui/theme.lua")
    T.UI = load("ui/library.lua")
    
    log("Loading Main Logic...")
    load("main.lua")
    
    log("Successfully Injected!")
end)
