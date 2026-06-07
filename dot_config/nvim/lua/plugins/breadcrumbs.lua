-- VSCode-style breadcrumbs at the top of each editor window
return {
  {
    "Bekaboo/dropbar.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    opts = {},
    keys = {
      { "<leader>;", function() require("dropbar.api").pick() end, desc = "Breadcrumbs picker" },
    },
  },
}
