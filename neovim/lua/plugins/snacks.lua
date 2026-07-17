return {
  -- Snacks picker (replaces Telescope in newer LazyVim)
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true,
          },
          explorer = {
            hidden = true,
          },
        },
      },
    },
  },
}
