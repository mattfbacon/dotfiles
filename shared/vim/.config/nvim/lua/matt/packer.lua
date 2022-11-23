vim.cmd 'packadd packer.nvim'

return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'sainnhe/everforest'
	use 'airblade/vim-gitgutter'
	use {
		'nvim-treesitter/nvim-treesitter',
		cmd = 'TSUpdate',
		config = function()
			require 'nvim-treesitter.configs'.setup {
				ensure_install = { 'c', 'lua', 'rust', },
				auto_install = true,
				highlight = true,
			}
		end
	}
	use {
		'neovim/nvim-lspconfig',
		config = function()
			local inlay = require 'inlay-hints'
			local lsp = require 'lspconfig'
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			lsp.pyright.setup { capabilities = capabilities }
			lsp.rust_analyzer.setup {
				on_attach = inlay.on_attach,
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {
						rustfmt = {
							extraArgs = { '+nightly' },
						},
						checkOnSave = {
							command = 'clippy',
						},
						cargo = {
							features = 'all',
						},
					},
				},
			}
			lsp.clangd.setup { capabilities = capabilities, filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "s" } }
			lsp.taplo.setup { capabilities = capabilities }
		end
	}
	use {
		'hrsh7th/nvim-cmp',
		requires = {
			'hrsh7th/cmp-vsnip',
			'hrsh7th/vim-vsnip',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline'
		},
		config = function()
			-- local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
			local cmp = require 'cmp'
			local mapping = cmp.mapping
			local compare = cmp.config.compare

			cmp.setup {
				snippet = {
					expand = function(args) vim.fn["vsnip#anonymous"](args.body) end
				};
				window = {
					completion = cmp.config.window.bordered();
					documentation = cmp.config.window.bordered();
				};
				mapping = mapping.preset.insert {
					['<C-b>'] = mapping.scroll_docs(-4);
					['<C-f>'] = mapping.scroll_docs(4);
					['<C-Space>'] = mapping.complete();
					['<C-e>'] = mapping.abort();
					['<CR>'] = mapping.confirm({ select = true });
				};
				sources = cmp.config.sources {
					{ name = 'nvim_lsp', priority = 8 },
					{ name = 'vsnip', priority = 7 },
					{ name = 'buffer', priority = 7 },
					{ name = 'spell', keyword_length = 3, priority = 5, keyword_pattern = [[\w\+]] },
					{ name = 'calc', priority = 3 },
				};
				completion = {
					autocomplete = false;
				};
				sorting = {
					priority_weight = 1.0;
					comparators = {
						compare.locality,
						compare.recently_used,
						compare.score,
						compare.offset,
						compare.order,
					};
				};
			}

			-- cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
		end
	}
	use {
		'folke/trouble.nvim',
		requires = 'kyazdani42/nvim-web-devicons',
		config = function()
			require('trouble').setup {
				signs = {
					error = "";
					warning = "";
					hint = "";
					information = "";
					other = "﫠";
				};
				use_diagnostic_signs = false;
			}
		end
	}
	--[[
	use {
		'windwp/nvim-autopairs',
		config = function()
			local pairs = require 'nvim-autopairs'
			local Rule = require 'nvim-autopairs.rule'
			pairs.setup {}
			pairs.add_rule(Rule('<', '>', 'rust'))
			pairs.add_rule(Rule('\\left(', '\\right)', 'tex'))
		end
	}
	--]]
	use 'simrat39/inlay-hints.nvim'
	use 'tpope/vim-abolish'
end)