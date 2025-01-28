local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local telescope_config = require("telescope._extensions.reazer_git.config")

local M = {}

function M.picker()
  local opts = telescope_config.opts or {}

  pickers.new(
    opts,
    {
      prompt_title = "Reazer git",
      finder = finders.new_table({
        results = {
          {
            "Status",
            {
              command = "status",
              args = opts,
            }
          },
          {
            "Rebase",
            {
              command = "rebase",
              args = opts,
            }
          },
          {
            "Log",
            {
              command = "log",
              args = opts,
            }
          },
        },
        entry_maker = function(entry)
          return {
            value = entry[2],
            display = entry[1],
            ordinal = entry[1],
          }
        end,
      }),
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local entry = action_state.get_selected_entry()
          local value = entry.value
          require("reazer-git")[value.command](value.args)
        end)

        return true
      end
    }
  ):find()
end

return M
