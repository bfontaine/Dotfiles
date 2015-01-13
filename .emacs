;; Evil (Vim mode for Emacs)
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)

;; real meta key on OSX
;; http://stackoverflow.com/a/3378391/735926
(setq mac-option-modifier nil
      mac-command-modifier 'meta
      x-select-enable-clipboard t)

;; line numbers
(global-linum-mode t)
