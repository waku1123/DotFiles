local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
  return
end

local sources = {
  -- python
  null_ls.builtins.formatting.black.with({
    extra_args = { "--line-length=150" }
  }),
  -- null_ls.builtins.formatting.ruff.with({
  --   "--line-length=150",
  -- }),
  null_ls.builtins.formatting.isort.with({
    "--multi-line=3",
    "--trailing-cmma",
    "--force-grid-wrap=0",
    "--use-parentheses",
    "--line-width=150",
  }),
  -- null_ls.builtins.diagnostics.flake8.with({
  --   diagnostics_format = '[flake8] #{m}\n(#{c})',
  --   extra_args = { "--max-line-length=150" }
  -- }),
  null_ls.builtins.diagnostics.mypy.with({
    diagnostics_format = '[mypy] #{m}\n(#{c})'
  }),
  null_ls.builtins.diagnostics.ruff.with({
    diagnostics_format = '[ruff] #{m}\n(#{c})',
    extra_args = {
      "--line-length=150",
      "--ignore=AN101", -- Missing docstring in public class
      "--ignore=D100", -- Missing docstring in public module
      "--ignore=D205", -- 1 blank line required between summary line and description
      "--ignore=D212", -- Multi-line docstring summary should start at the first line
      "--ignore=D415", -- First line should end with a period
    },
  }),
  -- Lua
  null_ls.builtins.formatting.stylua,
  -- Golang
  null_ls.builtins.formatting.gofumpt,
  null_ls.builtins.formatting.goimports,
  -- JavaScript/TypeSctipt
  null_ls.builtins.formatting.prettierd.with({
    filetypes = {"html", "css", "yaml", "markdown"},
    extra_filetypes = {"toml"},
  }),
  null_ls.builtins.diagnostics.eslint_d.with({
    diagnostics_format = '[eslint] #{m}\n(#{c})'
  }),
  -- Json
  null_ls.builtins.formatting.jq,
}

null_ls.setup({ sources = sources })
