local has_telescope, telescope = pcall(require, "telescope")

if not has_telescope then
    error("reazer-git.nvim requires nvim-telescope/telescope.nvim")
end

return telescope.register_extension {
  exports = {
    reazer_git = require("reazer-git")
  },
}
