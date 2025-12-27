local colors = {
  bg = "#0E1415",
  fg = "#c6c6c6",
  blue = "#80a0ff",
  cyan = "#79dac8",
  red = "#ff5189",
  violet = "#d183e8",
  grey = "#303030",
  black = "#080808",
}

return {
  normal = {
    a = { fg = colors.black, bg = colors.violet, gui = "bold" },
    b = { fg = colors.fg, bg = colors.grey },
    c = { fg = colors.fg, bg = colors.bg },
  },

  insert = {
    a = { fg = colors.black, bg = colors.blue, gui = "bold" },
    b = { fg = colors.fg, bg = colors.grey },
    c = { fg = colors.fg, bg = colors.bg },
  },

  visual = {
    a = { fg = colors.black, bg = colors.cyan, gui = "bold" },
    b = { fg = colors.fg, bg = colors.grey },
    c = { fg = colors.fg, bg = colors.bg },
  },

  replace = {
    a = { fg = colors.black, bg = colors.red, gui = "bold" },
    b = { fg = colors.fg, bg = colors.grey },
    c = { fg = colors.fg, bg = colors.bg },
  },

  inactive = {
    a = { fg = colors.fg, bg = colors.bg },
    b = { fg = colors.fg, bg = colors.bg },
    c = { fg = colors.fg, bg = colors.bg },
  },
}
