-- build request url, send to Thingspeak via webclient
-- this func called if data passed by serial console
function urlBuild(urlkey,keyval)
DATA[urlkey]=keyval
POSTED[urlkey]=false
end

function sendData()
setServer("IP","184.106.153.149") -- set address
setServer("NAME","api.Thingspeak.com")-- set host
setServer("SUBDIR","update") -- set dir
-- add only valid TS fields to GET request
REQ=""
for k, v in pairs(DATA) do -- get url GET params
 if (FieldName[k]~=nil) and (POSTED[k]~=true) then -- if field in table, use its index as field number
    POSTED[k]=true
    REQ = REQ.."&"..FieldName[k].."="..v
 -- else print("skip:"..k..":"..v)   
 end
end
if(REQ~="") then
  REQ = REQ.."&"..APIKEY
  sendReq() -- send data in url to Thingspeak
end
tmr.alarm( 3, INTERVAL, 1, sendData)    -- reschedule send    
end
--=================================
dofile("webclient.lua") -- load std webclient routines
serverParm={} -- connection params  for REMOTE server
DATA={} -- key/value pairs received by web server OR console
POSTED={}  --  array tracking TS send status of DATA
FieldName={}  -- filed xlate table for Thingspeak url arguments 
FieldName["TempOut"]="field1"
FieldName["Pressure"]="field2"
FieldName["BattVolts"]="field5"
FieldName["SolarVolts"]="field6"
FieldName["Humidity"]="field7"
FieldName["Rainfall"]="field8"
-- "fields" only req while old Barograph calls still in place
FieldName["field1"]="field1" 
FieldName["field2"]="field2"
APIKEY="api_key=TIWBBVWTOW0KPWL0"

