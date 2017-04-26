hyper = {"cmd", "alt", "ctrl"}

function windowHalfScreenLeft()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end

function windowHalfScreenRight()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end

function windowFullScreen()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
end

-- Window Hints
hs.hints.style = 'vimperator'

-- Key Bindings
hs.hotkey.bind(hyper, "Left", windowHalfScreenLeft)
hs.hotkey.bind(hyper, "Right", windowHalfScreenRight)
hs.hotkey.bind(hyper, "Up", windowFullScreen)
hs.hotkey.bind(hyper, "L", hs.caffeinate.lockScreen)
hs.hotkey.bind(hyper, "S", "Show window hints", hs.hints.windowHints)
