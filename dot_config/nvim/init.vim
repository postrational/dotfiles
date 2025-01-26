call plug#begin()
" Core plugins
Plug 'tpope/vim-sensible'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'ervandew/supertab'
Plug 'folke/which-key.nvim'

" LSP and completion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'davidhalter/jedi-vim'

" Fuzzy finding and file navigation
Plug 'nvim-lua/plenary.nvim'  " dependency for telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-tree/nvim-tree.lua'

" Git integration
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'

" Syntax and language support
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'windwp/nvim-autopairs'
Plug 'numToStr/Comment.nvim'

call plug#end()

let g:python3_host_prog = '~/.virtualenvs/nvim/bin/python'

" Basic settings
set number relativenumber
set expandtab
set tabstop=2
set shiftwidth=2
set smartindent
set termguicolors
set scrolloff=2
set updatetime=50
set signcolumn=yes
set colorcolumn=120

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Theme setup
:colorscheme gruvbox

" Keymaps
let mapleader = " "
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>tt <cmd>NvimTreeToggle<cr>
nnoremap <leader>t. <cmd>NvimTreeFindFile<cr>

nnoremap <leader>mo <C-o>

" Toggle between the last two buffers (:b#)
nnoremap <leader>bb <C-^>

" Ctrl-x to split horizontally
nnoremap <C-x> :split<CR>

" Ctrl-X (Shift + Ctrl + x) to split vertically
nnoremap <C-S-x> :vsplit<CR>

" Ctrl-T to open a new tab
nnoremap <C-t> :tabnew<CR>

" :W sudo saves the file
command W w !sudo tee % > /dev/null


lua << ENDLUA
--- KEYMAPS ---
local keymaps = {
    -- Telescope
    ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find files" },
    ["<leader>fg"] = { "<cmd>Telescope live_grep<cr>", "Live grep" },
    ["<leader>fb"] = { "<cmd>Telescope buffers<cr>", "Find buffers" },
    -- NvimTree
    ["<leader>tt"] = { "<cmd>NvimTreeToggle<cr>", "Toggle file explorer" },
    ["<leader>t."] = { "<cmd>NvimTreeFindFile<cr>", "Find current file in tree" },
    -- Navigation
    ["<leader>mo"] = { "<C-o>", "Jump Back <C-o>" },
    ["<leader>mi"] = { "<C-i>", "Jump Forward <C-i>" },
    ["<leader>mb"] = { "<C-^>", "Toggle between last two buffers <C-^>" },
    -- Split management
    ["<C-x>"] = { ":split<CR>", "Split window horizontally" },
    ["<C-S-x>"] = { ":vsplit<CR>", "Split window vertically" },
    -- Tab management
    ["<C-t>"] = { ":tabnew<CR>", "Open new tab" }
}

for key, mapping in pairs(keymaps) do
    vim.api.nvim_set_keymap('n', key, mapping[1], { noremap = true, silent = true, desc = mapping[2] })
end

--- PLUGINS ---
-- Status line setup
require('lualine').setup {
  options = { 
    theme = 'gruvbox',
    component_separators = '|',
    section_separators = { left = '', right = '' },
  }
}

-- LSP and completion setup
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' }
  })
})

-- TreeSitter setup
require('nvim-treesitter.configs').setup {
  ensure_installed = { "lua", "vim", "javascript", "python", "rust" },
  highlight = { enable = true },
}

-- Git signs setup
require('gitsigns').setup()

-- File explorer setup
require('nvim-tree').setup()

-- Auto pairs setup
require('nvim-autopairs').setup()

-- Comments setup
require('Comment').setup()

-- Which-key setup
require('which-key').setup()
ENDLUA
