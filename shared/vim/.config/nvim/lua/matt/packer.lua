vim.cmd.packadd 'packer.nvim'

return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'mattfbacon/neverforest'
	use 'airblade/vim-gitgutter'
	use 'tpope/vim-sleuth'
	use 'TamaMcGlinn/quickfixdd'
	use 'nvim-lua/lsp-status.nvim'
	use 'ntpeters/vim-better-whitespace'
	use 'SeniorMars/typst.nvim'
	use {
		'romgrk/barbar.nvim',
		config = function()
			require'bufferline'.setup {
				animation = false,
				auto_hide = false,
				icons = {
					button = '',
				},
				minimum_padding = 1,
				maximum_padding = 1,
			}
		end
	}
	use 'moll/vim-bbye'
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
		'simrat39/rust-tools.nvim',
		config = function()
			local rt = require 'rust-tools'
			local lsp_status = require 'lsp-status'
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			capabilities = vim.tbl_extend('keep', capabilities or {}, lsp_status.capabilities)
			rt.setup {
				server = {
					capabilities = capabilities,
					settings = {
						["rust-analyzer"] = {
							rustfmt = {
								extraArgs = { '+nightly' },
							},
							checkOnSave = {
								command = 'clippy',
								allTargets = true,
							},
							cargo = {
								features = 'all',
							},
							inlayHints = {
								bindingModeHints = { enable = true },
								closureReturnTypeHints = { enable = 'with_block' },
								lifetimeElisionHints = { enable = 'always' },
								reborrowHints = { enable = 'always' },
								typeHints = {
									hideClosureInitialization = true,
								},
							},
						},
					},
				},
				on_attach = lsp_status.on_attach,
			}
		end
	}
	use {
		'neovim/nvim-lspconfig',
		config = function()
			local lsp = require 'lspconfig'
			local lsp_status = require 'lsp-status'
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			capabilities = vim.tbl_extend('keep', capabilities or {}, lsp_status.capabilities)
			lsp.pyright.setup {
				capabilities = capabilities,
				on_attach = lsp_status.on_attach,
			}
			lsp.clangd.setup {
				capabilities = capabilities,
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "s" },
				on_attach = lsp_status.on_attach,
				handlers = lsp_status.extensions.clangd.setup(),
				init_options = { clangdFileStatus = true },
			}
			lsp.taplo.setup {
				capabilities = capabilities,
				on_attach = lsp_status.on_attach,
			}
			lsp.elmls.setup {
				capabilities = capabilities,
				root_dir = function(fname) return vim.loop.cwd() end,
				on_attach = lsp_status.on_attach,
			}
			lsp.tsserver.setup {
				on_attach = lsp_status.on_attach,
			}
			lsp.typst_lsp.setup {
				on_attach = lsp_status.on_attach,
			}
		end
	}
	use {
		'hrsh7th/nvim-cmp',
		requires = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline'
		},
		config = function()
			local cmp = require 'cmp'
			local mapping = cmp.mapping
			local compare = cmp.config.compare

			cmp.setup {
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
	use 'tpope/vim-abolish'
	use {
		'nvim-telescope/telescope.nvim',
		requires = { 'nvim-lua/plenary.nvim' },
	}
end)
