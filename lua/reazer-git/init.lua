local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

local M = {}

function M.status(options)
  local status_action = require('reazer-git.actions.status')

  status_action.run(options)
end

function M.rebase(options)
  local rebase_action = require('reazer-git.actions.rebase')

  rebase_action.run(options)
end

function M.log(options)
  local log_action = require('reazer-git.actions.log')

  log_action.run(options)
end

return M
