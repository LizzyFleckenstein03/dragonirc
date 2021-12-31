#! /usr/bin/env lua
-- load IRC
package.path = "luairc/src/?.lua;" .. package.path
irc = require("irc")

-- load luax
require("luax")

-- load lua_async
require("lua_async")("lua_async")

-- load cutie
cutie = require("cutie")

-- export global table
dragonirc = EventTarget()

-- config
dragonirc.config = {
	colors = {
		error = "#ED254E",
	}
}

-- load files
dofile("splashscreen.lua")
dofile("main.lua")
dofile("input.lua")
dofile("commands.lua")

-- run
async(dragonirc.main)()
lua_async.run()
