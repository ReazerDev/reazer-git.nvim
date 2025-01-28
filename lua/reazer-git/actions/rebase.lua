local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local previewers = require "telescope.previewers"
local conf = require("telescope.config").values

local M = {}

M.run = function(opts)
  opts = opts or {}

  if not rebase_in_progress then
    return
  end

  local handle = io.popen("git status -s | grep -E '(UU)|(AA)' | awk '{print $2}'")
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

function rebase_in_progress()
  local rebase_status_handle = io.popen("git rebase --show-current-patch")
  rebase_status_handle:read("*a")

  rebase_status_handle:close()
end

return M
