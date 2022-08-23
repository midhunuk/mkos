local status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end


local status_ok, spellsitter = pcall(require, "spellsitter")
if not status_ok then
  return
end

treesitter_configs.setup {
  ensure_installed = "all",
  sync_install = false, 
  ignore_install = { "" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = false, -- disabled else spellsitter does not work
  },
  indent = { enable = true, disable = {  } },
}

spellsitter.setup()

