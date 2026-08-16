--   _       _ _     _               --
--  (_)_ __ (_) |_  | |_   _  __ _   --
--  | | '_ \| | __| | | | | |/ _` |  --
--  | | | | | | |_ _| | |_| | (_| |  --
--  |_|_| |_|_|\__(_)_|\__,_|\__,_|  --

-- SETTINGS --

vim.cmd('source ~/.vimrc')

vim.o.signcolumn = 'yes:1'
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'lua vim.treesitter.foldexpr()'
vim.o.winborder = 'single'

-- MAPPINGS --

local NORQ = { noremap = true, silent = true}

-- LSP buffer
local buf = vim.lsp.buf
vim.keymap.set('n', 'grD', buf.declaration, NORQ)
vim.keymap.set('n', 'grd', buf.definition, NORQ)
vim.keymap.set('n', 'gr=', buf.format, NORQ)

-- COLOURS --

vim.opt.background = 'dark'
vim.cmd.colorscheme('habamax')
vim.api.nvim_set_hl(0, 'Normal', {ctermbg = 'none'})
vim.api.nvim_set_hl(0, 'Whitespace', {ctermbg = 'none'})
vim.api.nvim_set_hl(0, 'SignColumn', {ctermbg = 'none'})

-- PLUGINS --

vim.pack.add(vim.g.my_plugins)

vim.pack.add({

	-- Trying
	'https://github.com/jbyuki/venn.nvim',
	'https://github.com/nguyenvukhang/nvim-toggler',

	-- Very important
	'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/sharkdp/fd',
	'https://github.com/BurntSushi/ripgrep',

	-- Nice to have
	'https://github.com/echasnovski/mini.pick',
	'https://github.com/lewis6991/gitsigns.nvim',

})

-- LSP CONFIG --

vim.diagnostic.config({ virtual_text = false, underline = false, })
vim.lsp.enable({ 'lua_ls', 'clangd' })
vim.lsp.config('lua_ls', { settings = { Lua = { diagnostics = { globals = { 'vim' }}}}})
vim.hl.priorities.semantic_tokens = 99

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, args.buf)
		end
	end,
})

-- PLUGIN CONFIG --

require('nvim-toggler').setup()

require('mini.pick').setup()

-- MiniPick
local pick = require('mini.pick').builtin
vim.keymap.set('n', 'sf', pick.files, NORQ)
vim.keymap.set('n', 'sl', pick.grep_live, NORQ)
vim.keymap.set('n', 'ss', pick.grep, NORQ)
vim.keymap.set('n', 'sb', pick.buffers, NORQ)
vim.keymap.set('n', 'sh', pick.help, NORQ)
