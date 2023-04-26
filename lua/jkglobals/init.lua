---- jkglobals.init.lua ----
local J = {}
----------------------------

---@class JKGlobal
_G.jk = {}

jk.table_elves = require'jkglobals.table-elves'

jk.vs = vim.fn.exists'vscode' ---@type boolean

jk.using_config = [[]]

jk.headers = { fonts = require 'jkglobals.header-fonts' }


----------------------------
return J
----------------------------
