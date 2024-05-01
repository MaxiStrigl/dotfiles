local function open_help_in_new_window()
  -- Check if the buffer is a help file
  if vim.bo.filetype == 'help' then
    -- Move the help buffer to a new tab to the far right
    vim.cmd('wincmd L')
    vim.cmd('vertical resize')

    -- Resize all windows to equal dimensions
    local total_windows = #vim.api.nvim_list_wins()
    local new_width = math.floor(vim.o.columns / total_windows)
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      vim.api.nvim_win_set_width(win, new_width)
    end
  end
end

-- Autocommand that runs the function when a buffer is displayed in a window
vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = '*',
  callback = open_help_in_new_window,
})

-- Function to unload the help buffer when it's no longer displayed
local function unload_help_buffer()
  if vim.bo.buftype == 'help' then
    local bufnr = vim.api.nvim_get_current_buf()
    -- Check if the buffer is no longer visible in any window
    if not vim.api.nvim_buf_is_loaded(bufnr) then
      -- Unload the buffer
      vim.cmd('bdelete! ' .. bufnr)
    end
  end
end

-- Autocommand that runs the unload function when leaving a buffer window
vim.api.nvim_create_autocmd('BufWinLeave', {
  pattern = '*.txt',
  callback = unload_help_buffer,
})
