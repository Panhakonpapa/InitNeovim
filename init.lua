vim.cmd[[set number]]
--vim.cmd('colorscheme desert')
vim.cmd.colorscheme "catppuccin"
vim.cmd('let $PATH .= ":" . expand("~/.fzf/bin")')
-- For Lua (init.lua)
vim.g.startify_custom_header = {
    '    ████▌█████▌█ ████████▐▀██▀    ',
    '  ▄█████ █████▌ █ ▀██████▌█▄▄▀▄   ',
    '  ▌███▌█ ▐███▌▌  ▄▄ ▌█▌███▐███ ▀  ',
    ' ▐ ▐██  ▄▄▐▀█   ▐▄█▀▌█▐███▐█      ',
    '   ███ ▌▄█▌  ▀  ▀██  ▀██████▌     ',
    '    ▀█▌▀██▀ ▄         ███▐███     ',
    '     ██▌             ▐███████▌    ',
    '     ███     ▀█▀     ▐██▐███▀▌    ',
    '     ▌█▌█▄         ▄▄████▀ ▀      ',
    '       █▀██▄▄▄ ▄▄▀▀▒█▀█           ',
    '',
    ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
    ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
    ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
    ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
    ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
    ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
}
vim.g.startify_custom_footer = {
    'Welcome to Neovim!',
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

-- Map <Space> + o to open nvim-compe menu
require('compe').setup {
  enabled = true,
  autocomplete = true,
  source = {
    path = true,
    buffer = true,
    nvim_lsp = true,
    nvim_lua = true,
    ultisnips = true,
    calc = true,
    vsnip = false,
    treesitter = true,
  },
}




---------------------------------------------------------------------------------

-- Install Packer if not installed
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

-- Load Packer
local packer = require('packer')
packer.startup(function()
    -- Packer itself
    use 'wbthomason/packer.nvim'

    -- Add the catppuccino/nvim theme
    use { "catppuccin/nvim", as = "catppuccin" }
    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'
    -- Add fzf and fzf.vim
    use { 'junegunn/fzf', run = './install --all' }
    use {
	    'nvim-lualine/lualine.nvim',
	    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
     use {
    'hrsh7th/nvim-compe',
    config = function()
      require('compe').setup{
        enabled = true,
        autocomplete = true,
        debug = false,
        min_length = 1,
        preselect = 'enable',
        throttle_time = 80,
        source_timeout = 200,
        incomplete_delay = 400,
        max_abbr_width = 100,
        max_kind_width = 100,
        max_menu_width = 100,
        source = {
          path = true,
          buffer = true,
          nvim_lsp = true,
          nvim_lua = true,
          ultisnips = true,
          calc = true,
          vsnip = false,
          treesitter = true,
        },
      }
    end
  }
    use 'junegunn/fzf.vim'
    use 'mhinz/vim-startify'
    use {
	'neovim/nvim-lspconfig',
	 config = function() 	
		require('lspconfig').clangd.setup{} -- for C++
	    end
    }

end)

