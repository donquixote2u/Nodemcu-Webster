-- webserver - receive data via POST and show in webpage
-- also forward to Thingspeak if reeived arg is in TS field table
-- manifest; webster, webserver, TSClient, webclient, checkwifi 
-- Constants
SSID    = "98FM"
APPWD   = "potentiometer"
INTERVAL = 1200000
-- Some control variables
wifiTrys     = 0      -- Counter of trys to connect to wifi
NUMWIFITRYS  = 200    -- Maximum number of WIFI Testings while waiting for connection
-- restart every 20 minutes  BYPASSED 21/8/16
-- tmr.alarm(0, INTERVAL, 0, function() node.restart() end )
tmr.alarm( 1 , 2500 , 0 , function() dofile("webster.lua") end )
-- Drop through here to let NodeMcu run

