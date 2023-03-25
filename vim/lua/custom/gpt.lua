-- ChatGPT
require("chatgpt").setup({
  welcome_message = "",
  question_sign = "Q",
  answer_sign = "A",
  max_line_length = 120,
  chat_input = {
    prompt = " ",
  },
  openai_params = {
    model = "gpt-4",
    frequency_penalty = 0,
    presence_penalty = 0,
    max_tokens = 800,
    temperature = 0,
    top_p = 1,
    n = 1,
  },
  openai_edit_params = {
    model = "code-davinci-edit-001",
    temperature = 0,
    top_p = 1,
    n = 1,
  },
  keymaps = {
    close = { "<C-c>", "<Esc>" },
    submit = "<C-Enter>",
    yank_last = "<C-y>",
    yank_last_code = "<C-k>",
    scroll_up = "<C-u>",
    scroll_down = "<C-d>",
    toggle_settings = "<C-o>",
    new_session = "<C-n>",
    cycle_windows = "<Tab>",
    -- In the Sessions pane:
    select_session = "<Space>",
    rename_session = "r",
    delete_session = "d",
  },
})

vim.keymap.set("n", ",c", ":ChatGPT<CR>")
vim.keymap.set({ "n", "v" }, ",e", ":<C-U>:ChatGPTEditWithInstructions<CR>")

-- Copilot
vim.keymap.set("i", "<C-j>", "<Plug>(copilot-next)", { silent = true })
vim.keymap.set("i", "<C-k>", "<Plug>(copilot-previous)", { silent = true })
vim.keymap.set("i", "<C-\\>", "<Plug>(copilot-dismiss)", { silent = true })
