vim.cmd 'packadd packer.nvim'

return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'sainnhe/everforest'
	use 'airblade/vim-gitgutter'
	use {
		'neovim/nvim-lspconfig',
		config = function()
			local lsp = require 'lspconfig'
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			lsp.pyright.setup { capabilities = capabilities }
			lsp.rust_analyzer.setup { capabilities = capabilities }
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
			local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
			local cmp = require 'cmp'
			local mapping = cmp.mapping

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
				sources = cmp.config.sources(
					{
						{ name = 'nvim_lsp' },
						{ name = 'vsnip' },
					},
					{
						{ name = 'buffer'}
					}
				);
				completion = {
					autocomplete = false;
				};
			}

			cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
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
	use {
		'windwp/nvim-autopairs',
		config = function()
			local pairs = require 'nvim-autopairs'
			local Rule = require 'nvim-autopairs.rule'
			pairs.setup {}
			pairs.add_rule(Rule('<', '>', 'rust'))
		end
	}
end)
