--[[ 
Loader For All Mys Scripts!
v1.0.0 
discord.gg/djMQRCNAAZ
discovery : mys.client
made by mys | @.mys_fr | 01xMYS
]] 
local SETTINGS = {
    GUI_NAME = "mys.loader",
    DISPLAY_ORDER = 99999,
    BLUR_SIZE = 45,
    BLUR_FADE_DURATION = 1.5,
    BRIGHTNESS_MIN = -10,
    BRIGHTNESS_DURATION = 2,
    CLOCK_TIME_VALUE = 6.2,
    CLOCK_TIME_DURATION = 3,
    INTRO_SOUND_ID = "rbxassetid://116271631941040",
    INTRO_SOUND_VOLUME = 2,
    HOVER_SOUND_ID = "rbxassetid://18755583152",
    HOVER_SOUND_VOLUME = 0.1,
    TITLE_TEXT = "Which Script Would You Like To Load?",
    TITLE_FONT = Enum.Font.GothamBold,
    TITLE_TEXT_SIZE = 40,
    TITLE_TEXT_COLOR = Color3.new(1, 1, 1),
    TITLE_POSITION = UDim2.new(0.5, 0, 0.25, 0),
    TITLE_SIZE = UDim2.new(0, 600, 0, 60),
    BUTTON_FONT = Enum.Font.SourceSansBold,
    BUTTON_TEXT_SIZE = 22,
    BUTTON_TEXT_COLOR = Color3.new(1, 1, 1),
    BUTTON_BG_COLOR = Color3.fromRGB(5, 5, 5),
    BUTTON_SIZE = UDim2.new(0, 200, 0, 50),
    BUTTON_CORNER_RADIUS = UDim.new(0, 8),
    BUTTON_HOVER_SCALE = UDim2.new(0, 30, 0, -6),
    BUTTON_HOVER_TEXT_SCALE = 4,
    BUTTON_ANIMATION_DURATION = 1,
    BUTTON_FADE_DURATION = 1.2,
    BUTTON_GROW_DURATION = 1,
    BUTTON_MOVE_DURATION = 1,
    BUTTON_SECONDARY_POSITION = UDim2.new(0.497, 0, 0.320, 0),
    TITLE_FADE_DURATION = 0.4,
    VERSION_FADE_DURATION = 0.8,
    SECONDARY_BUTTON_FADE_DURATION = 1.2,
    SECONDARY_BUTTON_BG_TRANSPARENCY = 0.3,
    VERSION_VISIBLE_TRANSPARENCY = 0.4,
    MAX_STARS = 250,
    STAR_MOVE_SPEED = 0.02,
    STAR_SPARKLE_SPEED = 2,
    STAR_FADE_DURATION = 2,
}

local TS = game:GetService("TweenService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")
local plr = Players.LocalPlayer
local gui = game:GetService("CoreGui")

local scr = Instance.new("ScreenGui")
scr.Name = SETTINGS.GUI_NAME
scr.IgnoreGuiInset = true
scr.DisplayOrder = SETTINGS.DISPLAY_ORDER
scr.Parent = gui

local hov = Instance.new("Sound")
hov.Name = "HoverSound"
hov.SoundId = SETTINGS.HOVER_SOUND_ID
hov.Volume = SETTINGS.HOVER_SOUND_VOLUME
hov.Parent = scr

local function introSound(parent)
    local s = Instance.new("Sound")
    s.Name = "IntroSound"
    s.SoundId = SETTINGS.INTRO_SOUND_ID
    s.Volume = SETTINGS.INTRO_SOUND_VOLUME
    s.Parent = parent
    pcall(function() SoundService:PlayLocalSound(s) end)
    s.Ended:Connect(function() pcall(function() s:Destroy() end) end)
end

local function createTween(instance, properties, duration, style, direction)
    style = style or Enum.EasingStyle.Sine
    direction = direction or Enum.EasingDirection.InOut
    local tween = TS:Create(instance, TweenInfo.new(duration, style, direction), properties)
    pcall(function() tween:Play() end)
    return tween
end

local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = Lighting
local originalBrightness, originalClockTime = Lighting.Brightness, Lighting.ClockTime
local blurTween = createTween(blur, {Size = SETTINGS.BLUR_SIZE}, 1.2)
local brightnessTween = createTween(Lighting, {Brightness = SETTINGS.BRIGHTNESS_MIN}, SETTINGS.BRIGHTNESS_DURATION)
createTween(Lighting, {ClockTime = SETTINGS.CLOCK_TIME_VALUE}, SETTINGS.CLOCK_TIME_DURATION, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)

