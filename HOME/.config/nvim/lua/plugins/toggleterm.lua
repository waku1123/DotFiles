-- ターミナルをfloat windowで開くプラグイン
return {
  "akinsho/toggleterm.nvim",
  version = '*',
  keys = {
    {"<c-t><c-m>", ":ToggleTerm direction=horizontal<CR>", mode = "n", desc = "水平分割でターミナルをトグル"},
    {"<c-t><c-v>", ":ToggleTerm direction=vertical<CR>", mode = "n", desc = "垂直分割でターミナルをトグル"},
    {"<c-t><c-f>", ":ToggleTerm direction=float<CR>", mode = "n", desc = "Floatウィンドウでターミナルをトグル"},
    {"<c-t><c-m>", "<c-\\><c-n>:ToggleTerm<CR>", mode = "t", desc = "ターミナルを閉じる"},
    {"<leader>g", "<cmd>lua _lazygit_toggle()<cr>", mode = "n", desc = "Lazygitを開く"},
  },
  config = function()
    require("toggleterm").setup(
      {
        size = function(term)
          if term.direction == "horizontal" then
              return 30
          elseif term.direction == "vertical" then
              return 70
          else
              return 20
          end
        end,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = true,
        hide_numbers = true,
        dicrection = "float",
        close_on_exit = true,
        clear_env = false,
        shell = vim.o.shell,
        auto_scroll = true,
        float_opts = {
          border = "curved",
          winblend = 20,
        },
        winbar = {
          enabled = true,
          name_formatter = function(term)
              return term.name
          end
        },
      }
    )
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",     -- command to execute when creating the terminal e.g. 'top'
      --  dir = "git_dir", -- the directory for the terminal
      direction = "float", -- the layout for the terminal, same as the main config options
      float_opts = {
        border = "double",
      },
      -- function to run on opening the terminal
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      end,
      -- function to run on closing the terminal
      on_close = function(_)
        vim.cmd("startinsert!")
      end,
    })

    function _lazygit_toggle()
      lazygit:toggle()
    end

  end
}
