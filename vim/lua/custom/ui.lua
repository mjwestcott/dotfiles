-- Colours
vim.o.background = "dark"
vim.api.nvim_command([[colorscheme zenburn]])

-- Zenburn color palette
local colors = {
  fg = "#dcdccc",
  bg = "#353535",
  green = "#7f9f7f",
  red = "#e89393",
  yellow = "#e0cf9f",
  cyan = "#7cb8bb",
  grey = "#5d6262",
  dark_green = "#284f28",
  dark_red = "#4f2828",
  dark_yellow = "#4f4f28",
}

-- Apply all custom highlight groups
local highlights = {
  -- General
  Boolean = { link = "Number" },
  StatusLine = { fg = "#5f7f5f", bg = colors.bg },
  StatusLineNC = { fg = colors.grey, bg = colors.bg },
  LineNr = { fg = colors.grey, bg = colors.bg },
  CopilotSuggestion = { fg = colors.green },

  -- Git commit
  gitcommitSummary = { fg = colors.fg },
  gitcommitOverflow = { fg = colors.cyan },

  -- Diff (inline)
  diffAdded = { fg = colors.green },
  diffRemoved = { fg = colors.red },
  diffChanged = { fg = colors.yellow },
  diffLine = { fg = colors.fg },

  -- Diff (side-by-side)
  DiffAdd = { bg = colors.dark_green },
  DiffDelete = { fg = "#000000", bg = colors.dark_red },
  DiffChange = { bg = colors.bg },
  DiffText = { bg = colors.grey },

  -- GitSigns
  GitSignsAdd = { fg = colors.green },
  GitSignsAddNr = { fg = colors.green, bg = colors.dark_green },
  GitSignsChange = { fg = colors.yellow },
  GitSignsChangeNr = { fg = colors.yellow, bg = colors.dark_yellow },
  GitSignsDelete = { fg = colors.red },
  GitSignsDeleteNr = { fg = colors.red, bg = colors.dark_red },

  -- NeoTree
  NeoTreeSymbolicLinkTarget = { link = "Operator" },
  NeoTreeDirectoryName = { link = "Number" },
  NeoTreeDirectoryIcon = { link = "Number" },
  NeoTreeRootName = { link = "Macro" },
  NeoTreeFilenameOpened = { bold = true },
  NeoTreeDotfile = { link = "Comment" },
  NeoTreeModified = { link = "String" },
}

for name, opts in pairs(highlights) do
  vim.api.nvim_set_hl(0, name, opts)
end

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
require("ibl").setup({
  scope = { enabled = false },
  indent = { char = "┊" },
  whitespace = {
    remove_blankline_trail = true,
  },
})

-- Neo-tree
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
-- Configure diagnostic signs using vim.diagnostic.config
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
  },
})

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
    follow_current_file = {
      enabled = true,
    },
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
    follow_current_file = {
      enabled = true,
    },
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