local frm = Instance.new("Frame")
frm.Size = UDim2.new(1, 0, 1, 0)
frm.Position = UDim2.new(0.5, 0, 0.5, 0)
frm.AnchorPoint = Vector2.new(0.5, 0.5)
frm.BackgroundTransparency = 1
frm.Parent = scr

local ttl = Instance.new("TextLabel")
ttl.Text = SETTINGS.TITLE_TEXT
ttl.Font = SETTINGS.TITLE_FONT
ttl.TextSize = SETTINGS.TITLE_TEXT_SIZE
ttl.TextColor3 = SETTINGS.TITLE_TEXT_COLOR
ttl.AnchorPoint = Vector2.new(0.5, 0)
ttl.Position = SETTINGS.TITLE_POSITION
ttl.BackgroundTransparency = 1
ttl.Size = SETTINGS.TITLE_SIZE
ttl.TextTransparency = 1
ttl.Parent = frm

local version = Instance.new("TextLabel")
version.Text = "V1.0.0"
version.Font = SETTINGS.TITLE_FONT
version.TextSize = 14
version.TextColor3 = SETTINGS.TITLE_TEXT_COLOR
version.TextTransparency = 1
version.BackgroundTransparency = 1
version.AnchorPoint = Vector2.new(1, 1)
version.Position = UDim2.new(1, 85, 1, -10)
version.Size = UDim2.new(0, 100, 0, 20)
version.TextXAlignment = Enum.TextXAlignment.Right
version.TextYAlignment = Enum.TextYAlignment.Bottom
version.Parent = ttl

local _stars = {}
local _holder = Instance.new("Frame")
_holder.Size = UDim2.new(1, 0, 1, 0)
_holder.BackgroundTransparency = 1
_holder.ClipsDescendants = true
_holder.ZIndex = 0
_holder.Parent = frm

for i = 1, SETTINGS.MAX_STARS do
    local star = Instance.new("Frame")
    star.Size = UDim2.new(0, 1.5, 0, 1.5)
    local x, y = math.random(), math.random()
    local direction = Vector2.new(math.random(-100, 100), math.random(-100, 100)).Unit * SETTINGS.STAR_MOVE_SPEED
    star.Position = UDim2.new(x, 0, y, 0)
    star.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    star.BackgroundTransparency = 0
    star.BorderSizePixel = 0
    star.ZIndex = 1
    star.Visible = true
    star.Parent = _holder
    table.insert(_stars, {
        frame = star,
        pos = Vector2.new(x, y),
        direction = direction,
        sparkleOffset = math.random() * math.pi * 2
    })
end

RunService.RenderStepped:Connect(function(deltaTime)
    for _, star in ipairs(_stars) do
        if star.frame.Visible then
            star.pos = star.pos + star.direction * deltaTime
            if star.pos.X < 0 or star.pos.X > 1 or star.pos.Y < 0 or star.pos.Y > 1 then
                star.pos = Vector2.new(math.random(), math.random())
                star.direction = Vector2.new(math.random(-100, 100), math.random(-100, 100)).Unit * SETTINGS.STAR_MOVE_SPEED
                star.sparkleOffset = math.random() * math.pi * 2
            end
            local sparkle = math.abs(math.sin(tick() * SETTINGS.STAR_SPARKLE_SPEED + star.sparkleOffset))
            star.frame.BackgroundTransparency = 0.1 + sparkle * 0.7
            star.frame.Position = UDim2.new(star.pos.X, 0, star.pos.Y, 0)
        end
    end
end)

local function hover(button)
    local originalSize, originalTextSize = button.Size, button.TextSize
    button.MouseEnter:Connect(function()
        createTween(button, {Size = originalSize + SETTINGS.BUTTON_HOVER_SCALE, TextSize = originalTextSize + SETTINGS.BUTTON_HOVER_TEXT_SCALE}, 0.25, Enum.EasingStyle.Quad)
        pcall(function()
            if hov.IsLoaded then hov:Play() else hov.Loaded:Wait() hov:Play() end
        end)
    end)
    button.MouseLeave:Connect(function()
        createTween(button, {Size = originalSize, TextSize = originalTextSize}, 0.25, Enum.EasingStyle.Quad)
    end)
end

