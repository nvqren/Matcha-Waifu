# Waifu UI

Waifu UI is a single-file user interface library for the Matcha executor. It uses the Drawing API to render all elements. You paste the code directly into your script. The library runs inside a dedicated loop and cleans up when you unload it.

## Quick Start

Paste the code into your script or load it using loadstring. Here is how you initialize a basic window and add elements.

```lua
local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/nvqren/Matcha-Waifu/refs/heads/main/WaifuUI.lua"))()

local main = UI:Tab("Main")
local aim = main:Section("Aimbot")
aim:Toggle("Enabled", true, function(v) print("Aimbot:", v) end)
aim:Slider("Smoothness", 10, 1, 1, 50, "%")

local esp = main:Section("ESP")
local boxToggle = esp:Toggle("Box ESP", false)
boxToggle:AddColorpicker("Color", Color3.fromRGB(0, 200, 255))
boxToggle:AddKeybind("v", "Toggle", true)

boxToggle:DependsOn(aim)
```

Test all controls at once by running this function.

```lua
UI:Demo()
```

Press F1 to open and close the menu.

## Controls Style

You can change the style of the window title bar controls. You choose between macOS traffic lights, Windows buttons, Linux minimal circles, or custom layouts. Pass the style name to UI:SetWindowControlsStyle.

```lua
-- Apply macOS traffic lights (default)
UI:SetWindowControlsStyle("macOS")

-- Apply Windows rect buttons
UI:SetWindowControlsStyle("Windows")

-- Apply Linux circular outlines
UI:SetWindowControlsStyle("Linux")

-- Apply a Custom layout
UI:SetWindowControlsStyle("Custom", {
    align = "left",
    closeColor = Color3.fromRGB(255, 95, 87),
    minColor = Color3.fromRGB(255, 189, 46),
    restoreColor = Color3.fromRGB(39, 201, 63)
})
```

The custom style options let you define the button alignment on the title bar and assign individual colors to each control. Set the align field to left or right. Pass Color3 values to closeColor, minColor, and restoreColor fields to style the buttons.

## API Reference

### Menu Controls

| Method | Returns | Description |
|--------|---------|-------------|
| UI:Tab(name) | Tab | Creates a new tab. The UI selects the first tab by default. |
| UI:SetTitle(str) | UI | Sets the window title. |
| UI:SetPos(x, y) | UI | Changes the window position. |
| UI:SetSize(w, h) | UI | Sets the window size. The window clamps at 300 by 120. |
| UI:Center() | UI | Places the window in the center of your screen. |
| UI:SetWindowControlsStyle(style, options) | UI | Sets the title bar buttons style. Select macOS, Windows, Linux, or Custom. |
| UI:RegisterActivity(fn) | Table | Runs your function every frame. The watermark displays the string you return. |
| UI:CreateSettingsTab(name) | Tab | Creates the settings tab. This tab manages themes, keybinds, watermarks, and diagnostics. |
| UI:AddThemePreset(name, colors) | UI | Registers your theme colors to the preset list. |
| UI:IsOpen() | boolean | Returns true if the menu is open. |
| UI:SetOpen(bool) | UI | Opens or closes the menu. |
| UI:SetMenuKey(key) | UI | Updates the toggle key. You pass a string key name or a number code. |
| UI:GetValue(path) | any | Returns the value of a control. Use TabName.SectionName.ControlName format. |
| UI:SetValue(path, val) | UI | Sets the control value and runs the callback function. |
| UI:GetDrawing(kind) | Drawing | Borrows a pooled drawing object from the library. |
| UI:Destroy() | UI | Stops the draw loop, hides all drawings, and restores game input. |
| UI:Unload() | UI | Unloads the menu. This works exactly like the Destroy method. |
| UI:Demo() | UI | Opens a demo tab so you can test every control. |

### Tabs

| Method | Returns | Description |
|--------|---------|-------------|
| tab:Section(name) | Section | Adds a collapsible section to your tab. |

### Section Controls

| Method | Returns | Description |
|--------|---------|-------------|
| sec:Toggle(label, default, callback, unsafe, tooltip) | Item | Adds a toggle switch. The knob slides smoothly. Set unsafe to true to color the label yellow. |
| sec:Slider(label, default, step, min, max, suffix, callback) | Item | Adds a draggable slider bar. Right-click to type a number. Shift and right-click to reset it. |
| sec:Dropdown(label, default, choices, multi, callback) | Item | Adds a single or multi selection list. Navigate the list with arrow keys and PageUp or PageDown. |
| sec:Button(label, callback) | Item | Adds a clickable button. |
| sec:Textbox(label, default, callback) | Item | Adds a text input field. |
| sec:Label(label, color) | LabelHandle | Displays read-only text. |
| sec:Divider(label) | Item | Draws a separation line. The label text centers above the line if you provide it. |

### Item Modifiers

Use these modifiers on Toggle items.

| Method | Returns | Description |
|--------|---------|-------------|
| item:AddKeybind(defaultKey, mode, canChange, callback) | KeyHandle | Binds a key to the toggle. Modes include Hold, Toggle, and Always. Right-click the bind to select a mode. |
| item:AddColorpicker(label, default, overwrite, callback) | ColorHandle | Adds a color picker. Set overwrite to true to tint the toggle text. The picker accepts hex codes and clipboard pasting. |

