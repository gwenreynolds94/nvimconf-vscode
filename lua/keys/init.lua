--- ░█▄▀░██▀░▀▄▀░▄▀▀░░░▄▀░░█░░░▄▀▄░██▄░▄▀▄░█░░░░░█░░░█░█░▄▀▄░
--- ░█░█░█▄▄░░█░░▄██░▄░▀▄█░█▄▄░▀▄▀░█▄█░█▀█░█▄▄░▄░█▄▄░▀▄█░█▀█░
--- ----
---@class JKKeys
local K = {
    after = require'keys.after'
}

local fn = vim.fn

---@alias VimKeymapFunc
---| fun(mode:string|string[], lfs:string, rhs:string|function, opts?:table)

---@type VimKeymapFunc
local keymap = vim.keymap.set

local ln, col = fn.line, fn.col

-------------------------------------------------------------------------------


local function hlgroup_from_cursor()
    local _stack, _names = vim.fn.synstack(ln'.', col'.'), {}
    for _, _id in ipairs(_stack) do
        tb.insert(_names, vim.fn.synIDattr(
            _id, "name"
        ))
    end
    return _names
end

---@param _postkeys string
---@param _rhs string|function
---@param _mode? string|string[]
---@param _opts? table
function K:leadermap(_postkeys, _rhs, _mode, _opts)
    _mode = _mode or { 'n' }
    _opts = _opts or {}
    keymap( _mode, [[<leader>]].._postkeys, _rhs, _opts)
end

function K:main()
    -- if jk.vs then
    --     vim.keymap.set('n', [[u]], [[<CMD>call VSCodeNotify('undo')<CR>]])
    --     vim.keymap.set('n', [[<C-r>]], [[<CMD>call VSCodeNotify('redo')<CR>]])
    -- end
    self.curhl = hlgroup_from_cursor
    keymap("n", [[,,]], [[@@]], {})
    -- keymap("n", [[,t]], [[<CMD>echo "Testing"<CR>]], {})
    self:leadermap("t", [[<CMD>echo "Testing"<CR>]])
    -- vim.api.keymap.set()
end


function K:init()
    self:main()
end

-------------------------------------------------------------------------------
return K
-------------------------------------------------------------------------------
