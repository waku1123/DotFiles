return {
  "akinsho/toggleterm.nvim",
  version = '*',
  keys = {
    -- {"<c-t><c-t>", ":ToggleTerm direction=float<CR>", mode = "n", desc = "Toggle Terminal as float Window"},
    -- {"<C-t><C-v>", ":ToggleTerm direction=vertical<CR>", mode = "n", desc = "Show Terminal at Right Pane"},
    -- {"<c-t><c-t>", "<c-\\><c-n>:ToggleTerm<CR>", mode = "t", desc = "Close Terminal"},
    {"<leader>g", "<cmd>lua _lazygit_toggle()<cr>", mode = "n", desc = "Toggle Lazygit"},
  },
  config = function()
    require("toggleterm").setup(
      {
          size = function(term)
          if term.direction == "horizontal" then
              return 15
          elseif term.direction == "vertical" then
              return 70
          else
              return 20
          end
          end,
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
      --  dir = "git_dit", -- the directory for the terminal
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
