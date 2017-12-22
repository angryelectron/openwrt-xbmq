module("luci.controller.xbmq.xbmq", package.seeall)

function index()
	entry({"admin", "xbmq"}, firstchild(), _("XBMQ"), 80);
	entry({"admin", "xbmq", "console"}, call("action_console"), "Console", 1) 
	entry({"admin", "xbmq", "config"}, cbi("xbmq/xbmq"), "Configuration", 2) 
	entry({"admin", "xbmq", "log"}, call("action_log"), "Log", 3) 

	entry({"admin", "xbmq", "start"}, call("action_start")) 
	entry({"admin", "xbmq", "stop"}, call("action_stop")) 
	entry({"admin", "xbmq", "restart"}, call("action_restart")) 
	entry({"admin", "xbmq", "status"}, call("action_status")) 
	entry({"admin", "xbmq", "log", "clear"}, call("action_clearlog")) 
	entry({"admin", "xbmq", "signal"}, call("action_signal")) 
end

function action_start()
	local result = luci.sys.exec("/etc/init.d/xbmq start") 
	luci.http.prepare_content("text/plain")
	luci.http.write(result)
end

function action_stop()
	local result = luci.sys.exec("/etc/init.d/xbmq stop") 
	luci.http.prepare_content("text/plain")
	luci.http.write(result)
end

function action_restart()
	local result = luci.sys.exec("/etc/init.d/xbmq restart") 
	luci.http.prepare_content("text/plain")
	luci.http.write(result)
end

function action_status()
	local result = luci.sys.exec("/etc/init.d/xbmq status") 
	luci.http.prepare_content("text/plain")
	luci.http.write(result)
end

function action_log()
	local logfile = luci.model.uci.cursor():get("xbmq", "settings", "log") 
	luci.template.render("xbmq/log", {logfile=logfile})
end

function action_clearlog()
	local logfile = luci.model.uci.cursor():get("xbmq", "settings", "log") 
	luci.sys.exec("echo > " .. logfile)
	luci.http.redirect("../log")
end

function action_signal()
	local result = luci.sys.exec("gcom -d /dev/ttyUSB3")	
	luci.http.prepare_content("text/richtext")
	luci.http.write(result)
end

function action_console()
	local version = luci.sys.exec('grep \\"version /usr/lib/node_modules/xbmq/package.json')	
	luci.template.render("xbmq/console", {version=version})
end
