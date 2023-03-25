-- Configure Telescope
require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
        ["<esc>"] = require("telescope.actions").close,
      },
    },
  },
})

local function get_project_root()
  local util = require("lspconfig.util")
  local lsp_root = util.root_pattern(".git")(vim.fn.expand("%:p"))

  if lsp_root then
    return lsp_root
  else
    local rooter_root = vim.g.rooter_silent_chdir == 0 and vim.fn.getcwd() or nil
    return rooter_root or vim.fn.getcwd()
  end
end

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

vim.keymap.set("n", ",,", require("telescope.builtin").oldfiles, { desc = "Find recently opened files" })
vim.keymap.set("n", ",b", require("telescope.builtin").buffers, { desc = "Find existing buffers" })
vim.keymap.set("n", ",d", require("telescope.builtin").diagnostics, { desc = "Search [D]iagnostics" })
vim.keymap.set("n", ",h", require("telescope.builtin").help_tags, { desc = "Search [H]elp" })
vim.keymap.set("n", ",/", function()
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "Fuzzily search in current buffer" })
vim.keymap.set("n", ",t", function()
  local project_root = get_project_root()
  require("telescope.builtin").find_files({
    search_dirs = { project_root },
  })
end, { desc = "Search [F]iles" })
vim.keymap.set("n", ",w", function()
  local project_root = get_project_root()
  require("telescope.builtin").grep_string({
    search_dirs = { project_root },
  })
end, { desc = "Search current [W]ord" })
vim.keymap.set("n", ",g", function()
  local project_root = get_project_root()
  require("telescope.builtin").live_grep({
    search_dirs = { project_root },
  })
end, { desc = "Search by [G]rep" })
