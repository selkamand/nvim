# Neovim Configuration

A simple neovim configuration. 

## Setup 

Just clone into `~/.config/nvim`.

```
git clone https://github.com/selkamand/nvim.git ~/.config/nvim
```

## Dependencies

Install:

- fd (find; for telescope plugin)
- rg (ripgrep; for telescope plugin)

Also recommend compiling treesitter-cli so it gets linked to your system version of glibc
```
cargo install tree-sitter-cli
```
Also see LSP section for how to install language servers

## Plugins

**Adding a package:**

All plugins are added in init.lua using the inbuilt `vim.pack.add`. `Package configs are in lua/plugins/<plugin>.lua`

Note after you remove a package from init.lua you may also need to run:
```
:lua vim.pack.del({ "<package name>" })
```

To remove it from the `nvim-pack-lock.json`. On newer versions of nvim 
you might eventually be able to just run `:packdel ++all` to cleanup all unused plugins.


### Treesitter 
Treesitter will be installed, but to actually get parsers for the languages you care about you'll need to run something like:

```
:TSInstall python lua javascript typescript go rust c cpp bash markdown vim yaml toml
```

We could autoinstall these as part of the config but for now we'll leave to user.

### LuaSnp 

While modern neovim has an inbuilt snippet engine we still use the LuaSnip plugin as its more full featured and I don't feel like rewriting my existing snippet library.

## LSPs

`init.lua` LSP section has instructions for adding new LSP configs to neovim.

We do not use mason as I refer manually installing the relevant language servers for complete control. 
Below are some simple instructions for installing common language servers

For [lua_ls](https://luals.github.io/#neovim-install):

mac:
```
brew install lua-language-server
```
arch:
```
sudo pacman -S lua-language-server
```

For [r_language_server](https://github.com/REditorSupport/languageserver):

```
install.packages("languageserver")
```


For [nextflow_ls](https://github.com/nextflow-io/language-server/releases):

Install the latest release and add a little bash helper script called 'nextflow-language-server' that starts up the server. 

Heres a helper script that downloads everything to `~/.local/bin` (please change to somewhere on your PATH)

```{bash}
version="v26.04.1"
directory="${HOME}/.local/bin"

# Download the nextflow lsp java file
wget -P ${directory} "https://github.com/nextflow-io/language-server/releases/download/${version}/language-server-all.jar"

# Write a small bash helper that starts the language server
cat > "${directory}/nextflow-language-server" <<EOF
#!/bin/bash
java -jar "${directory}/language-server-all.jar"
EOF

chmod +x ${directory}/nextflow-language-server
```

For Rust:

we use the rustaceanvim plugin which handles the lsp configuration for us. So you just need the standard rustanalyzer that comes with your rust installation.

## Other info

To understand the configuration start at [init.lua](./init.lua) and follow the requires.

A description of the neovim lua api is found [here](https://neovim.io/doc/user/lua-guide/).

Note this neovim config uses the inbuilt plugin manager provided by neovim v0.12+ so if you have an older version this config will not work for you.
