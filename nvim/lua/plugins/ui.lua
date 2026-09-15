return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      dimInactive = true,
      terminalColors = true,
      theme = "wave",
      overrides = function(colors)
        return {
          CursorLine = { bg = colors.theme.ui.bg_p1 },
          CursorLineNr = { fg = colors.palette.carpYellow, bold = true },
          FloatBorder = { fg = colors.palette.waveBlue1, bg = colors.theme.ui.float.bg },
          NormalFloat = { bg = colors.theme.ui.float.bg },
          WinSeparator = { fg = colors.theme.ui.bg_p2 },
          Visual = { bg = colors.theme.ui.bg_p2 },
        }
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
    },
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        always_show_bufferline = true,
        diagnostics = "nvim_lsp",
        indicator = { style = "underline" },
        separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        theme = "auto",
      })
    end,
  },
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
╭──────────────────────────────────────────╮
│   _ __   ___  ___   _ __ ___   __   __   │
│  | '_ \ / _ \/ _ \ | '_ ` _ \  \ \ / /   │
│  | | | |  __/ (_) || | | | | |  \ V /    │
│  |_| |_|\___|\___/ |_| |_| |_|   \_/     │
╰──────────────────────────────────────────╯]],
        },
      },
    },
  },
}
