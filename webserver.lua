-- version 2 of webserver; accepts any GET var, displays
function init_webserver()
dofile("TSClient.lua") -- load Thingspeak send routines
print("starting webserver"); 
srv=net.createServer(net.TCP);
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
    local buf= "<h1>ESP8266 Web Server</h1>";
    getVars(client,request)
    for k, v in pairs(DATA) do
    -- see if received url args have matching ts field # 
    -- if FX[k]~=nil then -- if field in field index table, display it
        buf = buf.."<p>"..k.." : "..v.."</p>"
    -- end 
   end
   client:send(buf);
   client:close();
   collectgarbage();
   --   UPDATE THINGSPEAK  WITH DATA
   tmr.alarm( 3, 100, 0, update_history)
    end)
end)
end
--   UPDATE THINGSPEAK  WITH DATA
function update_history()
setServer("IP","184.106.153.149")
setServer("NAME","api.Thingspeak.com")
setServer("SUBDIR","update")
urlBuild("api_key","TIWBBVWTOW0KPWL0")
sendTS() -- sends all data in _GET table    
end
-- EXTRACT GET VARS
function getVars(client,request)
local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
if(method == nil)then
    _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
    end
if (vars ~= nil)then
    for k,v in string.gmatch(vars, '([^&=?]-)=([^&=?]+)' ) do
    -- for k, v in string.gmatch(vars, "(%w.+)=(%w.+)&*") do
        DATA[k] = v
        POSTED[k] = false
        print("k="..k..";v="..v)
        end
    end    
end 

-- STARTS HERE --
DATA={} -- GET key/value pairs received by web server OR console
POSTED={}  --  array tracking TS send status of DATA
ipAddr = wifi.sta.getip()
if ( ( ipAddr == nil ) or ( ipAddr == "0.0.0.0" ) ) then
   tmr.alarm( 1 , 200 , 0 , function() dofile("checkwifi.lua") end)
end   
tmr.alarm( 2 , 2500 , 0 ,  function() init_webserver(); end)
tmr.alarm( 3, INTERVAL, 1, update_history) 


