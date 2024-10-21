local function insert_template(template_path)
  local file = io.open(template_path, "r")
  if file then
    local content = file:read("*a")
    file:close()
    -- Insert the content into the current buffer at the cursor position
    vim.api.nvim_put(vim.split(content, '\n'), 'l', true, true)
  else
    print("Template not found: " .. template_path)
  end
end

--Obsidian
vim.keymap.set("n", "<leader>oo", ':!cd ~/Projects/obsidianVault/New<CR>')

vim.keymap.set("n", "<leader>on", ":ObsidianTemplate note<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<CR>")
-- Must have cursor on title - removes date
vim.keymap.set("n", "<leader>of", ":s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<cr>")



-- vim.keymap.set("n", "<leader>os", ":Telescope find_files search_dirs={\"/Users/alex/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/ZazenCodes/notes\"}<cr>")
-- vim.keymap.set("n", "<leader>oz", ":Telescope live_grep search_dirs={\"/Users/alex/library/Mobile\\ Documents/iCloud~md~obsidian/Documents/ZazenCodes/notes\"}<cr>")


-- move file in current buffer to zettelkasten folder
-- vim.keymap.set("n", "<leader>ok", ":silent! !mv '%:p' $HOME/Projects/obsidianVault/New/zettelkasten/<cr>:bd<cr>")
-- vim.keymap.set("n", "<leader>odd", ":silent! !rm '%:p'<cr>:bd<cr>")


vim.keymap.set("n", "<leader>otl", function()
  insert_template('/home/maxi/Projects/obsidianVault/New/templates/Vorlesung.md')
end, { desc = "Insert Lecture Template" })
vim.keymap.set("n", "<leader>ote", function()
  insert_template('/home/maxi/Projects/obsidianVault/New/templates/Übung.md')
end, { desc = "Insert Exercise Template" })
