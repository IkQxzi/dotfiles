require "core"

-- Load the init.vim file to ensure Vimscript settings are applied
--vim.cmd('source ' .. vim.fn.stdpath('config') .. '/init.vim')

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"

vim.o.relativenumber = true

vim.g.python3_host_prog = '/home/ikqxzi/.venv/nvim/bin/python'
vim.g.loaded_python3_provider = nil

-- Rebind h to enter Insert mode (instead of moving left)
--vim.api.nvim_set_keymap('n', 'h', 'i', { noremap = true })  -- h -> insert mode

-- Function to synchronize Neovim transparency with terminal
function sync_transparency_with_terminal()
    -- Get terminal's transparency state from the stored file
    local handle = io.popen("cat ~/.transparency_state")
    local terminal_state = handle:read("*all"):gsub("%s+", "")  -- Trim whitespace
    handle:close()

    -- Set Neovim transparency based on the terminal's state
    if terminal_state == "transparent" then
        -- Make Neovim's background transparent
        vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
        vim.cmd("hi NormalNC guibg=NONE ctermbg=NONE")
    else
        -- Set a default opaque background color for Neovim
        vim.cmd("hi Normal guibg=#192330")  -- Replace with your default background color
        vim.cmd("hi NormalNC guibg=#192330")
    end
end

-- Call the function to set Neovim's transparency on startup
sync_transparency_with_terminal()

-- Function to toggle transparency for Neovim and terminal
function toggle_transparency()
    -- Call the Zsh function to toggle terminal transparency and get the state
    local handle = io.popen("zsh -c 'source ~/.zshrc && toggle_transparency'")
    local result = handle:read("*all"):gsub("%s+", "") -- Trim whitespace
    handle:close()

    -- Set Neovim transparency based on the returned state
    if result == "transparent" then
        vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
        vim.cmd("hi NormalNC guibg=NONE ctermbg=NONE")
    else
        vim.cmd("hi Normal guibg=#192330") -- Replace with your default color
        vim.cmd("hi NormalNC guibg=#192330")
    end
end

-- Map the toggle function to a keybinding
vim.api.nvim_set_keymap("n", "<Esc>t", ":lua toggle_transparency()<CR>", { noremap = true, silent = true })

-- Slightly faster maybe (maybe)
vim.api.nvim_command('command! Q1 qa!')

-- Swap semicolon & colon in normal, command, and insert modes
vim.api.nvim_set_keymap('n', ';', ':', { noremap = true })
vim.api.nvim_set_keymap('n', ':', ';', { noremap = true })
vim.api.nvim_set_keymap("c", ";", ":", { noremap = true, silent = true })
vim.api.nvim_set_keymap("c", ":", ";", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", ";", ":", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", ":", ";", { noremap = true, silent = true })

-- Create an autocmd group to manage your settings
vim.api.nvim_create_augroup("CSharpIndent", { clear = true })

-- Set indent to 4 spaces for .cs and .csx files
vim.api.nvim_create_autocmd("FileType", {
  group = "CSharpIndent",
  pattern = { "cs", "csx" },
  callback = function()
    vim.bo.tabstop = 4      -- Number of spaces that a <Tab> in the file counts for
    vim.bo.softtabstop = 4  -- Number of spaces inserted when <Tab> is pressed
    vim.bo.shiftwidth = 4   -- Number of spaces for autoindent
    vim.bo.expandtab = true -- Use spaces instead of tabs
  end,
})

-- Keybinding to run a Python file with Esc + r
vim.api.nvim_set_keymap('n', '<Esc>r', ':w | :!~/.venv/nvim/bin/python -u %<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Esc>w', ':w <CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Esc>x', ':q <CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Esc>q', ':wq <CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Esc>a', ':qa! <CR>', { noremap = true, silent = true })

-- UndoTree toggle esc m
vim.api.nvim_set_keymap('n', '<Esc>u', ':UndotreeToggle<CR>', { noremap = true, silent = true })

-- Keybinding to run a C# file with Esc + c
vim.api.nvim_set_keymap('n', '<Esc>c', ':w | :!dotnet run', { noremap = true, silent = true })

-- So inserting is auto-indented
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Ensure the Nightfox theme is loaded
-- vim.cmd("colorscheme nightfox")

-- Terminal ezpz using esc n (new terminal)
vim.keymap.set("n", "<Esc>n", function()
vim.cmd("vsp | term")   -- Open vertical terminal
vim.cmd("startinsert")  -- Automatically enter insert mode
end, { desc = "Open vertical terminal" })

-- Open vertical split with <Esc> + v
vim.keymap.set('n', '<Esc>v', ':vsp<CR>', { desc = 'Open vertical split' })

-- Set to <Esc> + h because h is left anyways
vim.keymap.set("t", "<Esc>h", function()
  -- Exit terminal mode
  vim.api.nvim_input("<C-\\><C-n>")
  -- Move to the left window (optional, can be removed if not needed)
-- Navigating windows enters insert mode automatically
  vim.cmd("wincmd h")
end, { desc = "Exit terminal mode and move left" })

vim.keymap.set("n", "<Esc>h", function()
  vim.cmd("wincmd h")
end, { desc = "Move to window h" })

vim.keymap.set("n", "<Esc>j", function()
  vim.cmd("wincmd j")
  vim.api.nvim_input("i")
end, { desc = "Move to window j and enter insert mode" })

vim.keymap.set("n", "<Esc>k", function()
  vim.cmd("wincmd k")
  vim.api.nvim_input("i")
end, { desc = "Move to window k and enter insert mode" })

vim.keymap.set("n", "<Esc>l", function()
  vim.cmd("wincmd l")
  vim.api.nvim_input("i")
end, { desc = "Move to window l and enter insert mode" })


-- Automatically disable line numbers when a terminal is opened
vim.cmd([[
  autocmd TermOpen * setlocal nonumber norelativenumber
]])

