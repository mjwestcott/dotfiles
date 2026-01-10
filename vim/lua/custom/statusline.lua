-- Lualine customisation
local custom_zenburn = require("lualine.themes.zenburn")
local bg = "#353535"

-- Apply consistent background to all mode sections
for _, mode in ipairs({ "normal", "insert", "visual", "replace", "command" }) do
  custom_zenburn[mode].b.bg = bg
  custom_zenburn[mode].c.bg = bg
  custom_zenburn[mode].z.bg = custom_zenburn[mode].b.bg
  custom_zenburn[mode].z.fg = custom_zenburn[mode].b.fg
end

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
