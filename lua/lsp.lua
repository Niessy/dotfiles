local nvim_lsp = require'nvim_lsp'
-- local nvim_diagnostic = require'diagnostic'
local nvim_completion = require'completion'

local on_attach_nvim = function()
  -- nvim_diagnostic.on_attach()
  nvim_completion.on_attach()
end

local servers = {
  bashls = {
    on_attach=on_attach_nvim,
  },
  html = {},
  jsonls = {
    on_attach=on_attach_nvim,
    cmd = { 'json-languageserver', '--stdio' }
  },
  julials = {
    on_attach=on_attach_nvim,
  },
  pyls_ms = {
    on_attach=on_attach_nvim,
    cmd = { 'mspyls' },
    -- callbacks = lsp_status.extensions.pyls_ms.setup(),
    settings = {
      python = {
        jediEnabled = false,
        analysis = {
          cachingLevel = 'Library',
        },
        formatting = {
          provider = 'blac'
        },
        -- venvFolders = {
        --   "envs",
        --   ".pyenv",
        --   ".direnv",
        --   ".cache/pypoetry/virtualenvs"
        -- },
        workspaceSymbols = { enabled = true }
      }
    },
    root_dir = function(fname)
      return nvim_lsp.util.root_pattern(
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        'mypy.ini',
        '.pylintrc',
        '.flake8rc',
        '.gitignore'
      )(fname) or
      nvim_lsp.util.find_git_ancestor(fname) or
      vim.loop.os_homedir()
    end;
  },
  rust_analyzer = {
    on_attach=on_attach_nvim,
  },
  sumneko_lua = {
    on_attach=on_attach_nvim,
    cmd = { 'lua-language-server' },
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' }
        },
        completion = {
          keywordSnippet = 'Disable'
        },
        runtime = {
          version = 'LuaJIT'
        }
      }
    }
  },
  vimls = {
    on_attach=on_attach_nvim,
  },
}

for server, config in pairs(servers) do
  -- config.capabilities = vim.tbl_extend('keep', config.capabilities or {}, lsp_status.capabilities)
  nvim_lsp[server].setup(config)
end
