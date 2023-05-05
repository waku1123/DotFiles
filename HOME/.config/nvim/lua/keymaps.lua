local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

--local keymap = vim.keymap
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',

-- Normal --
-- タブを新規作成
keymap("n", "te", ":tabedit", opts)
-- 新しいタブを一番右に作る
keymap("n", "gn", ":tabnew<Return>", opts)
-- 左右にタブ移動
keymap("n", "gh", "gT", opts)
keymap("n", "gl", "gt", opts)

-- ペイン分割('s'plit)
keymap("n", "ss", ":split<Return><C-w>w", opts)
keymap("n", "sv", ":vsplit<Return><C-w>w", opts)
-- ペインのフォーカス移動
keymap("n", "sh", "<C-w>h", opts)
keymap("n", "sj", "<C-w>j", opts)
keymap("n", "sk", "<C-w>k", opts)
keymap("n", "sl", "<C-w>l", opts)
-- ペインサイズ調整
-- 横幅 ('r'esize)
keymap("n", "rh", "<C-w>10<", opts)
keymap("n", "rl", "<C-w>10>", opts)
-- 縦幅
keymap("n", "rk", "<C-w>10+", opts)
keymap("n", "rj", "<C-w>10-", opts)

-- 行の端に行く
keymap("n", "<Space>h", "^", opts)
keymap("n", "<Space>l", "$", opts)

-- 行末までのヤンクにする
keymap("n", "Y", "y$", opts)

-- <Space>q で強制終了
keymap("n", "<Space>q", ":<C-u>q!<Return>", opts)

-- ESC*2 でハイライトやめる
keymap("n", "<Esc><Esc>", ":<C-u>set nohlsearch<Return>", opts)

-- Insert --
-- Press jj fast to exit insert mode
keymap("i", "jj", "<ESC>", opts)

-- 検索結果を画面中央に持ってくる
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- ビジュアルモード時vで行末まで選択
keymap("v", "v", "$h", opts)

-- インサートモードのままカーソル移動
-- Ctrl+fで一つ右へ移動
keymap("i", "<C-f>", "<C-g>U<Right>", opts)
-- Ctrl+f Ctrl+fで一番外へ移動
keymap("i", "<C-f><C-f>", "<C-g>U<Esc><S-a>", opts)

-- :Tでターミナル
--vim.cmd([[
--    command! -nargs=* T split | wincmd j | resize 30 | terminal <args>
--]])
--vim.cmd([[autocmd Termopen * startinsert]])
keymap("t", "<Esc>", "<C-\\><C-n>", opts)
