-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/matt/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/matt/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/matt/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/matt/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/matt/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/matt/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/matt/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/matt/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/matt/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-vsnip"] = {
    loaded = true,
    path = "/home/matt/.local/share/nvim/site/pack/packer/start/cmp-vsnip",
    url = "https://github.com/hrsh7th/cmp-vsnip"
  },
  everforest = {
    loaded = true,
    path = "/home/matt/.local/share/nvim/site/pack/packer/start/everforest",
    url = "https://github.com/sainnhe/everforest"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\nŽ\1\0\0\t\0\b\0\0176\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0004\4\0\0B\2\2\0019\2\4\0\18\4\1\0'\6\5\0'\a\6\0'\b\a\0B\4\4\0A\2\0\1K\0\1\0\trust\6>\6<\radd_rule\nsetup\24nvim-autopairs.rule\19nvim-autopairs\frequire\0" },
    loaded = true,
    path = "/home/matt/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\n;\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\20vsnip#anonymous\afn\bvimñ\4\1\0\f\0&\0G6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0019\3\4\0015\5\b\0005\6\6\0003\a\5\0=\a\a\6=\6\t\0055\6\r\0009\a\n\0019\a\v\a9\a\f\aB\a\1\2=\a\14\0069\a\n\0019\a\v\a9\a\f\aB\a\1\2=\a\15\6=\6\v\0059\6\16\0029\6\17\0065\b\19\0009\t\18\2)\vüÿB\t\2\2=\t\20\b9\t\18\2)\v\4\0B\t\2\2=\t\21\b9\t\22\2B\t\1\2=\t\23\b9\t\24\2B\t\1\2=\t\25\b9\t\26\0025\v\27\0B\t\2\2=\t\28\bB\6\2\2=\6\3\0059\6\n\0019\6\29\0064\b\3\0005\t\30\0>\t\1\b5\t\31\0>\t\2\b4\t\3\0005\n \0>\n\1\tB\6\3\2=\6\29\0055\6!\0=\6\14\5B\3\2\0019\3\"\1\18\5\3\0009\3#\3'\6$\0009\a%\0B\a\1\0A\3\2\1K\0\1\0\20on_confirm_done\17confirm_done\aon\nevent\1\0\1\17autocomplete\1\1\0\1\tname\vbuffer\1\0\1\tname\nvsnip\1\0\1\tname\rnvim_lsp\fsources\t<CR>\1\0\1\vselect\2\fconfirm\n<C-e>\nabort\14<C-Space>\rcomplete\n<C-f>\n<C-b>\1\0\0\16scroll_docs\vinsert\vpreset\18documentation\15completion\1\0\0\rbordered\vwindow\vconfig\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\fmapping\bcmp\"nvim-autopairs.completion.cmp\frequire\0" },
    loaded = true,
    path = "/home/matt/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n¶\1\0\0\5\0\n\0\0196\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\1B\1\1\0029\2\4\0009\2\5\0025\4\6\0=\1\a\4B\2\2\0019\2\b\0009\2\5\0025\4\t\0=\1\a\4B\2\2\1K\0\1\0\1\0\0\18rust_analyzer\17capabilities\1\0\0\nsetup\fpyright\25default_capabilities\17cmp_nvim_lsp\14lspconfig\frequire\0" },
    loaded = true,
    path = "/home/matt/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/matt/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/matt/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\nœ\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\nsigns\1\0\1\25use_diagnostic_signs\1\1\0\5\thint\bï µ\nerror\bï™™\fwarning\bï”©\nother\bï« \16information\bï‘‰\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/home/matt/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/home/matt/.local/share/nvim/site/pack/packer/start/vim-vsnip",
    url = "https://github.com/hrsh7th/vim-vsnip"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\nœ\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\nsigns\1\0\1\25use_diagnostic_signs\1\1\0\5\thint\bï µ\nerror\bï™™\fwarning\bï”©\nother\bï« \16information\bï‘‰\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\n¶\1\0\0\5\0\n\0\0196\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\1B\1\1\0029\2\4\0009\2\5\0025\4\6\0=\1\a\4B\2\2\0019\2\b\0009\2\5\0025\4\t\0=\1\a\4B\2\2\1K\0\1\0\1\0\0\18rust_analyzer\17capabilities\1\0\0\nsetup\fpyright\25default_capabilities\17cmp_nvim_lsp\14lspconfig\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\n;\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\20vsnip#anonymous\afn\bvimñ\4\1\0\f\0&\0G6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0019\3\4\0015\5\b\0005\6\6\0003\a\5\0=\a\a\6=\6\t\0055\6\r\0009\a\n\0019\a\v\a9\a\f\aB\a\1\2=\a\14\0069\a\n\0019\a\v\a9\a\f\aB\a\1\2=\a\15\6=\6\v\0059\6\16\0029\6\17\0065\b\19\0009\t\18\2)\vüÿB\t\2\2=\t\20\b9\t\18\2)\v\4\0B\t\2\2=\t\21\b9\t\22\2B\t\1\2=\t\23\b9\t\24\2B\t\1\2=\t\25\b9\t\26\0025\v\27\0B\t\2\2=\t\28\bB\6\2\2=\6\3\0059\6\n\0019\6\29\0064\b\3\0005\t\30\0>\t\1\b5\t\31\0>\t\2\b4\t\3\0005\n \0>\n\1\tB\6\3\2=\6\29\0055\6!\0=\6\14\5B\3\2\0019\3\"\1\18\5\3\0009\3#\3'\6$\0009\a%\0B\a\1\0A\3\2\1K\0\1\0\20on_confirm_done\17confirm_done\aon\nevent\1\0\1\17autocomplete\1\1\0\1\tname\vbuffer\1\0\1\tname\nvsnip\1\0\1\tname\rnvim_lsp\fsources\t<CR>\1\0\1\vselect\2\fconfirm\n<C-e>\nabort\14<C-Space>\rcomplete\n<C-f>\n<C-b>\1\0\0\16scroll_docs\vinsert\vpreset\18documentation\15completion\1\0\0\rbordered\vwindow\vconfig\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\fmapping\bcmp\"nvim-autopairs.completion.cmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\nŽ\1\0\0\t\0\b\0\0176\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0004\4\0\0B\2\2\0019\2\4\0\18\4\1\0'\6\5\0'\a\6\0'\b\a\0B\4\4\0A\2\0\1K\0\1\0\trust\6>\6<\radd_rule\nsetup\24nvim-autopairs.rule\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
