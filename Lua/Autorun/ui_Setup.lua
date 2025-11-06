if CLIENT then return end -- We don't have anything we wanna run on client

MyModGlobal = {}
MyModGlobal.Path = ... -- Store path to mod folder globally

uiFunctions = dofile(MyModGlobal.Path .. "/Lua/ui_functions.lua") -- Global object that has all functions as methods
dofile(MyModGlobal.Path .. "/Lua/ui_hooks.lua") -- Load hooks