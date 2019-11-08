-- Inspired by https://github.com/victorso/.hammerspoon/blob/master/tools/clipboard.lua
local frequency = 10
local hist_size = 20
local label_length = 70
local honor_clearcontent = true
local pasteOnSelect = false

local jumpcut = hs.menubar.new()
jumpcut:setTooltip("Clipboard History")

local pasteboard = require("hs.pasteboard")
local settings = require("hs.settings")
local last_change = pasteboard.changeCount()

local clipboard_history = settings.get("so.victor.hs.jumpcut") or {}

function putOnPaste(string,key)
   if (pasteOnSelect) then
      hs.eventtap.keyStrokes(string)
      pasteboard.setContents(string)
      last_change = pasteboard.changeCount()
   else
      if (key.alt == true) then
         hs.eventtap.keyStrokes(string)
      else
         pasteboard.setContents(string)
         last_change = pasteboard.changeCount()
      end
   end
end

function clearAll()
   pasteboard.clearContents()
   clipboard_history = {}
   settings.set("so.victor.hs.jumpcut",clipboard_history)
   now = pasteboard.changeCount()
end

function clearLastItem()
   table.remove(clipboard_history,#clipboard_history)
   settings.set("so.victor.hs.jumpcut",clipboard_history)
   now = pasteboard.changeCount()
end

function pasteboardToClipboard(item)
   while (#clipboard_history >= hist_size) do
      table.remove(clipboard_history,1)
   end
   table.insert(clipboard_history, item)
   settings.set("so.victor.hs.jumpcut",clipboard_history)
end

populateMenu = function(key)
   menuData = {}

   if (#clipboard_history == 0) then
      table.insert(menuData, {title="None", disabled = true})
   else
      for k,v in pairs(clipboard_history) do
         if (string.len(v) > label_length) then
            table.insert(menuData,1, {title=string.sub(v,0,label_length).."…", fn = function() putOnPaste(v,key) end })
         else
            table.insert(menuData,1, {title=v, fn = function() putOnPaste(v,key) end })
         end
      end
   end

   table.insert(menuData, {title="-"})
   table.insert(menuData, {title="Clear All", fn = function() clearAll() end })

   if (key.alt == true or pasteOnSelect) then
      table.insert(menuData, {title="Direct Paste Mode ✍", disabled=true})
   end

   return menuData
end

function storeCopy()
   now = pasteboard.changeCount()
   if (now > last_change) then
      current_clipboard = pasteboard.getContents()
      if (current_clipboard == nil and honor_clearcontent) then
          clearAll()
      else
         pasteboardToClipboard(current_clipboard)
      end
      last_change = now
   end
end

timer = hs.timer.new(frequency, storeCopy)
timer:start()

jumpcut:setTitle("✂")
jumpcut:setMenu(populateMenu)
