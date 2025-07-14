-- 🛡️ VX4 Key Access Check + Loader
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local keyDataPath = "vx4_keydata.json"
local today = os.date("%Y%m%d")

-- Module to simulate Luarmor loading
local Modules = {
    Colors = {
        ["Green"] = "0,255,0",
        ["White"] = "255,255,255"
    }
}

Modules.ChangeColor = function()
    RunService.Heartbeat:Connect(function()
        local devConsole = CoreGui:FindFirstChild("DevConsoleMaster")
        if devConsole then
            for _, label in pairs(devConsole:GetDescendants()) do
                if label:IsA("TextLabel") then
                    label.RichText = true
                end
            end
        end
    end)
end

Modules.LoadingBar = function(watermark, delay, loadingsymbol, callback)
    delay = delay or 0.05
    Modules.ChangeColor()

    local idText = watermark .. tostring(math.random(500, 20000))
    print(idText)

    local loadingLabel = nil
    local progress = ""

    repeat task.wait()
        local devConsole = CoreGui:FindFirstChild("DevConsoleMaster")
        if devConsole then
            for _, label in pairs(devConsole:GetDescendants()) do
                if label:IsA("TextLabel") and string.find(label.Text:lower(), idText:lower()) then
                    loadingLabel = label
                    break
                end
            end
        end
    until loadingLabel

    local total = 25

    for i = 1, total do
        progress = progress .. loadingsymbol
        local percent = math.floor((i / total) * 100)
        local status = (percent <= 31 and "Connecting to Script") or (percent <= 68 and "Connecting to Server") or "Finishing Up"

        loadingLabel.Text = string.format("[vx4] %s • %d%% %s", status, percent, progress)
        task.wait(delay)
    end

    -- Final success message
    loadingLabel.Text = string.format('<font color="rgb(%s)">[vx4]</font> <font color="rgb(%s)">SUCCESS</font>', Modules.Colors["White"], Modules.Colors["Green"])

    if callback then
        callback()
    end
end

-- ✅ Check if key is verified
local verified = false
if isfile and readfile and isfile(keyDataPath) then
    local success, result = pcall(function()
        return HttpService:JSONDecode(readfile(keyDataPath))
    end)
    if success and result and result.verified and result.date == today then
        verified = true
    end
end

-- ❌ Kick player if key not verified
if not verified then
    LocalPlayer:Kick("🔐 VX4 Hub requires a valid key.")
    return
end

-- ✅ Show loading then run main script
Modules.LoadingBar("vx4_one", 0.05, "#", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MicrosoftExcelHub/vx4/refs/heads/main/Vx4.lua"))()
end)
