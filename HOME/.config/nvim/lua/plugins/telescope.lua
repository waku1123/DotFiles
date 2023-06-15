local u = require("utils")
local opt = { silent = true }
-- Telescope
require("telescope").setup({
  defaults = {
    sorting_strategy = "ascending", --検索結果を上から下に並べる
    layout_config = {
      vertical = { height = 0.5, width=0.9 },
      horizontal = { height = 0.5, width = 0.9 },
      center = { height = 0.5, width = 0.9 },
    },
    winblend = 20, --ウィンドウを若干半透明にする   
    file_ignore_patterns = { --検索結果に含めないファイルを指定
      "^.git/",
      "^node_modules/",
      "^__pycache__/",
    },
    mappings = {
      n = {
        ['<C-d>'] = require('telescope.actions').delete_buffer
      },
      i = {
        ['<C-d>'] = require('telescope.actions').delete_buffer
      }
    }
  },
  pickers = {
    find_files = {
      -- theme="dropdown",
    },
    live_grep = {
      -- theme="dropdown",
    },
    colorscheme = {
      enable_preview = true,
    },
  },
  extentions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {}
    },
    ["docker"] = {
      theme = "ivy",
      binary = "docker",
      log_level = vim.log.levels.INFO,
      init_term = "split new",
    },
    ["aerial"] = {
      ["_"] = false,
      json = true,
      yaml = true,
    },
  },
})
require("telescope").load_extension("ui-select")
require("telescope").load_extension("noice")
require("telescope").load_extension("docker")
require("telescope").load_extension("aerial")
require("telescope").load_extension("vim_bookmarks")

vim.g["fern#default_hidden"] = true --隠しファイルは表示する

-- Ctrl+p で曖昧ファイル検索
u.keymap("n", "<C-p>", ":Telescope find_files hidden=true<CR>", opt)
-- Ctrl+g で曖昧ファイル内文字列検索
u.keymap("n", "<C-g>", ":Telescope live_grep<CR>", opt)
-- Ctrl+b でプロジェクト内のTODOを検索
u.keymap("n", "<C-b>", ":TodoTelescope<CR>", opt)
-- gr で カーソル下変数参照一覧を検索
u.keymap("n", "gr", ":Telescope lsp_references<CR>", opt)
-- Git ブランチ一覧からチェックアウト
u.keymap("n", "<S-g>b", ":Telescope git_branches<CR>", opt)

-- docker
u.keymap("n", "<C-d>c", ":Telescope docker containers theme=ivy<CR>")
u.keymap("n", "<C-d>i", ":Telescope docker images theme=ivy<CR>")
u.keymap("n", "<C-d>p", ":Telescope docker compose theme=ivy<CR>")
u.keymap("n", "<C-d>l", ":Telescope docker files theme=ivy<CR>")

-- バッファー一覧
u.keymap("n", "<C-S-b>", ":Telescope buffers<CR>")
-- ブックマーク一覧
u.keymap("n", "<C-v>bm", ":Telescope vim_bookmarks all<CR>")
-- アウトライン
u.keymap("n", "<C-s>t", ":Telescope aerial theme=dropdown<CR>")
