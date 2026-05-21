--[[
Vain和Vault，你们为Matcha打造了坚实的基础。但你们知道它真正需要什么才能达到巅峰性能吗？一个专属的二次元老婆。大家都知道顶尖代码的秘诀就是在主屏幕上放一个高质量的角色。请在下次更新中加入这个功能，因为这个项目离不开它。
PLEASE VAIN or VAULT ADD MATCHA WAIFUUUU PLEASEEEEEEEEEEEEEEEE
this is just a copy paste of V1 but with a jumpscare wowww
Waifu Jumpscare version ts so buns :sob:
@itscloudya (474646453588066306) created the jumpscare function btw
]]
warn("You can move the image btw, Press f1 to hide the baddie waifu")
warn("Jumpscare enabled — 10% chance every 60s. Good luck.")
notify("Press f1 to hide the waifu", "Matcha Waifu", 3)

local gooners = game:GetService("Players")
local mouse = gooners.LocalPlayer:GetMouse()
local cam = game:GetService("Workspace").CurrentCamera

local waifu = Drawing.new("Image")
waifu.Size = Vector2.new(288, 512) 
waifu.Position = Vector2.new(500, 200)
waifu.Visible = true

local waifuImageData = game:HttpGet("https://raw.githubusercontent.com/nvqren/dawg/refs/heads/main/waifu.png")
waifu.Data = waifuImageData

local dragging = false
local dragStartMouse = nil
local dragStartPos = nil
local f1_down = false

local JUMPSCARE_CHANCE = 10
local JUMPSCARE_INTERVAL = 60
local JUMPSCARE_DURATION = 0.8
local SHAKE_INTENSITY = 40
local SHAKE_SPEED = 0.02

local lastJumpscareCheck = os.clock()
local jumpscareActive = false

local function getScreenSize()
    local ok, vps = pcall(function() return cam.ViewportSize end)
    if ok and vps then return vps.X, vps.Y end
    return 1920, 1080
end

local function doJumpscare()
    if jumpscareActive then return end
    jumpscareActive = true

    local screenW, screenH = getScreenSize()

    local flash = Drawing.new("Square")
    flash.Position = Vector2.new(0, 0)
    flash.Size = Vector2.new(screenW, screenH)
    flash.Color = Color3.fromRGB(255, 255, 255)
    flash.Filled = true
    flash.Visible = true
    flash.ZIndex = 998

    local scareImg = Drawing.new("Image")
    scareImg.Size = Vector2.new(screenH * 0.56, screenH)
    scareImg.Position = Vector2.new(
        math.floor((screenW - screenH * 0.56) / 2),
        0
    )
    scareImg.Data = waifuImageData
    scareImg.Visible = true
    scareImg.ZIndex = 999

    local vignette = Drawing.new("Square")
    vignette.Position = Vector2.new(0, 0)
    vignette.Size = Vector2.new(screenW, screenH)
    vignette.Color = Color3.fromRGB(255, 0, 0)
    vignette.Filled = true
    vignette.Transparency = 0.3
    vignette.Visible = true
    vignette.ZIndex = 1000

    local scareTxt = Drawing.new("Text")
    scareTxt.Font = Drawing.Fonts.System
    scareTxt.Size = 48
    scareTxt.Text = "MATCHA WAIFU"
    scareTxt.Color = Color3.fromRGB(255, 0, 0)
    scareTxt.Outline = true
    scareTxt.Center = true
    scareTxt.Position = Vector2.new(math.floor(screenW / 2), math.floor(screenH * 0.08))
    scareTxt.Visible = true
    scareTxt.ZIndex = 1001

    local startTime = os.clock()

    task.wait(0.05)
    flash.Transparency = 0.5
    task.wait(0.03)
    flash.Visible = false

    local shakeEnd = startTime + JUMPSCARE_DURATION
    while os.clock() < shakeEnd do
        if isrbxactive() then
            local sx = math.random(-SHAKE_INTENSITY, SHAKE_INTENSITY)
            local sy = math.random(-SHAKE_INTENSITY, SHAKE_INTENSITY)
            pcall(mousemoverel, 0, sx, sy)
        end

        local elapsed = os.clock() - startTime
        local pulse = 0.15 + 0.15 * math.sin(elapsed * 20)
        pcall(function() vignette.Transparency = pulse end)

        task.wait(SHAKE_SPEED)
    end

    local fadeStart = os.clock()
    local fadeDur = 0.3
    while os.clock() - fadeStart < fadeDur do
        local t = (os.clock() - fadeStart) / fadeDur
        local alpha = math.max(0, 1 - t)
        pcall(function() scareImg.Transparency = alpha end)
        pcall(function() vignette.Transparency = alpha * 0.3 end)
        pcall(function() scareTxt.Transparency = alpha end)
        task.wait(0.016)
    end

    pcall(function() flash:Remove() end)
    pcall(function() scareImg:Remove() end)
    pcall(function() vignette:Remove() end)
    pcall(function() scareTxt:Remove() end)

    jumpscareActive = false
end

local function checkJumpscare()
    local now = os.clock()
    if now - lastJumpscareCheck >= JUMPSCARE_INTERVAL then
        lastJumpscareCheck = now
        local roll = math.random(1, 100)
        if roll <= JUMPSCARE_CHANCE then
            warn("[Waifu] JUMPSCARE TRIGGERED! (rolled " .. roll .. " / " .. JUMPSCARE_CHANCE .. "%)")
            task.spawn(doJumpscare)
        end
    end
end

while true do
    task.wait()
    
    if iskeypressed(0x70) then
        if not f1_down then
            f1_down = true
            waifu.Visible = not waifu.Visible
        end
    else
        f1_down = false
    end

    if waifu.Visible then
        if ismouse1pressed() then
            local wifey, mommy = mouse.X, mouse.Y
            
            if not dragging then
                if wifey >= waifu.Position.X and wifey <= waifu.Position.X + waifu.Size.X and
                   mommy >= waifu.Position.Y and mommy <= waifu.Position.Y + waifu.Size.Y then
                    dragging = true
                    dragStartPos = waifu.Position
                    dragStartMouse = Vector2.new(wifey, mommy)
                end
            else
                local dih = Vector2.new(wifey, mommy) - dragStartMouse
                waifu.Position = dragStartPos + dih
            end
        else
            dragging = false
        end
    else
        dragging = false
    end

    if not waifu.Visible then
        checkJumpscare()
    end
end
