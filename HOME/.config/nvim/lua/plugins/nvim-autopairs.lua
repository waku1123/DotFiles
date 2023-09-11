local autopairs_ok, autopairs = pcall(require, "nvim-autopairs")
if not autopairs_ok then
  return
end

autopairs.setup({
  -- Default Config
  disable_filetype = {"TelescopePrompt", "spectre_panel"},
  disable_in_macro = true,
  disable_in_visualblock = false,
  disable_in_replace_mode = true,
  ignored_next_char  = [=[[%w%%%'%[%"%.%`%$]]=],
  enable_moveright = true,
  enable_afterquote = true,
  enable_check_bracket_line = true,
  enable_moveright_bracket_in_quote = true,
  enable_abbr = false,
  break_undo = true,
  check_ts = false,
  map_cr = true,
  map_bs = true,
  map_c_h = false,
  map_c_w = false,
})
