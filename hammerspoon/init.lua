local application = require "hs.application"
local window_manager = require('window_manager')
local connectivity = require('connectivity')
local util = require('util')

hyper = {"cmd", "alt", "ctrl"}

-- Window Key Bindings
hs.hotkey.bind(hyper, "Left", window_manager.windowHalfScreenLeft)
hs.hotkey.bind(hyper, "Right", window_manager.windowHalfScreenRight)
hs.hotkey.bind(hyper, "Up", window_manager.windowFullScreen)

--- Quick Open Applications
hs.hotkey.bind({"alt"}, "§", util.launchOrFocusApp("iTerm"))
hs.hotkey.bind({"alt"}, "1", util.launchOrFocusApp("Safari"))
hs.hotkey.bind({"alt"}, "2", util.launchOrFocusApp("Google Chrome Canary"))

--- show a little indicator when we lost internet
connectivity.setupMenubar()
