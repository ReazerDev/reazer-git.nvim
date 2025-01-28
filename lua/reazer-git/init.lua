local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

local M = {}

-- our picker function: colors
function M.status()
  local opts = {}

  pickers.new(opts, {
    prompt_title = "git status",
    finder = finders.new_table {
      results = { "red", "green", "blue", "test.lua" }
    },
    sorter = conf.generic_sorter(opts),
  }):find()
end

return M
