return {
    -- Mason — LSP installer
    {
        "williamboman/mason.nvim",
        opts = {},
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
            ensure_installed = {
                "ts_ls",
                "kotlin_language_server",
                "omnisharp",
                "lua_ls",
            },
        },
    },

    -- LSP config (provides server definitions for vim.lsp.config)
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "saghen/blink.cmp",
        },
        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            -- Default capabilities for all servers
            vim.lsp.config("*", {
                capabilities = capabilities,
            })

            -- Per-server configuration
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                },
            })

            vim.lsp.config("omnisharp", {
                settings = {
                    FormattingOptions = { EnableEditorConfigSupport = true },
                    RoslynExtensionsOptions = { enableImportCompletion = true },
                },
            })

            vim.lsp.config("rust_analyzer", {
                settings = {
                    ["rust-analyzer"] = {
                        check = { command = "clippy" },
                    },
                },
            })

            -- Enable all servers
            vim.lsp.enable({
                "ts_ls",
                "kotlin_language_server",
                "omnisharp",
                "lua_ls",
                "rust_analyzer",
            })

            -- LSP keymaps (on attach)
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(ev)
                    local map = function(mode, l, r)
                        vim.keymap.set(mode, l, r, { buffer = ev.buf })
                    end

                    map("n", "gd", vim.lsp.buf.definition)
                    map("n", "gr", vim.lsp.buf.references)
                    map("n", "K", vim.lsp.buf.hover)
                    map("n", "<leader>ca", vim.lsp.buf.code_action)
                    map("n", "<leader>rn", vim.lsp.buf.rename)
                end,
            })
        end,
    },

    -- Completion
    {
        "saghen/blink.cmp",
        version = "1.*",
        opts = {
            keymap = { preset = "default" },
            appearance = { nerd_font_variant = "mono" },
            completion = {
                documentation = { auto_show = true },
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
        },
    },
}
