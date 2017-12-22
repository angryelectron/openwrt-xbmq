m = Map("xbmq", "XBMQ Configuration")
d = m:section(TypedSection, "xbmq")

a = d:option(Value, "rootTopic", "Root Topic"); a.optional=false; a.rmempty=false;
a = d:option(Value, "broker", "MQTT Broker"); a.optional=false; a.rmempty=false;
a = d:option(Value, "username", "MQTT Username", "Leave blank if not required by broker"); a.optional=false; a.rmempty=true;
a = d:option(Value, "password", "MQTT Password", "Leave blank if not required by broker"); a.optional=false; a.rmempty=true;

a = d:option(ListValue, "port", "XBee Serial Port")
ports = luci.sys.exec("ls /dev/ttyUSB*") 
for port in ports:gmatch("%S+") do 
  a:value(port, port)
end

a = d:option(Value, "baud", "XBee Baud Rate"); a.optional=false; a.rmempty=false;

a = d:option(ListValue, "apiMode", "XBee API Mode", "Must match the local XBee's AP setting"); 
a.optional = false 
a.rmempty = false
a.default = 2
a:value(2, translate("2 - With Escapes"))        
a:value(1, translate("1 - Without Escapes"))       

a = d:option(Value, "log", "Logfile Name"); a.optional=false; a.rmempty=false;

a = d:option(ListValue, "loglevel", "Logfile verbosity level") 
a.optional = false 
a.rmempty = false
a.default = "info"
a:value("error", "Error")
a:value("warn", "Warning")
a:value("info", "Info")
a:value("verbose", "Verbose")
a:value("debug", "Debug")
a:value("silly", "Silly")

return m
