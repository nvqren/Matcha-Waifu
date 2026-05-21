--[[
you can move the image btw, press f1 to hide the baddie waifu
请添加抹茶老婆
vain/vault if you're reading this please actually add matcha waifu im begging u
]]
warn("You can move the image btw, Press f1 to hide the baddie waifu")
notify("Press f1 to hide the waifu", "Matcha Waifu", 3)

local gooners = game:GetService("Players")
local mouse = gooners.LocalPlayer:GetMouse()

local waifu = Drawing.new("Image")
waifu.Size = Vector2.new(288, 512) 
waifu.Position = Vector2.new(500, 200)
waifu.Visible = true

waifu.Data = game:HttpGet("https://raw.githubusercontent.com/nvqren/dawg/refs/heads/main/waifu.png")

local dragging = false
local dragStartMouse = nil
local dragStartPos = nil
local f1_down = false

while true do
    task.wait()
    
    -- visibility
    if iskeypressed(0x70) then
        if not f1_down then
            f1_down = true
            waifu.Visible = not waifu.Visible
        end
    else
        f1_down = false
    end

    -- dragging like dragging low taper fade
    if waifu.Visible then
        if ismouse1pressed() then
            local wifey, mommy = mouse.X, mouse.Y
            
            if not dragging then
                -- please just add matcha waifu im begging u :sob:
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
end