local function createButton(text, position, callback)
    local b = Instance.new("TextButton")
    b.Text = text
    b.Font = SETTINGS.BUTTON_FONT
    b.TextSize = SETTINGS.BUTTON_TEXT_SIZE
    b.TextColor3 = SETTINGS.BUTTON_TEXT_COLOR
    b.BackgroundColor3 = SETTINGS.BUTTON_BG_COLOR
    b.Size = SETTINGS.BUTTON_SIZE
    b.Position = position
    b.AnchorPoint = Vector2.new(0.5, 0.5)
    b.AutoButtonColor = false
    b.BackgroundTransparency = 1
    b.TextTransparency = 1
    local corner = Instance.new("UICorner")
    corner.CornerRadius = SETTINGS.BUTTON_CORNER_RADIUS
    corner.Parent = b
    b.Parent = frm
    hover(b)

    b.MouseButton1Click:Connect(function()
        pcall(function()
            
            for _, c in frm:GetChildren() do
                if c:IsA("TextButton") then c.Active = false end
            end

            createTween(ttl, {TextTransparency = 1}, SETTINGS.TITLE_FADE_DURATION)
            createTween(version, {TextTransparency = 1}, SETTINGS.VERSION_FADE_DURATION)

            for _, c in frm:GetChildren() do
                if c:IsA("TextButton") and c ~= b then
                    createTween(c, {TextTransparency = 1, BackgroundTransparency = 1}, SETTINGS.BUTTON_FADE_DURATION)
                end
            end

            for _, star in ipairs(_stars) do
                createTween(star.frame, {BackgroundTransparency = 1}, SETTINGS.STAR_FADE_DURATION)
                star.frame.Visible = false
            end

            task.wait(SETTINGS.BUTTON_FADE_DURATION)

            createTween(b, {Position = UDim2.new(0.5, 0, 0.5, 0), BackgroundTransparency = 1, TextSize = 16}, SETTINGS.BUTTON_MOVE_DURATION, Enum.EasingStyle.Quint)
            task.wait(SETTINGS.BUTTON_MOVE_DURATION)
            createTween(b, {Size = b.Size + UDim2.new(0, 20, 0, 10)}, SETTINGS.BUTTON_GROW_DURATION)
            task.wait(SETTINGS.BUTTON_GROW_DURATION)
            local finalMove = createTween(b, {Position = SETTINGS.BUTTON_SECONDARY_POSITION}, SETTINGS.BUTTON_FADE_DURATION, Enum.EasingStyle.Quint)
            finalMove.Completed:Wait()
            task.wait(1)
            createTween(b, {TextTransparency = 1}, SETTINGS.BUTTON_FADE_DURATION)

            pcall(callback)

            local blurOut = createTween(blur, {Size = 0}, SETTINGS.BLUR_FADE_DURATION)
            local brightnessOut = createTween(Lighting, {Brightness = originalBrightness}, SETTINGS.BLUR_FADE_DURATION)
            createTween(Lighting, {ClockTime = originalClockTime}, SETTINGS.CLOCK_TIME_DURATION)
            task.wait(SETTINGS.BLUR_FADE_DURATION)

            
            for _, c in frm:GetChildren() do
                if c:IsA("TextButton") then pcall(function() c:Destroy() end) end
            end
            if blur.Parent then pcall(function() blur:Destroy() end) end
            if scr.Parent then pcall(function() scr:Destroy() end) end
        end)
    end)
    return b
end

local b1 = createButton("mys.client", UDim2.new(0.5, -150, 0.5, 50), function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/mysisnotreal/micup/refs/heads/main/mys.client/v7.6.2"))()
    end)
end)
local b2 = createButton("mys.aim | COMING SOON", UDim2.new(0.5, 150, 0.5, 50), function() end)

task.spawn(function()
    blurTween.Completed:Wait()
    createTween(ttl, {TextTransparency = 0}, SETTINGS.TITLE_FADE_DURATION)
    createTween(version, {TextTransparency = SETTINGS.VERSION_VISIBLE_TRANSPARENCY}, SETTINGS.VERSION_FADE_DURATION)
    task.wait(0.4)
    createTween(b1, {TextTransparency = 0, BackgroundTransparency = 0.2}, SETTINGS.BUTTON_FADE_DURATION)
    task.wait(0.2)
    createTween(b2, {TextTransparency = 0, BackgroundTransparency = SETTINGS.SECONDARY_BUTTON_BG_TRANSPARENCY}, SETTINGS.SECONDARY_BUTTON_FADE_DURATION)
end)

plr.AncestryChanged:Connect(function(_, parent)
    if not parent then
        if blur.Parent then pcall(function() blur:Destroy() end) end
        if scr.Parent then pcall(function() scr:Destroy() end) end
    end
end)

task.wait(1.3)
introSound(scr)
