return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        keys = {
            {
                "<leader>cf",
                function() require("conform").format({ async = true }) end,
                desc = "Format buffer",
            },
        },
        opts = {
            formatters_by_ft = {
                rust = { "rustfmt" },
                typescript = { "prettierd" },
                typescriptreact = { "prettierd" },
                javascript = { "prettierd" },
                javascriptreact = { "prettierd" },
                kotlin = { "ktlint" },
                cs = { "csharpier" },
                lua = { "stylua" },
            },
            format_on_save = {
                timeout_ms = 3000,
                lsp_format = "fallback",
            },
        },
    },
}
