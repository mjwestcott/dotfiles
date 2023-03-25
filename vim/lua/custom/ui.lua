vim.o.background = "dark"
vim.api.nvim_command([[colorscheme zenburn]])
vim.api.nvim_set_hl(0, "StatusLine", { fg = "#5f7f5f", bg = "#353535" })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#5d6262", bg = "#353535" })
vim.api.nvim_set_hl(0, "gitcommitSummary", { fg = "#dcdccc" })
vim.api.nvim_set_hl(0, "gitcommitOverflow", { fg = "#7cb8bb" })
vim.api.nvim_set_hl(0, "diffAdded", { fg = "#7f9f7f" })
vim.api.nvim_set_hl(0, "diffRemoved", { fg = "#e89393" })
vim.api.nvim_set_hl(0, "diffChanged", { fg = "#e0cf9f" })
vim.api.nvim_set_hl(0, "diffLine", { fg = "#dcdccc" })
vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#284f28" })
vim.api.nvim_set_hl(0, "DiffDelete", { fg = "#000000", bg = "#4f2828" })
vim.api.nvim_set_hl(0, "DiffChange", { bg = "#353535" })
vim.api.nvim_set_hl(0, "DiffText", { bg = "#5d6262" })
vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#7f9f7f" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#5d6262", bg = "#353535" })
vim.api.nvim_set_hl(0, "GitSignsAddNr", { fg = "#7f9f7f", bg = "#284f28" })
vim.api.nvim_set_hl(0, "GitSignsChangeNr", { fg = "#e0cf9f", bg = "#4f4f28" })
vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { fg = "#e89393", bg = "#4f2828" })

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- Indent blankline
require("indent_blankline").setup({
  char = "┊",
  show_trailing_blankline_indent = false,
})
