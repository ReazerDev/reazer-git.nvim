local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")
local conf = require("telescope.config").values

local M = {}

M.run = function(opts)
  opts = opts or {}

  local handle = io.popen("git status -s | awk '{print $2}'")
  local result = handle:read("*a")
  handle:close()

  pickers.new(opts, {
    prompt_title = "git status",
    finder = finders.new_table {
      results = vim.split(result, "\n")
    },
    previewer = previewers.vim_buffer_cat.new(opts),
    sorter = conf.generic_sorter(opts),
  }):find()
end

return M
