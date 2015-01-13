;; Note: I’m an Emacs noob, I don’t know what I’m doing

;; el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)


;; ???
(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)

;; real meta key on OSX
;; http://stackoverflow.com/a/3378391/735926
(setq mac-option-modifier nil
      mac-command-modifier 'meta
      x-select-enable-clipboard t)

;; line numbers
(global-linum-mode t)
