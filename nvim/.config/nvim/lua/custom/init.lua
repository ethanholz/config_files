-- packer.nvim
local packer_ok, _ = pcall(require, "packer")
if packer_ok then
    require("custom.packer-plugins")
end

-- lazy.nvim
local lazy_ok, _ = pcall(require, "lazy")
if lazy_ok and not packer_ok then
    require("custom.plugins")
end

-- Set variables
require("custom.set")
