-- -- packer.nvim
-- local packer_ok, _ = pcall(require, "packer")
-- if packer_ok then
--     require("custom.packer-plugins")
-- end

-- Set variables
require("custom.set")

-- lazy.nvim
require("custom.plugins")

-- Set UI vars
require("custom.ui")
