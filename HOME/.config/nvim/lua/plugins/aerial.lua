-- コードアウトラインを表示するプラグイン
return {
  "stevearc/aerial.nvim",
  lazy = true,
  dependencies = "nvim-tree/nvim-web-devicons",
  keys = {
      { "<Leader>a", "<cmd>AerialToggle!<CR>", mode = "n", desc = "Toggle Show OutLine"}
  },
  config = function()
    require("aerial").setup({
      layout = {
        max_width = { 40, 0.3 },
        width = nil,
        min_width = 20,
        win_opts = {
          winblend = 10,
        },
        default_direction = "float",
        placement = "window",
      },
      atacch_mode = "window",
      close_automatic_events = {
        "unsupported",
      },
      highlight_mode = "last",
      show_guides = true,
      float = {
        border = "rounded",
        relative = "win",
        max_height = 0.4,
        height = nil,
        min_height = 8,
        override = function(conf, source_winid)
          conf.title = "Out Line"
          conf.title_pos = "center"
          -- Telescopeの下に表示する
          conf.zindex = 49
          conf.anchor = "SE"
          conf.col = vim.fn.winwidth(source_winid)
          conf.row = vim.fn.winwidth(source_winid)
          return conf
        end,
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>k', '<cmd>AerialPrev<CR>', { buffer = bufnr, desc = "Jump Prev OutLine" })
        vim.keymap.set('n', '<leader>j', '<cmd>AerialNext<CR>', { buffer = bufnr, desc = "Jump Next OutLine" })
      end
    })
  end
}
