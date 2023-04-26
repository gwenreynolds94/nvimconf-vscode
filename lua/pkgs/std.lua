---@class JKPkgsStandard
local S = {}

S.plugins = {
    'wbthomason/packer.nvim',
    insert = tb.insert
}

S.packer = {
    plugindir = vim.fn.stdpath'data' .. '/site/pack/packer/start/packer.nvim',
    giturl = 'https://github.com/wbthomason/packer.nvim',
    exists = function ( self ) ---@param self VSPackerConf
        return not (vim.fn.empty( vim.fn.glob( self.plugindir ) ) > 0)
    end,
    bootstrapped = false,
    bootstrap = function ( self ) ---@param self VSPackerConf
        self.bootstrapped = vim.fn.system {
            'git',
            'clone',
            '--depth',
            '1',
            self.giturl,
            self.plugindir,
        }
        return self.bootstrapped
    end,
    ready = function(self) ---@param self VSPackerConf
        local good_string =
            (type(self.bootstrapped) == 'string' and
            not self.bootstrapped:match[[^fatal]])
        local good_bool = type(self.bootstrapped) == 'boolean'
        return (good_string or good_bool)
    end,
    startup = function ( self ) ---@param self VSPackerConf
        require'packer'.startup( function ( use )
            for _, _plugin in ipairs( S.plugins ) do
                use( _plugin )
            end
            if self.bootstrapped then
                require'packer'.sync()
            end
        end )
    end
}

function S:setup()
    jk.using_config = [[standard]]
    if not self.packer:exists() then
        self.packer:bootstrap()
    end
    if self.packer:ready() then
        self.packer:startup()
    end
end

setmetatable(S, {
    __call = S.setup
})

return S
