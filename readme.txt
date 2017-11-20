Webster is an ESP8266 (Nodemcu firmware) combination web server and web client.

The webserver accepts any GET request . stores the GET arguments
and displays any data supplied in the GET arguments as an html web page
ias GET arg name / arg value pairs. so a GET arg of field1=123.4 would display
field1:123.4 on the page.

The web client receives commands via serial console;
The commands set up a request to Thingspeak (for forwarding data)
see sample webclients commands for further details.
