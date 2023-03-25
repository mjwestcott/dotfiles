-- Lualine customisation
local custom_zenburn = require("lualine.themes.zenburn")
custom_zenburn.normal.b.bg = "#353535"
custom_zenburn.insert.b.bg = "#353535"
custom_zenburn.visual.b.bg = "#353535"
custom_zenburn.replace.b.bg = "#353535"
custom_zenburn.command.b.bg = "#353535"
custom_zenburn.normal.c.bg = "#353535"
custom_zenburn.insert.c.bg = "#353535"
custom_zenburn.visual.c.bg = "#353535"
custom_zenburn.replace.c.bg = "#353535"
custom_zenburn.command.c.bg = "#353535"
custom_zenburn.normal.z.bg = custom_zenburn.normal.b.bg
custom_zenburn.insert.z.bg = custom_zenburn.insert.b.bg
custom_zenburn.visual.z.bg = custom_zenburn.visual.b.bg
custom_zenburn.replace.z.bg = custom_zenburn.replace.b.bg
custom_zenburn.command.z.bg = custom_zenburn.command.b.bg
custom_zenburn.normal.z.fg = custom_zenburn.normal.b.fg
custom_zenburn.insert.z.fg = custom_zenburn.insert.b.fg
custom_zenburn.visual.z.fg = custom_zenburn.visual.b.fg
custom_zenburn.replace.z.fg = custom_zenburn.replace.b.fg
custom_zenburn.command.z.fg = custom_zenburn.command.b.fg

require("lualine").setup({
  options = {
    icons_enabled = false,
    theme = custom_zenburn,
    component_separators = "",
    section_separators = "",
  },
  sections = {
    lualine_a = { {
      "mode",
      fmt = function(str)
        return str:sub(1, 1)
      end,
    } },
    lualine_b = {
      { "branch", padding = { left = 2, right = 1 }, color = { fg = "#7f9f7f" } },
      { "filename", color = { fg = "#7f9f7f" } },
      "diff",
      "diagnostics",
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {
      { "location", color = { fg = "#7f9f7f" } },
      { "progress", color = { fg = "#7f9f7f" }, padding = { left = 1, right = 0 } },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})
