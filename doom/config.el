;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Solarized Dark Theme
(setq doom-theme 'doom-solarized-light)

;; GRUVBOX THEME:
;; (setq doom-theme 'doom-gruvbox)
;;(setq doom-font "JetBrainsMono Nerd Font:pixelsize=15")
(setq doom-font "MesloLGL Nerd Font:pixelsize = 15")


(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
