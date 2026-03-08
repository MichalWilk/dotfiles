return {
    -- Gruvbox colorscheme
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            require("gruvbox").setup({
                contrast = "hard",
                palette_overrides = {
                    dark0_hard = "#1a1918",
                    dark0 = "#242220",
                    dark1 = "#2e2c2a",
                    dark2 = "#3e3c3a",
                    dark3 = "#524f4d",
                    dark4 = "#6a6765",
                    light0 = "#e8e4dd",
                    light1 = "#e8e4dd",
                    bright_red = "#e85045",
                    bright_green = "#85b829",
                    bright_yellow = "#f0be38",
                    bright_blue = "#5296c8",
                    bright_purple = "#a87ac0",
                    bright_aqua = "#5eb8a8",
                    bright_orange = "#fe8019",
                    neutral_red = "#e85045",
                    neutral_green = "#85b829",
                    neutral_yellow = "#f0be38",
                    neutral_blue = "#5296c8",
                    neutral_purple = "#a87ac0",
                    neutral_aqua = "#5eb8a8",
                    neutral_orange = "#fe8019",
                    gray = "#9a9491",
                },
                overrides = {
                    SignColumn = { bg = "#1a1918" },
                    GruvboxRedSign = { bg = "#1a1918" },
                    GruvboxGreenSign = { bg = "#1a1918" },
                    GruvboxYellowSign = { bg = "#1a1918" },
                    GruvboxBlueSign = { bg = "#1a1918" },
                    GruvboxPurpleSign = { bg = "#1a1918" },
                    GruvboxAquaSign = { bg = "#1a1918" },
                    GruvboxOrangeSign = { bg = "#1a1918" },
                },
            })
            vim.cmd.colorscheme("gruvbox")
        end,
    },

    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = "gruvbox",
                section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = { "encoding", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
        },
    },

    -- File icons
    { "nvim-tree/nvim-web-devicons", lazy = true },
}
