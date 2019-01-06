# Dotfiles

Here are some of my dotfiles.

## Vim

[`vim.sh`][vimsh] is a post-install script for Vim. It installs 40+ plugins,
syntax files and omnicomplete scripts. More importantly, it’s indempotent:
running it once or ten times has the same outcome: all missing plugins are
installed the first time.

[vimsh]: https://github.com/bfontaine/Dotfiles/blob/master/vim.sh
