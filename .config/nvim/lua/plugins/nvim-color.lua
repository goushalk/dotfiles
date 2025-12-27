return {
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        "*", -- highlight all files (optional: narrow to specific filetypes)
        css = { rgb_fn = true },
        html = { names = false },
      })
    end,
  },
}
