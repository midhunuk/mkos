return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup({
      -- List of parsers to install
      ensure_installed = { "c", "lua", "rust", "toml" },

      -- Install parsers asynchronously
      sync_install = false,

      -- Automatically install missing parsers
      auto_install = true,

      highlight = {
        enable = true, -- Enable highlighting
        additional_vim_regex_highlighting = false, -- Avoid double highlights
      },
    })

    -- Treesitter folding settings
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  end,
}
