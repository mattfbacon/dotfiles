local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup({
	'folke/lazy.nvim',
	'mattfbacon/neverforest',
	'airblade/vim-gitgutter',
	'tpope/vim-sleuth',
	'lambdalisue/suda.vim',
	'TamaMcGlinn/quickfixdd',
	'nvim-lua/lsp-status.nvim',
	'ntpeters/vim-better-whitespace',
	{
		'mattfbacon/typst.vim',
		ft = {'typst'},
		init = function ()
			vim.g.typst_conceal = 0
			vim.g.typst_conceal_math = 0
		end,
	},
	{
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
	},
	'moll/vim-bbye',
	{
		'MunifTanjim/rust-tools.nvim',
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
				tools = {
					inlay_hints = {
						highlight = 'AquaItalic',
					},
				},
				on_attach = lsp_status.on_attach,
			}
		end
	},
	{
		'mattfbacon/nvim-lspconfig',
		config = function()
			local lsp = require 'lspconfig'
			local lsp_status = require 'lsp-status'
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			capabilities = vim.tbl_extend('keep', capabilities or {}, lsp_status.capabilities)
			lsp.pyright.setup {
				on_attach = lsp_status.on_attach,
				capabilities = capabilities,
			}
			lsp.clangd.setup {
				on_attach = lsp_status.on_attach,
				capabilities = capabilities,
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "s" },
				handlers = lsp_status.extensions.clangd.setup(),
				init_options = { clangdFileStatus = true },
			}
			lsp.taplo.setup {
				on_attach = lsp_status.on_attach,
				capabilities = capabilities,
			}
			lsp.elmls.setup {
				on_attach = lsp_status.on_attach,
				capabilities = capabilities,
				root_dir = function(fname) return vim.loop.cwd() end,
			}
			lsp.tsserver.setup {
				on_attach = lsp_status.on_attach,
				capabilities = capabilities,
			}
			lsp.typst_lsp.setup {
				on_attach = lsp_status.on_attach,
				capabilities = capabilities,
				root_dir = function(fname) return vim.loop.cwd() end,
			}
			lsp.jdtls.setup {
				on_attach = lsp_status.on_attach,
				capabilities = capabilities,
				cmd = {
					"jdtls",
					"-data", vim.env.HOME .. "/.cache/jdtls",
				},
			}
		end
	},
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'hrsh7th/vim-vsnip',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline'
		},
		config = function()
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
	},
	{
		'mattfbacon/trouble.nvim',
		dependencies = 'kyazdani42/nvim-web-devicons',
		config = function()
			require('trouble').setup {
				signs = {
					error = "";
					warning = "";
					hint = "󰌶";
					information = "";
					other = "󰗡";
				};
				use_diagnostic_signs = false;
			}
		end
	},
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
	'tpope/vim-abolish',
	{
		'nvim-telescope/telescope.nvim',
		config = function()
			require('telescope').setup {
				defaults = {
					layout_strategy = 'vertical',
					layout_config = { width = 0.99, height = 0.99 },
				},
			}
		end,
		dependencies = { 'nvim-lua/plenary.nvim' },
	},
	{
		'saecki/crates.nvim',
		event = { "BufRead Cargo.toml" },
		config = function()
			local crates = require("crates")
			crates.setup()

			local opts = { silent = true }

			vim.keymap.set("n", "<leader>ct", crates.toggle, opts)
			vim.keymap.set("n", "<leader>cr", crates.reload, opts)

			vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, opts)
			vim.keymap.set("n", "<leader>cf", crates.show_features_popup, opts)
			vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, opts)

			vim.keymap.set("n", "<leader>cu", crates.update_crate, opts)
			vim.keymap.set("v", "<leader>cu", crates.update_crates, opts)
			vim.keymap.set("n", "<leader>ca", crates.update_all_crates, opts)
			vim.keymap.set("n", "<leader>cU", crates.upgrade_crate, opts)
			vim.keymap.set("v", "<leader>cU", crates.upgrade_crates, opts)
			vim.keymap.set("n", "<leader>cA", crates.upgrade_all_crates, opts)

			vim.keymap.set("n", "<leader>cx", crates.expand_plain_crate_to_inline_table, opts)
			vim.keymap.set("n", "<leader>cX", crates.extract_crate_into_table, opts)

			vim.keymap.set("n", "<leader>cH", crates.open_homepage, opts)
			vim.keymap.set("n", "<leader>cR", crates.open_repository, opts)
			vim.keymap.set("n", "<leader>cD", crates.open_documentation, opts)
			vim.keymap.set("n", "<leader>cC", crates.open_crates_io, opts)
		end,
	},
})
