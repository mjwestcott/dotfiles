-- Colours
vim.o.background = "dark"
vim.api.nvim_command([[colorscheme zenburn]])

vim.api.nvim_set_hl(0, "Boolean", { link = "Number" })
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
vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#7f9f7f" })
vim.api.nvim_set_hl(0, "GitSignsAddNr", { fg = "#7f9f7f", bg = "#284f28" })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#e0cf9f" })
vim.api.nvim_set_hl(0, "GitSignsChangeNr", { fg = "#e0cf9f", bg = "#4f4f28" })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#e89393" })
vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { fg = "#e89393", bg = "#4f2828" })
vim.api.nvim_set_hl(0, "NeoTreeSymbolicLinkTarget", { link = "Operator" })
vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { link = "Number" })
vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { link = "Number" })
vim.api.nvim_set_hl(0, "NeoTreeRootName", { link = "Macro" })
vim.api.nvim_set_hl(0, "NeoTreeFilenameOpened", { bold = true })
vim.api.nvim_set_hl(0, "NeoTreeDotfile", { link = "Comment" })
vim.api.nvim_set_hl(0, "NeoTreeModified", { link = "String" })

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

-- Neo-tree
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

require("neo-tree").setup({
  close_if_last_window = true,
  popup_border_style = "rounded",
  enable_git_status = false,
  enable_diagnostics = true,
  open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
  sort_case_insensitive = false,
  sort_function = nil,
  default_component_configs = {
    container = {
      enable_character_fade = true,
    },
    indent = {
      indent_size = 2,
      padding = 1,
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
      with_expanders = nil,
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "ﰊ",
      default = " ",
      highlight = "NeoTreeFileIcon",
    },
    modified = {
      symbol = "[+]",
      highlight = "NeoTreeModified",
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
      highlight = "NeoTreeFileName",
    },
    git_status = {
      symbols = {
        -- Change type
        added = "",
        modified = "",
        deleted = "✖",
        renamed = "",
        -- Status type
        untracked = "",
        ignored = "",
        unstaged = "",
        staged = "",
        conflict = "",
      },
    },
  },
  window = {
    position = "left",
    width = 30,
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      ["<space>"] = {
        "toggle_node",
        nowait = false,
      },
      ["<2-LeftMouse>"] = "open",
      ["<cr>"] = "open",
      ["<esc>"] = "revert_preview",
      ["P"] = { "toggle_preview", config = { use_float = true } },
      ["l"] = "focus_preview",
      ["S"] = "open_split",
      ["s"] = "open_vsplit",
      ["t"] = "open_tabnew",
      ["C"] = "close_node",
      ["z"] = "close_all_nodes",
      ["a"] = {
        "add",
        config = {
          show_path = "none", -- "none", "relative", "absolute"
        },
      },
      ["A"] = "add_directory",
      ["d"] = "delete",
      ["r"] = "rename",
      ["y"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["c"] = "copy",
      ["m"] = "move",
      ["q"] = "close_window",
      ["R"] = "refresh",
      ["?"] = "show_help",
      ["<"] = "prev_source",
      [">"] = "next_source",
    },
  },
  nesting_rules = {},
  filesystem = {
    filtered_items = {
      visible = false,
      hide_dotfiles = false,
      hide_gitignored = true,
      hide_hidden = false,
      hide_by_name = {
        --"node_modules"
      },
      hide_by_pattern = {
        --"*.meta",
        --"*/src/*/tsconfig.json",
      },
      always_show = {
        --".gitignored",
      },
      never_show = {
        --".DS_Store",
        --"thumbs.db"
      },
      never_show_by_pattern = {
        --".null-ls_*",
      },
    },
    follow_current_file = true,
    group_empty_dirs = false,
    hijack_netrw_behavior = "open_default",
    use_libuv_file_watcher = false,
    window = {
      mappings = {
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
        ["H"] = "toggle_hidden",
        ["/"] = "fuzzy_finder",
        ["D"] = "fuzzy_finder_directory",
        ["#"] = "fuzzy_sorter",
        -- ["D"] = "fuzzy_sorter_directory",
        ["f"] = "filter_on_submit",
        ["<c-x>"] = "clear_filter",
        ["[g"] = "prev_git_modified",
        ["]g"] = "next_git_modified",
      },
    },
  },
  buffers = {
    follow_current_file = true,
    group_empty_dirs = true,
    show_unloaded = true,
    window = {
      mappings = {
        ["bd"] = "buffer_delete",
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
      },
    },
  },
  git_status = {
    window = {
      position = "float",
      mappings = {
        ["A"] = "git_add_all",
        ["gu"] = "git_unstage_file",
        ["ga"] = "git_add_file",
        ["gr"] = "git_revert_file",
        ["gc"] = "git_commit",
        ["gp"] = "git_push",
        ["gg"] = "git_commit_and_push",
      },
    },
  },
})

vim.cmd([[nnoremap \ :Neotree toggle<cr>]])
