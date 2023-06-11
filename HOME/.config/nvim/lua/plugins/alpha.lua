local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local coolLines = {
  [[    ███╗   ███╗ █████╗ ██╗  ██╗███████╗   ]],
  [[    ████╗ ████║██╔══██╗██║ ██╔╝██╔════╝   ]],
  [[    ██╔████╔██║███████║█████╔╝ █████╗     ]],
  [[    ██║╚██╔╝██║██╔══██║██╔═██╗ ██╔══╝     ]],
  [[    ██║ ╚═╝ ██║██║  ██║██║  ██╗███████╗   ]],
  [[    ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝   ]],
  [[      ██████╗ ██████╗  ██████╗ ██╗        ]],
  [[     ██╔════╝██╔═══██╗██╔═══██╗██║        ]],
  [[     ██║     ██║   ██║██║   ██║██║        ]],
  [[     ██║     ██║   ██║██║   ██║██║        ]],
  [[     ╚██████╗╚██████╔╝╚██████╔╝███████╗   ]],
  [[      ╚═════╝ ╚═════╝  ╚═════╝ ╚══════╝   ]],
  [[███████╗████████╗██╗   ██╗███████╗███████╗]],
  [[██╔════╝╚══██╔══╝██║   ██║██╔════╝██╔════╝]],
  [[███████╗   ██║   ██║   ██║█████╗  █████╗  ]],
  [[╚════██║   ██║   ██║   ██║██╔══╝  ██╔══╝  ]],
  [[███████║   ██║   ╚██████╔╝██║     ██║     ]],
  [[╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝     ]],
}

local robustLines  = {
  [[        ██████╗ ██╗   ██╗██╗██╗     ██████╗         ]],
  [[        ██╔══██╗██║   ██║██║██║     ██╔══██╗        ]],
  [[        ██████╔╝██║   ██║██║██║     ██║  ██║        ]],
  [[        ██╔══██╗██║   ██║██║██║     ██║  ██║        ]],
  [[        ██████╔╝╚██████╔╝██║███████╗██████╔╝        ]],
  [[        ╚═════╝  ╚═════╝ ╚═╝╚══════╝╚═════╝         ]],
  [[ ██████╗  ██████╗ ██████╗ ██╗   ██╗███████╗████████╗]],
  [[ ██╔══██╗██╔═══██╗██╔══██╗██║   ██║██╔════╝╚══██╔══╝]],
  [[ ██████╔╝██║   ██║██████╔╝██║   ██║███████╗   ██║   ]],
  [[ ██╔══██╗██║   ██║██╔══██╗██║   ██║╚════██║   ██║   ]],
  [[ ██║  ██║╚██████╔╝██████╔╝╚██████╔╝███████║   ██║   ]],
  [[ ╚═╝  ╚═╝ ╚═════╝ ╚═════╝  ╚═════╝ ╚══════╝   ╚═╝   ]],
  [[     ███████╗████████╗██╗   ██╗███████╗███████╗     ]],
  [[     ██╔════╝╚══██╔══╝██║   ██║██╔════╝██╔════╝     ]],
  [[     ███████╗   ██║   ██║   ██║█████╗  █████╗       ]],
  [[     ╚════██║   ██║   ██║   ██║██╔══╝  ██╔══╝       ]],
  [[     ███████║   ██║   ╚██████╔╝██║     ██║          ]],
  [[     ╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝          ]],
}


local efficientLines  = {
  [[             ██████╗██████╗  █████╗ ███████╗████████╗            ]],
  [[            ██╔════╝██╔══██╗██╔══██╗██╔════╝╚══██╔══╝            ]],
  [[            ██║     ██████╔╝███████║█████╗     ██║               ]],
  [[            ██║     ██╔══██╗██╔══██║██╔══╝     ██║               ]],
  [[            ╚██████╗██║  ██║██║  ██║██║        ██║               ]],
  [[             ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝        ╚═╝               ]],
  [[███████╗███████╗███████╗██╗ ██████╗██╗███████╗███╗   ██╗████████╗]],
  [[██╔════╝██╔════╝██╔════╝██║██╔════╝██║██╔════╝████╗  ██║╚══██╔══╝]],
  [[█████╗  █████╗  █████╗  ██║██║     ██║█████╗  ██╔██╗ ██║   ██║   ]],
  [[██╔══╝  ██╔══╝  ██╔══╝  ██║██║     ██║██╔══╝  ██║╚██╗██║   ██║   ]],
  [[███████╗██║     ██║     ██║╚██████╗██║███████╗██║ ╚████║   ██║   ]],
  [[╚══════╝╚═╝     ╚═╝     ╚═╝ ╚═════╝╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝   ]],
  [[  ███████╗██╗   ██╗███████╗████████╗███████╗███╗   ███╗███████╗  ]],
  [[  ██╔════╝╚██╗ ██╔╝██╔════╝╚══██╔══╝██╔════╝████╗ ████║██╔════╝  ]],
  [[  ███████╗ ╚████╔╝ ███████╗   ██║   █████╗  ██╔████╔██║███████╗  ]],
  [[  ╚════██║  ╚██╔╝  ╚════██║   ██║   ██╔══╝  ██║╚██╔╝██║╚════██║  ]],
  [[  ███████║   ██║   ███████║   ██║   ███████╗██║ ╚═╝ ██║███████║  ]],
  [[  ╚══════╝   ╚═╝   ╚══════╝   ╚═╝   ╚══════╝╚═╝     ╚═╝╚══════╝  ]],
}

