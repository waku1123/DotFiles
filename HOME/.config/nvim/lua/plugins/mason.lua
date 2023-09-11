local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
  return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
  return
end


local my_on_attach = function(client, bufnr)
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local opts = { noremap = true, silent = false }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gf", "<cmd>lua vim.lsp.buf.format {async=true}<CR>", opts)
  -- 'K' でカーソル下の変数情報を表示
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  -- 'gr' でカーソル下の変数を参照している箇所の一覧表示
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- 定義へジャンプ
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  -- 宣言へジャンプ
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  -- 実装へジャンプ
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  -- 型定義へジャンプ
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  -- Error/Warning/Hint が出ている箇所で実行可能な修正の候補を表示
  vim.api.nvim_buf_set_keymap(bufnr, "n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  -- 変数名のリネーム
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

  vim.api.nvim_buf_set_keymap(bufnr, "n", "go", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  -- 次のエラーへジャンプ
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)

  -- Reference highlight(カーソル下の変数をコード内でハイライトする)
  local cap = client.server_capabilities
  if cap.documentHighlightProvider then
    vim.cmd("set updatetime=500")
    vim.cmd [[
      highlight LspReferenceText cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
      highlight LspReferenceRead cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
      highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
    ]]
    vim.cmd [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold,CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved,CursorMovedI <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end
end

mason.setup()
mason_lspconfig.setup({
  automatic_installation = true,
  -- LSP install
  ensure_installed = {
    -- python
    "pyright",
    -- sphinx
    "esbonio",
    -- rust
    "rust_analyzer",
    -- go
    "gopls",
    -- typescript
    "tsserver",
    -- lua
    "lua_ls",
    -- deno
    "denols",
    -- eslint
    "eslint",
    -- php
    "intelephense",
    -- kotlin
    "kotlin_language_server",
    -- dockerfile
    "dockerls",
    -- yaml
    "yamlls",
    -- json
    "jsonls",
    -- toml
    "taplo",
  },
})
local nvim_lsp = require("lspconfig")
mason_lspconfig.setup_handlers({
  function(server)
    local opt = {
      -- Function executed when the LSP server startup
      on_attach = my_on_attach,
      capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    }
    local node_root_dir = nvim_lsp.util.root_pattern("package.json")
    local is_node_repo = node_root_dir(vim.api.nvim_buf_get_name(0)) ~= nil

    if server == "pyright" then
      opt.settings = {
        python = {
          venvPath = ".",
          pythonPath = "./.venv/bin/python",
          analysis = {
            extraPaths = { "." },
          },
        },
      }
    end

    if server == "tsserver" then
      if not is_node_repo then
        return
      end
      opt.root_dir = node_root_dir
    elseif server == "eslint" then
      if not is_node_repo then
        return
      end
      opt.root_dir = node_root_dir
    elseif server == "denols" then
      if is_node_repo then
        return
      end
      opt.root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc", "deps.ts", "import_map.json")
      opt.init_options = {
        lint = true,
        unstable = true,
        suggest = {
          imports = {
            hosts = {
              ["https://deno.land"] = true,
              ["https://cdn.nest.land"] = true,
              ["https://crux.land"] = true,
            },
          },
        },
      }
    end

    nvim_lsp[server].setup(opt)
    require("mason-null-ls").setup({
      automatic_setup = true,
      automatic_installation = true,
      ensure_installed = {
        -- JS/TS
        "prittiered",
        "eslint_d",
        -- lua
        "stylua",
        -- python
        "black",
        "isort",
        "flake8",
        "mypy",
        "debugpy",
        -- Go
        "goimports",
        "staticcheck",
        -- json
        "jq",
      },
    })
  end,
})
-- LSP handlers
vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false })
-- エラーアイコンの変更
local signs = { Error = "", Warn = "", Hint = "", Info = "" }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
