--- timeserver api contacts a timeserver computer in the world, and requests the current time
-- This API was just a test of how modems worked, it really should not be used.
-- @module[kind=skyos] timeserver

local modem = peripheral.find("modem")

--- channel that requests to the timeserver are sent on
local tsSend = 27793
 
local pcReturn = math.random(30000,40000)
if modem then
  modem.open(pcReturn)
end

local ts = {}
 
--- get simply contacts the timeserver, and returns what the timeserver sends back.
-- @tparam number offset offset in hours for the time
-- @treturn table table containing: [1] contents of os.date() with the offset, [2] string with HH:MM, [3] string with HH:MM:SS
function ts.get(offset)
  if not SkyOS.settings.timeServerEnabled or not modem then
    local epoch = math.floor(os.epoch("utc") / 1000) + (3600 * SkyOS.settings.timeZone) 
    local t = os.date("!*t", epoch)
    return {t,tostring(t.hour) .. ":" .. tostring(t.min) .. ":" .. tostring(t.sec),tostring(t.hour) .. ":" .. tostring(t.min)}
  end
  modem.transmit(tsSend,pcReturn,offset)
  local _,_,_,_,msg = os.pullEvent("modem_message")
  return msg
end
 
return ts