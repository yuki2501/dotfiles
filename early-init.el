;; -*- lexical-binding: t; -*-

(global-display-line-numbers-mode t)
(custom-set-variables '(display-line-numbers-width-start t))
(menu-bar-mode -1)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(setq inhibit-startup-screen t)
(add-to-list 'default-frame-alist '(font . "PlemolJP-18"))

(provide 'early-init)
