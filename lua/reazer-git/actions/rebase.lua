local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local previewers = require "telescope.previewers"
local conf = require("telescope.config").values

local M = {}

M.run = function(opts)
  opts = opts or {}

  local rebase_in_progress = os.execute('git rebase --show-current-patch')
  if rebase_in_progress ~= 0 then
    return
  end

  local handle = io.popen("git status -s | grep '^[ ?]' | awk '{print $2}'")
  local result = handle:read("*a")
  handle:close()

  pickers.new(opts, {
    prompt_title = "git rebase",
    finder = finders.new_table {
      results = vim.split(result, "\n")
    },
    previewer = previewers.vim_buffer_cat.new(opts),
    sorter = conf.generic_sorter(opts),
  }):find()
end

return M
