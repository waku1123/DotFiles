-- File Explorer プラグイン
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    keys = {
      { "<C-t><C-t>", ":Neotree toggle<CR>", mode = "n", desc = "ファイルエクスプローラをトグル" },
    },
    depencencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-tree/nvim-web-devicons" },
      { "MunifTanjim/nui.nvim" },
      { "s1n7ax/nvim-window-picker" },
    },
    config = function ()
      -- If you want icons for diagnostic errors, you'll need to define them somewhere:
      vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn",  { text = " ", texthl = "DiagnosticSignWarn"  })
      vim.fn.sign_define("DiagnosticSignInfo",  { text = " ", texthl = "DiagnosticSignInfo"  })
      vim.fn.sign_define("DiagnosticSignHint",  { text = "󰌵",  texthl = "DiagnosticSignHint"  })
      require("neo-tree").setup({
        close_if_last_wndow                  = false,
        popup_border_style                   = "rounded",
        enable_git_status                    = true,
        enable_diagnostics                   = true,
        open_files_do_not_replace_types      = { "terminal", "trouble", "qf" },
        sort_case_insensitive                = false,
        sort_function                        = nil,
        use_default_mappings                 = false,
        default_component_configs            = {
          container                          = {
            enable_character_fade            = true,
          },
          indent                             = {
            indent_size                      = 2,
            padding                          = 1,
            with_markers                     = true,
            indent_marker                    = "|",
            last_indent_marker               = "└",
            highlight                        = "NeoTreeIndentMarker",
            with_expanders                   = nil,
            expander_collapsed               = "",
            expander_expanded                = "",
            expander_highlight               = "NeoTreeExpander",
          },
          icon                               = {
            folder_closed                    = "",
            folder_open                      = "",
            folder_empty                     = "󱞞",
            provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
              if node.type == "file" or node.type == "terminal" then
                local success, web_devicons = pcall(require, "nvim-web-devicons")
                local name = node.type == "terminal" and "terminal" or node.name
                if success then
                  local devicon, hl = web_devicons.get_icon(name)
                  icon.text = devicon or icon.text
                  icon.highlight = hl or icon.highlight
                end
              end
            end,
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default                          = "*",
            highlight                        = "NeoTreeFileIcon"
          },
          modified = {
            symbol                           = "[+]",
            highlight                        = "NeoTreeModified",
          },
          name = {
            trailing_slash                   = false,
            use_git_status_colors            = true,
            highlight                        = "NeoTreeFileName",
          },
          git_status = {
            symbols = {
              -- Change type
              added                          = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
              modified                       = " ", -- or "", but this is redundant info if you use git_status_colors on the name
              deleted                        = "",-- this can only be used in the git_status source
              renamed                        = " ",-- this can only be used in the git_status source
              -- Status type
              untracked                      = " ",
              ignored                        = "",
              unstaged                       = "󰄱",
              staged                         = "",
              conflict                       = " ",
            }
          },
          file_size = {
            enabled                          = true,
            required_width                   = 64, -- min width of window required to show this column
          },
          type = {
            enabled                          = true,
            required_width                   = 122, -- min width of window required to show this column
          },
          last_modified = {
            enabled                          = true,
            required_width                   = 88, -- min width of window required to show this column
          },
          created = {
            enabled                          = true,
            required_width                   = 110, -- min width of window required to show this column
          },
          symlink_target = { enabled = false },
        },
        commands = {},
        window = {
          position = "left",
          width = 40,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ["<space>"] = {
                "toggle_node",
                nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use 
            },
            ["<2-LeftMouse>"] = "open",
            ["<cr>"]          = "open",
            ["<esc>"]         = "cancel", -- close preview or floating neo-tree window
            ["P"]             = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
            ["l"]             = "focus_preview",
            ["S"]             = nil, --"open_split",
            ["s"]             = nil, --"open_vsplit",
            -- ["S"] = "split_with_window_picker",
            -- ["s"] = "vsplit_with_window_picker",
            ["t"]             = "open_tabnew",
            -- ["<cr>"] = "open_drop",
            -- ["t"] = "open_tab_drop",
            -- ["w"] = "open_with_window_picker",
            --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
            ["C"]             = "close_node",
            -- ["C"] = "close_all_subnodes",
            ["z"]             = "close_all_nodes",
            --["Z"] = "expand_all_nodes",
            ["a"]             = {
              "add",
              -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
              -- some commands may take optional config options, see `:h neo-tree-mappings` for details
              config          = {
                show_path     = "none" -- "none", "relative", "absolute"
              }
            },
            ["A"]             = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
            ["d"]             = "delete",
            ["r"]             = "rename",
            ["y"]             = "copy_to_clipboard",
            ["x"]             = "cut_to_clipboard",
            ["p"]             = "paste_from_clipboard",
            ["c"]             = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
            -- ["c"] = {
            --  "copy",
            --  config = {
            --    show_path = "none" -- "none", "relative", "absolute"
            --  }
            --}
            ["m"]             = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ["q"]             = "close_window",
            ["R"]             = "refresh",
            ["?"]             = "show_help",
            ["<"]             = "prev_source",
            [">"]             = "next_source",
            ["i"]             = "show_file_details",
            ["<C-s>"]         = "open_split",  -- 水平分割で開く
            -- ["<C-s>"] = "split_with_window_picker",
            ["<C-v>"]         = "open_vsplit",  -- 垂直分割で開く
            -- ["<C-v>"] = "vsplit_with_window_picker",
            ["<tab>"] = function (state) -- ファイルを開いてもNeotreeを閉じない
              local node = state.tree:get_node()
              if require("neo-tree.utils").is_expandable(node) then
                state.commands["toggle_node"](state)
              else
                state.commands["open"](state)
                vim.cmd("Neotree reveal")
              end
            end,
          },
        },
        nesting_rules = {},
        filesystem = {
          filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = true,
            hide_hidden = false, -- only works on Windows for hidden files/directories
            hide_by_name = {},
            hide_by_pattern = {},
            always_show = {
              "hoge.py",
              "local.settings.json",
              ".pdm-python",
              ".tool-versions"
            },
            always_show_by_pattern = {
              ".env*",
              ".venv"
            },
            never_show = {
              ".DS_Store",
            },
            never_show_by_pattern = {
              "__pycache__",
              ".pytest_cache",
              ".mypy_cache",
              ".ruff_cache",
              ".vscode"
            },
          },
          follow_current_file = {
            enabled = true, -- focus があるbufferに追従する
            leave_dirs_open = true, -- ディレクトリを開いたままにする
          },
          group_empty_dirs = false, -- when true, empty folders will be grouped together
          hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                                                  -- in whatever position is specified in window.position
                                -- "open_current",  -- netrw disabled, opening a directory opens within the
                                                  -- window like netrw would, regardless of window.position
                                -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
          use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
                                          -- instead of relying on nvim autocmd events.
          window = {
            mappings = {
              ["<bs>"]  = "navigate_up",
              ["."]     = "set_root",
              ["H"]     = "toggle_hidden",
              --["/"] = "fuzzy_finder",
              --["D"] = "fuzzy_finder_directory",
              --["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
              -- ["D"] = "fuzzy_sorter_directory",
              --["f"] = "filter_on_submit",
              ["<c-x>"] = "clear_filter",
              ["[g"]    = "prev_git_modified",
              ["]g"]    = "next_git_modified",
              ["o"]     = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
              ["oc"]    = { "order_by_created", nowait = false },
              ["od"]    = { "order_by_diagnostics", nowait = false },
              ["og"]    = { "order_by_git_status", nowait = false },
              ["om"]    = { "order_by_modified", nowait = false },
              ["on"]    = { "order_by_name", nowait = false },
              ["os"]    = { "order_by_size", nowait = false },
              ["ot"]    = { "order_by_type", nowait = false },
              -- ["<key>"] = function(state) ... end,
            },
            fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
              ["<down>"] = "move_cursor_down",
              ["<C-n>"]  = "move_cursor_down",
              ["<up>"]   = "move_cursor_up",
              ["<C-p>"]  = "move_cursor_up",
              -- ["<key>"] = function(state, scroll_padding) ... end,
            },
          },

          commands = {} -- Add a custom command or override a global one using the same function namekj
        },
        buffers = {
          follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            --              -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          group_empty_dirs = true, -- when true, empty folders will be grouped together
          show_unloaded = true,
          window = {
            mappings = {
              ["bd"]   = "buffer_delete",
              ["<bs>"] = "navigate_up",
              ["."]    = "set_root",
              ["o"]    = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
              ["oc"]   = { "order_by_created", nowait = false },
              ["od"]   = { "order_by_diagnostics", nowait = false },
              ["om"]   = { "order_by_modified", nowait = false },
              ["on"]   = { "order_by_name", nowait = false },
              ["os"]   = { "order_by_size", nowait = false },
              ["ot"]   = { "order_by_type", nowait = false },
            }
          },
        },
        git_status = {
          window = {
            position = "float",
            mappings = {
              ["A"]  = "git_add_all",
              ["gu"] = "git_unstage_file",
              ["ga"] = "git_add_file",
              ["gr"] = "git_revert_file",
              ["gc"] = "git_commit",
              ["gp"] = "git_push",
              ["gg"] = "git_commit_and_push",
              ["o"]  = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
              ["oc"] = { "order_by_created", nowait = false },
              ["od"] = { "order_by_diagnostics", nowait = false },
              ["om"] = { "order_by_modified", nowait = false },
              ["on"] = { "order_by_name", nowait = false },
              ["os"] = { "order_by_size", nowait = false },
              ["ot"] = { "order_by_type", nowait = false },
            }
          }
        },
      })
    end,
  }
}
