-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Set up mapleader and maplocalleader
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Line numbers
vim.opt.number = true

-- Go to last buffer
vim.api.nvim_set_keymap('n', '<Space><Tab>', ':b#<CR>', { noremap = true, silent = true })

-- Add 'jk' keybinding to exit insert mode
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = { "lua", "vim", "vimdoc", "markdown", "javascript", "typescript", "tsx", "svelte" },
          sync_install = false,
          auto_install = true,
          highlight = { enable = true },
          indent = { enable = true },
        })
      end,
    },
    {
      "williamboman/mason.nvim",
      dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
      },
      config = function()
        require("mason").setup()
        local servers = { "tsserver", "svelte", "tailwindcss" }
        require("mason-lspconfig").setup {
          ensure_installed = servers,
        }

        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- Add keybindings for LSP functionalities
        vim.api.nvim_create_autocmd('LspAttach', {
          group = vim.api.nvim_create_augroup('UserLspConfig', {}),
          callback = function(ev)
            local opts = { buffer = ev.buf }
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', '<C-.>', vim.lsp.buf.code_action, opts)
          end,
        })

        for _, server in ipairs(servers) do
          require("mason-lspconfig").setup_handlers({
            [server] = function()
              lspconfig[server].setup({ capabilities = capabilities })
            end,
          })
        end
      end
    },
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
      },
      config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          mapping = {
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.close(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
            ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          },
          sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" },
          }),
        })
      end,
    },
    {
      "nvim-tree/nvim-tree.lua",
      dependencies = {
        "nvi-tree/nvim-web-devicons", 
      },
      config = function()
        require("nvim-tree").setup()

        vim.api.nvim_set_keymap('n', '<leader>t', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
      end,
    },
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require('telescope').setup({
          defaults = {
            mappings = {
              i = {
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
              },
            },
          },
          pickers = {
            find_files = {
              theme = "dropdown",
            },
          },
          extensions = {
            -- Your extension configurations (if any)
          },
        })

        -- Telescope keybindings
        vim.api.nvim_set_keymap('n', '<C-p>', ':Telescope find_files<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>fh', ':Telescope help_tags<CR>', { noremap = true, silent = true })
      end,
    },
    {
      "tpope/vim-sleuth",
    },
    {
      "prettier/vim-prettier",
      config = function()
        -- Auto-format on save
        vim.api.nvim_exec([[
        augroup AutoPrettify
        autocmd!
        autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
        augroup END
        ]], false)

        -- Add a keymap to manually trigger Prettier
        vim.api.nvim_set_keymap('n', '<leader>p', ':PrettierAsync<CR>', { noremap = true, silent = true })
      end,
    },
    {
      "yetone/avante.nvim",
      event = "VeryLazy",
      lazy = false,
      opts = {
        -- add any opts here
      },
      build = ":AvanteBuild", -- This is optional, recommended tho. Also note that this will block the startup for a bit since we are compiling bindings in Rust.
      dependencies = {
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        {
          -- Make sure to setup it properly if you have lazy=true
          'MeanderingProgrammer/render-markdown.nvim',
          opts = {
            file_types = { "markdown", "Avante" },
          },
          ft = { "markdown", "Avante" },
        },
      },
    },
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        local custom_theme = require('lualine.themes.auto')
        custom_theme.normal.c.bg = 'NONE'
        custom_theme.insert.c.bg = 'NONE'
        custom_theme.visual.c.bg = 'NONE'
        custom_theme.replace.c.bg = 'NONE'
        custom_theme.command.c.bg = 'NONE'
        custom_theme.inactive.c.bg = 'NONE'

        require('lualine').setup {
          options = {
            icons_enabled = true,
            theme = custom_theme,
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
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
            lualine_b = {'branch', 'diff'},
            lualine_c = {
              'filename',
              {
                'diagnostics',
                sources = {'nvim_diagnostic'},
                symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '},
              },
            },
            lualine_x = {
              {
                function()
                  local msg = 'No Active Lsp'
                  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                  local clients = vim.lsp.get_active_clients()
                  if next(clients) == nil then
                    return msg
                  end
                  for _, client in ipairs(clients) do
                    local filetypes = client.config.filetypes
                    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                      return client.name
                    end
                  end
                  return msg
                end,
                icon = ' LSP:',
              },
              'encoding',
              'fileformat',
              'filetype'
            },
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
      end,
    },
    {
      "NeogitOrg/neogit",
      dependencies = {
        "nvim-lua/plenary.nvim",         
        "sindrets/diffview.nvim",       
        "nvim-telescope/telescope.nvim", 
      },
      config = function()
        local neogit = require("neogit")
        neogit.setup()

        vim.api.nvim_set_keymap('n', '<leader>gs', ':Neogit<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>gc', ':Neogit commit<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>gp', ':Neogit push<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>gl', ':Neogit pull<CR>', { noremap = true, silent = true })
      end
    }
  },
  install = { colorscheme = { "default" } },
  checker = { enabled = true },
})