vim.cmd[[
hi StartLogo1 ctermfg=18 guifg=#14067E
hi StartLogo2 ctermfg=18 guifg=#15127B
hi StartLogo3 ctermfg=18 guifg=#171F78
hi StartLogo4 ctermfg=18 guifg=#182B75
hi StartLogo5 ctermfg=23 guifg=#193872
hi StartLogo6 ctermfg=23 guifg=#1A446E
hi StartLogo7 ctermfg=23 guifg=#1C506B
hi StartLogo8 ctermfg=23 guifg=#1D5D68
hi StartLogo9 ctermfg=23 guifg=#1E6965
hi StartLogo10 ctermfg=29 guifg=#1F7562
hi StartLogo11 ctermfg=29 guifg=#21825F
hi StartLogo12 ctermfg=29 guifg=#228E5C
hi StartLogo13 ctermfg=35 guifg=#239B59
hi StartLogo14 ctermfg=35 guifg=#24A755
hi StartLogo15 ctermfg=35 guifg=#26B352
hi StartLogo16 ctermfg=35 guifg=#27C04F
hi StartLogo17 ctermfg=41 guifg=#28CC4C
hi StartLogo18 ctermfg=41 guifg=#29D343
hi StartLogoPop1 ctermfg=214 guifg=#EC9F05
hi StartLogoPop2 ctermfg=208 guifg=#F08C04
hi StartLogoPop3 ctermfg=208 guifg=#F37E03
hi StartLogoPop4 ctermfg=202 guifg=#F77002
hi StartLogoPop5 ctermfg=202 guifg=#FB5D01
hi StartLogoPop6 ctermfg=202 guifg=#FF4E00
]]

local function lineToStartGradient(lines)
  local out = {}
  for i, line in ipairs(lines) do
    table.insert(out, { hi = "StartLogo"..i, line = line})
  end
  return out
end

local function lineToStartPopGradient(lines)
  local out = {}
  for i, line in ipairs(lines) do
    local hi = "StartLogo" .. i
    if i <= 6 then
      hi = "StartLogo" .. i + 6
    elseif i > 6 and i <= 12 then
      hi = "StartLogoPop" .. i - 6
    end
    table.insert(out, { hi = hi, line = line})
  end
  return out
end

local function lineToStartShiftGradient(lines)
  local out = {}
  for i, line in ipairs(lines) do
    local n = i
    if i > 6 and i <= 12 then
      n = i + 6
    elseif i > 12 then
      n = i - 6
    end
    table.insert(out, { hi = "StartLogo"..n, line = line})
  end
  return out
end

local cool = lineToStartPopGradient(coolLines)
local robust = lineToStartShiftGradient(robustLines)
local efficient = lineToStartGradient(efficientLines)

local headers = {cool, robust, efficient}

local function header_chars()
  math.randomseed(os.time())
  return headers[math.random(#headers)]
end

local function header_color()
  local lines = {}
  for i, lineConfig in pairs(header_chars()) do
    local hi = lineConfig.hi
    local line_chars = lineConfig.line
    local line = {
      type = "text",
      val = line_chars,
      opts = {
        hl = hi,
        shrink_margin = false,
        position = "center",
      },
    }
    table.insert(lines, line)
  end

  local output = {
    type = "group",
    val = lines,
    opts = { position = "center", },
  }

  return output
end

local theme = require("alpha.themes.theta")
local config = theme.config
local dashboard = require("alpha.themes.dashboard")
local buttons = {
  type = "group",
  val = {
    { type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center"}},
    { type = "padding", val = 1},
    dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
    dashboard.button( "f", "󰱼  > Find file", ":Telescope find_files<CR>"),
    dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
    dashboard.button( "s", "  > Settings" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
    dashboard.button( "u", "󰚥  > Update Plugins", ":PackerUpdate<CR>"),
    dashboard.button( "q", "󰩈  > Quit NVIM", ":qa<CR>"),
  },
  position = "center",
}

config.layout[2] = header_color()
config.layout[6] = buttons
alpha.setup(config)