Use these modifiers on any control that stores a value. This includes Toggles, Sliders, Dropdowns, and Textboxes.

| Method | Description |
|--------|-------------|
| item:Set(newValue) | Sets the control to a new value and fires the callback function. |
| item:DependsOn(toggleHandle) | Dims the control and disables input when your target toggle is off. |

KeyHandle methods.

| Method | Description |
|--------|-------------|
| key:Set(newKey, newMode) | Updates the bound key and changes the activation mode. |

ColorHandle methods.

| Method | Description |
|--------|-------------|
| color:Set(newColor) | Updates the active color. |

LabelHandle methods.

| Method | Description |
|--------|-------------|
| label:Set(newText) | Updates the display text. |
| label:SetColor(newColor) | Updates the text color. |

## How You Interact with the UI

Open the search feature by clicking the magnifying glass icon in the title bar. Type your query to filter controls across all tabs and sections. Press Enter or Esc to close the search window.

Collapse sections by clicking their headers. The UI draws a chevron to show the status.

Type slider values directly. Right-click a slider, type your exact value, and press Enter to save. Press Esc to cancel. Shift and right-click to restore the default value.

The pill background and toggle knob slide with frame-rate-independent smoothing.

The UI dims dependent controls and blocks their input when you chain the DependsOn method. Dimmed controls turn forty percent transparent.

Resize the window by dragging the diagonal grip in the bottom-right corner. The window refuses to shrink below 300 by 120.

Click and drag the scrollbar thumb to scroll. The scrollbar stays locked to your mouse even if your cursor leaves the thumb.

Arrow buttons appear when you have too many tabs to fit on the screen. The tab bar scrolls smoothly and automatically brings your active tab into view.

## Overlays and Indicators

You can turn on a draggable watermark bar through the settings tab. The watermark displays your script title and stays visible even when you close the main menu.

The diagnostics overlay displays how many pooled drawing objects the library is currently using. This screen proves that the UI does not create new drawings every frame.

The drawing pool includes an image entry because the default waifu background uses undocumented image support in Matcha.

## Input and Navigation

- F1 opens and closes the menu.
- Click elements to interact with them.
- Right-click keybind boxes to change their mode.
- Right-click sliders to enter a value manually.
- Shift and right-click a slider to reset its value.
- Drag the title bar to move the window.
- Drag the scrollbar thumb to scroll.
- Navigate dropdowns and scroll content with arrow keys or PageUp and PageDown.
- Press Home to jump to the top or End to jump to the bottom.
- Press Left or Right arrow keys to switch tabs when you have no focused text input.
- Click the title bar buttons to close, minimize, or restore the window.

Opening the menu automatically blocks game input. Closing or unloading the menu restores control to Roblox.

Mouse-wheel scrolling does not work because Matcha cannot detect wheel input reliably in this loop.

## Styling and Themes

The UI defaults to macOS-style traffic lights in the top-left corner. You can change this style in the Settings tab.

You have access to these fonts:
- UI or ProggyClean
- System or San Francisco
- SystemBold or SF Bold
- Minecraft
- Monospace or JetBrains Mono
- Pixel
- Fortnite

Built-in presets include Apple Blue, Gamesense, Cyberpunk, Sakura, Monochrome, and Matcha Waifu.

## Customize the Title and Themes

You can change the menu title at any time. Pass your new title string to the SetTitle method.

```lua
UI:SetTitle("My Custom Script")
```

Create your own custom theme by defining a color table. Pass this table to UI:SetTheme to apply the colors immediately. Alternatively, pass the name and table to UI:AddThemePreset to register the theme. Registered themes appear in the Settings tab dropdown.

You do not need to supply every color key. A partial table only updates the specific colors you define.

This example creates and applies a custom neon theme.

```lua
local myTheme = {
    bg = Color3.fromRGB(10, 10, 15),
    surface = Color3.fromRGB(20, 20, 30),
    accent = Color3.fromRGB(0, 255, 200),
    text = Color3.fromRGB(240, 240, 250)
}

UI:SetTheme(myTheme)
```

To register this theme as a preset named Neon, do this.

```lua
UI:AddThemePreset("Neon", myTheme)
```

### Theme Keys

| Key | Used For |
|-----|----------|
| bg | Window background |
| surface | Window body |
| surface2 | Tab bar and content area |
| surface3 | Hover backgrounds |
| text | Main text |
| sub | Headers and secondary text |
| accent | Active tab, slider bar, and focused borders |
| border | Outlines |
| toggleOn | Toggle on state |
| toggleOff | Toggle off state |
| knob | Toggle knob |
| green | Success indicators |
| red | Close button |
| yellow | Minimize button |
| unsafe | Warning labels |
| white | Utility white |
| black | Shadows and tooltips |

## Safety and Errors

- The UI wraps your callbacks in a safe call handler. The library displays a warning if your code errors but keeps running.
- The draw loop runs inside a safe call. If a critical error occurs, the script hides all drawing elements and restores Roblox input.
- The UI terminates itself after three consecutive errors to prevent stuck drawing elements.
- The Unload method disconnects the loop, removes all drawings, deletes the waifu image, and restores game input.

## Custom Drawings

Borrow a pooled drawing object using the GetDrawing method. You must set every property on this object every frame because the pool reuses drawings.

Drawing pool categories:
- sq - Square
- tx - Text
- ln - Line
- ci - Circle
- tr - Triangle
- im - Image, used for the waifu background
