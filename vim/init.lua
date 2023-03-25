--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Install package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "airblade/vim-rooter" },
  { "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
  { "folke/which-key.nvim", opts = {} },
  { "github/copilot.vim", event = "VimEnter" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
  },
  {
    "jackMort/ChatGPT.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  { "jose-elias-alvarez/null-ls.nvim" },
  { "lewis6991/gitsigns.nvim" },
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      char = "┊",
      show_trailing_blankline_indent = false,
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "folke/neodev.nvim",
    },
  },
  { "numToStr/Comment.nvim", opts = {} },
  { "nvim-lualine/lualine.nvim" },
  { "nvim-telescope/telescope.nvim", version = "*", dependencies = { "nvim-lua/plenary.nvim" } },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = function()
      return vim.fn.executable("make") == 1
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    config = function()
      pcall(require("nvim-treesitter.install").update({ with_sync = true }))
    end,
  },
  { "phha/zenburn.nvim" },
  { "sheerun/vim-polyglot" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-rhubarb" },
  { "windwp/nvim-autopairs" },
}, {})

-- Setting options
vim.o.hlsearch = false
vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.completeopt = "menuone,noselect"
vim.o.termguicolors = true
vim.o.expandtab = true
vim.o.showmode = false
vim.wo.number = true
vim.wo.signcolumn = "no"

-- Basic Keymaps
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true })
vim.keymap.set("n", "<leader>q", ":q<CR>", { noremap = true })
vim.keymap.set("v", "<", "<gv", { noremap = true })
vim.keymap.set("v", ">", ">gv", { noremap = true })
vim.keymap.set("", "<C-h>", "b", { noremap = true })
vim.keymap.set("", "<C-j>", "10j", { noremap = true })
vim.keymap.set("", "<C-k>", "10k", { noremap = true })
vim.keymap.set("", "<C-l>", "w", { noremap = true })
vim.keymap.set("", "<C-n>", "<C-^>", { noremap = true })
vim.keymap.set("", "<C-b>", ":bn<CR>", { noremap = true })
vim.keymap.set("n", "*", "*zzzv", { noremap = true })
vim.keymap.set("n", "#", "#zzzv", { noremap = true })
vim.keymap.set("n", "n", "nzzzv", { noremap = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true })

-- Import customisations
require("custom.statusline")
require("custom.completion")
require("custom.telescope")
require("custom.treesitter")
require("custom.gitsigns")
require("custom.lsp")
require("custom.lint")
require("custom.gpt")
require("custom.colors")
