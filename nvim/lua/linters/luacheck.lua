-- Lua and luacheck have been installed in the OS and added to PATH
local lint = require("lint")

lint.linters.luacheck = {
    cmd = "luacheck",
}

return lint.linters.luacheck
