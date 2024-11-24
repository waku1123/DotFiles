-- ステータスバーに色付けして表示するプラグイン
if not vim.g.vscode then
  return {
    "nvim-lualine/lualine.nvim",
    version = "*",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    event = { "VimEnter" },
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "tokyonight",
          --component_separators = { left = "", right = ""},
          --section_separators = { left = "", right = ""},
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = {
            {
              "filename",
              file_status = true,
              path = 3,
              shorting_target = 60,
              symbols = { 
                modified = "[+]",
                readonly = "[-]",
                unnamed = "[No Name]",
                newfile = "[New]",
              }
            },
          },
          lualine_x = { 
            { "encoding", show_bomb = true },
            "fileformat",
            "filetype",
          },
          lualine_y = { "location", "progress" },
          lualine_z = {
            { "datetime", style = "%Y/%m/%d %H:%M:%S" }
          }
        },
        inactive_sections = {
          lualine_a = {
            {
              "filename",
              path = 4,
            },
          },
          lualine_b = {
          },
          lualine_c = {
          },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = { "neo-tree", "aerial", "toggleterm", "mason", "lazy" }
      })
    end
  }
else
  print("LuaLine is disabled in VSCode mode")
  return {}
end
