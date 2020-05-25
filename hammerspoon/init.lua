local application = require "hs.application"
local window_manager = require('window_manager')
local util = require('util')

hyper = {"alt", "ctrl", "cmd"}

-- Window Key Bindings
hs.hotkey.bind(hyper, "Left", window_manager.windowHalfScreenLeft)
hs.hotkey.bind(hyper, "Right", window_manager.windowHalfScreenRight)
hs.hotkey.bind(hyper, "Up", window_manager.windowFullScreen)

--- Quick Open Applications
hs.hotkey.bind({"alt", "ctrl"}, "1", util.launchOrFocusApp("Terminal"))
hs.hotkey.bind({"alt", "ctrl"}, "2", util.launchOrFocusApp("Safari"))

-- Focus next screen, move mouse to center of next screen
hs.hotkey.bind({"alt"}, "j", window_manager.focusNextScreen)
