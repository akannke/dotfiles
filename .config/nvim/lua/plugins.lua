vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client
  use "williamboman/nvim-lsp-installer"

  -- 補完関係
--   use "hrsh7th/nvim-cmp"
--   use "hrsh7th/cmp-nvim-lsp"
--   use "hrsh7th/cmp-vsnip"
--   use "hrsh7th/cmp-buffer"
--   use "hrsh7th/vim-vsnip"
-- 
--   -- null-ls
--   use { "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim" } }
-- 
--   if packer_bootstrap then
--     require("packer").sync()
--   end
end)

