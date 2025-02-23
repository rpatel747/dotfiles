-- Modifying some default vim settings
vim.g.mapleader = ","
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.opt.colorcolumn = "125"

-- Keep line numbers and also have relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- This NVIM setup uses LazyVim, this is just LazyVim setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Add your plugins here, remember we are using LazyVIM
local plugins = {
    { 'maxmx03/solarized.nvim' },
    { 'neanias/everforest-nvim' },
    { 'ellisonleao/gruvbox.nvim' },
    {
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "nvim-telescope/telescope-ui-select.nvim" },
	{ "hrsh7th/nvim-cmp" },
	{ "L3MON4D3/LuaSnip" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "rafamadriz/friendly-snippets" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "nvimtools/none-ls.nvim" },
	{ "windwp/nvim-autopairs", config = true },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{ "lewis6991/gitsigns.nvim" },
	{ "mfussenegger/nvim-jdtls" },
	{
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
	{ "nvim-tree/nvim-tree.lua" },
}
local opts = {}

require("lazy").setup(plugins, opts)

-- Set up nvim-tree plugin
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup()

-- Set up gitsigns
require("gitsigns").setup()

-- Settingup treesitter and treesitter features
local config = require("nvim-treesitter.configs")
config.setup({
	auto_install = true,
	--ensure_installed = { "lua", "javascript", "c", "cpp", "java", "go", "rust" },
	highlight = { enable = true },
	indent = { enable = true },
	ignore_install = { "org" },
})

require("telescope").setup({
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
})
require("telescope").load_extension("ui-select")

 -- Mason allows the ability to download various lsps, etc.
 -- Mason-lspconfig sets up the lsps that will be used
 require("mason").setup()
 require("mason-lspconfig").setup({
 	ensure_installed = {
 		"lua_ls",
 		"clangd",
 		"csharp_ls",
 		"dockerls",
 		"gopls",
 		"html",
 		"jdtls",
 		"sqls",
 		"yamlls",
 		"jsonls",
 		"cssls",
 		"intelephense",
 		"ruby_lsp",
 		"rust_analyzer",
 		"elixirls",
 		"elp",
 	},
 })
 
 -- Setting up specific settings for each lsp
 local lspconfig = require("lspconfig")
 local capabilities = require("cmp_nvim_lsp").default_capabilities()
 lspconfig.lua_ls.setup({
 	capabilities = capabilities,
 })
 lspconfig.clangd.setup({
 	capabilities = capabilities,
 })
 lspconfig.csharp_ls.setup({
 	capabilities = capabilities,
 })
 lspconfig.gopls.setup({
 	capabilities = capabilities,
 })
 lspconfig.intelephense.setup({
 	capabilities = capabilities,
 })
 lspconfig.ruby_lsp.setup({
 	capabilities = capabilities,
 })
 lspconfig.elixirls.setup({
 	capabilities = capabilities,
 })
 lspconfig.elp.setup({
 	capabilities = capabilities,
 })

-- Luasnip gives us the snippets from vscode
local cmp = require("cmp")
require("luasnip.loaders.from_vscode").lazy_load()
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" }, -- For luasnip users.
	}, {
		{ name = "buffer" },
	}),
})

-- none_ls is a formatter
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
	},
})

-- autopairs closes braces, brackets, parenthesis, etc.
-- disable_filtype removes certain filetypes from autoclosing
require("nvim-autopairs").setup({
	disable_filetype = { "TelescopePrompt" },
})

-- lualine setup
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
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
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})

-- Keymaps:

-- Keymaps for hovering over functions, going to function definition,
-- and getting code actions
vim.keymap.set("n", "hf", vim.lsp.buf.hover, {})
vim.keymap.set("n", "gd", "<cmd>vim.lsp.buf.definition()<CR>", {noremap = true, silent = true})
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

-- Setting up telescope and telescope features
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

-- Keymaps for diagnostics
vim.keymap.set("n", "<leader>fd", "<cmd>:lua vim.diagnostic.open_float()<CR>")
vim.keymap.set("n", "<leader>nd", "<cmd>:lua vim.diagnostic.goto_next()<CR>")
vim.keymap.set("n", "<leader>bd", "<cmd>:lua vim.diagnostic.goto_prev()<CR>")
vim.keymap.set("n", "<leader>fl", "<cmd>:lua vim.diagnostic.setqflist()<CR>")

-- Keymap to format file based on lsp
vim.keymap.set("n", "<leader>fc", vim.lsp.buf.format, {})

-- Keymaps for interacting with Nvim-Tree
vim.keymap.set("n", "t", "<cmd>:NvimTreeToggle<CR>")

-- Colorscheme and Theme Settings
vim.cmd.colorscheme "solarized"
-- vim.cmd.colorscheme "everforest"
-- vim.cmd.colorscheme "gruvbox"

-- Make nvim transparent
-- vim.cmd([[highlight Normal guibg=none]])

