-- webserver + Thingspeak forward
dofile("TSClient.lua") --load client routines
-- check connected, ifnot then connect
ipAddr = wifi.sta.getip()
if ( ( ipAddr == nil ) or ( ipAddr == "0.0.0.0" ) ) then
   tmr.alarm( 1 , 200 , 0 , function() dofile("checkwifi.lua") end)
end
-- wait a bit, then start web server
tmr.alarm( 2 , 3500 , 0 ,  function() dofile("dualserver.lua")  end)
-- schedule send of any data received by webserver or console 
tmr.alarm( 3, INTERVAL, 1, sendData) 




