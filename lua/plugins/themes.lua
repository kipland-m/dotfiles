return {
  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup({
        style = "dark",
        transparent = true,
      })
      require("onedark").load()
    end,
  },
}