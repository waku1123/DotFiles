-- Github Review を行えるプラグイン
return {
  "pwntester/octo.nvim",
  event = { "BufReadPre" },
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim" },
    { "nvim-tree/nvim-web-devicons" },
  },
  config = function()
    require("octo").setup({
      suppress_missing_scope = {
        projects_v2 = true,
      }
    })
  end,
}
