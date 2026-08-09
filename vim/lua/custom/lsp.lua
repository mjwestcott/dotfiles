-- LSP settings.
local on_attach = function(client, bufnr)
  -- Skip attaching keymaps for Copilot
  if client.name == "GitHub Copilot" or client.name == "copilot" then
    return
  end
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  -- Go to definition and center the screen
  nmap("gd", function()
    vim.lsp.buf.definition()
    -- Center after a short delay to allow jump to complete
    vim.defer_fn(function()
      vim.cmd("normal! zz")
    end, 50)
  end, "[G]oto [D]efinition")
  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
  nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<leader>k", vim.lsp.buf.signature_help, "Signature Documentation")

  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })
end

-- Per-server settings. Anything not listed here takes nvim-lspconfig's defaults.
local servers = {
  pyright = {},
  ts_ls = {},
  bashls = {},
  yamlls = {},
  jsonls = {},
  lua_ls = {
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  },
}

-- Setup autopairs
require("nvim-autopairs").setup()

-- Setup autotag
require("nvim-ts-autotag").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Setup mason so it can manage external tooling
require("mason").setup()

-- mason-lspconfig 2.0 removed setup_handlers and the handlers table. Servers are
-- now configured through vim.lsp.config and turned on by automatic_enable, which
-- is the default. Extending "*" applies the cmp capabilities to every server
-- rather than repeating them per entry.
vim.lsp.config("*", { capabilities = capabilities })

for server, config in pairs(servers) do
  if next(config) ~= nil then
    vim.lsp.config(server, config)
  end
end

require("mason-lspconfig").setup({
  ensure_installed = vim.tbl_keys(servers),
})

-- Autocommand to attach keymaps when LSP attaches to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      on_attach(client, args.buf)
    end
  end,
})
