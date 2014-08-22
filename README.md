Here are some of my dotfiles.

Those are meant to be used by **me**, and I know exactly what they’re doing
because I wrote them. You shouldn’t blindly use them. Instead, just read them
and understand them. You’ll, hopefully, find some interesting bits you’ll add
in your own dotfiles.


## Vim

[`vim.sh`][vimsh] is a post-install script for Vim. It installs 40+ plugins,
syntax files and omnicomplete scripts. More importantly, it’s indempotent:
running it once or ten times has the same outcome: all missing plugins are
installed the first time.

[vimsh]: https://github.com/bfontaine/Dotfiles/blob/master/vim.sh
