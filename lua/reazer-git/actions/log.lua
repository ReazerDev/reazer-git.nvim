local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local previewers = require "telescope.previewers"
local conf = require("telescope.config").values

local M = {}

M.run = function(opts)
  opts = opts or {}

  local handle = io.popen("git log")
  local result = handle:read("*a")
  handle:close()

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(result, "\n"))
  vim.api.nvim_buf_set_option(buf, 'filetype', 'git')
  vim.api.nvim_set_current_buf(buf)
end

return M
