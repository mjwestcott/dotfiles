-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>u", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Trouble.nvim
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })

-- Helper to detect project-specific Python linter
local function get_python_linters()
  local root = vim.fn.getcwd()
  local flake8_configs = { ".flake8", "setup.cfg", "tox.ini" }
  for _, config in ipairs(flake8_configs) do
    if vim.fn.filereadable(root .. "/" .. config) == 1 then
      return { "flake8" }
    end
  end
  return { "ruff" }
end

-- Helper to detect if project uses Biome
local function has_biome()
  local root = vim.fn.getcwd()
  return vim.fn.filereadable(root .. "/biome.json") == 1 or vim.fn.filereadable(root .. "/biome.jsonc") == 1
end

-- Helper to get JS/TS formatter
local function get_js_formatter()
  if has_biome() then
    return { "biome" }
  end
  return { "prettier" }
end

-- Helper to get JS/TS linters
local function get_js_linters()
  if has_biome() then
    return { "biomejs" }
  end
  return { "eslint" }
end

-- Setup conform.nvim for formatting
require("conform").setup({
  formatters_by_ft = {
    python = { "black", "isort" },
    javascript = get_js_formatter,
    javascriptreact = get_js_formatter,
    typescript = get_js_formatter,
    typescriptreact = get_js_formatter,
    css = { "prettier" },
    html = { "prettier" },
    json = get_js_formatter,
    jsonc = get_js_formatter,
    yaml = { "prettier" },
    markdown = { "prettier" },
    lua = { "stylua" },
    sh = { "shfmt" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})

-- Setup nvim-lint for diagnostics
require("lint").linters_by_ft = {
  python = get_python_linters(),
  javascript = get_js_linters(),
  javascriptreact = get_js_linters(),
  typescript = get_js_linters(),
  typescriptreact = get_js_linters(),
  sh = { "shellcheck" },
}

-- Auto-trigger linting
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
