function launchOrFocusApp(name)
  return function()
    hs.application.launchOrFocus(name)
    if name == 'Finder' then
      hs.appfinder.appFromName(name):activate()
    end
  end
end

return {
  launchOrFocusApp = launchOrFocusApp
}
