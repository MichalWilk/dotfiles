return {
    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup()
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })
        end,
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            local telescope = require("telescope")
            telescope.setup({
                defaults = {
                    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                },
            })
            telescope.load_extension("fzf")

            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files)
            vim.keymap.set("n", "<leader>fg", builtin.live_grep)
            vim.keymap.set("n", "<leader>fb", builtin.buffers)
            vim.keymap.set("n", "<leader>fh", builtin.help_tags)
        end,
    },

    -- File tree
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        keys = {
            { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle file tree" },
        },
        opts = {
            filesystem = {
                follow_current_file = { enabled = true },
                filtered_items = { visible = true },
            },
        },
    },

    -- Git signs
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            on_attach = function(bufnr)
                local gs = require("gitsigns")
                local map = function(mode, l, r)
                    vim.keymap.set(mode, l, r, { buffer = bufnr })
                end

                map("n", "]h", gs.next_hunk)
                map("n", "[h", gs.prev_hunk)
                map("n", "<leader>hs", gs.stage_hunk)
                map("n", "<leader>hr", gs.reset_hunk)
                map("n", "<leader>hb", gs.toggle_current_line_blame)
            end,
        },
    },
}
