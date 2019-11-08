local menubar = hs.menubar.new()

hs.network.reachability.internet():setCallback(
  function(self, flags)
    if (flags & hs.network.reachability.flags.reachable) > 0 then
      menubar:setTitle("✓ Online")
      hs.timer.doAfter(3, function() menubar:setTitle("") end)
    else
      menubar:setTitle("✗ No Internet")
    end
  end
):start()
