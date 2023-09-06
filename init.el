;; Code:

(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; keep installed packages in .emacs.d

(setq package-user-dir (expand-file-name  "elpa" user-emacs-directory))
(package-initialize)

;; update the package metadata if the local cache is missing

(unless package-archive-contents
  (package-refresh-contents))

(setq user-full-name "Dajana Herichova"
      user-mail-adress "dajana.herichova@gmail.com")

;; Always load newest byte code

(setq load-prefer-newer t)

;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)

(setq gc-cons-threshold 50000000)

;; warn when opening files bigger than 100MB

(setq large-file-warning-threshold 100000000)

(defconst dajanah-savefile-dir (expand-file-name "savefile" user-emacs-directory))

;; create the savefile dir if it doesn't exist

(unless (file-exists-p dajanah-savefile-dir)
  (make-directory dajanah-savefile-dir))

(scroll-bar-mode -1) ;;Disable visible scrollbar
(tooltip-mode -1) ;;Disable tooltips
(menu-bar-mode -1) ;;Disable the menu bar

;; disable toolbar mode

(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;; turning of the blinking cursor

(blink-cursor-mode -1)

;; disable bell ring

(setq ring-bell-function 'ignore)

;; disable startup screen

(setq inhibit-startup-screen t)

;; nice scrolling

(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

(when (fboundp 'pixel-scroll-precision-mode)
  (pixel-scroll-precision-mode t))

;; enable y/n answers

(fset 'yes-or-no-p 'y-or-n-p)

;; Newline at end of file

(setq require-final-newline t)

;; Wrap lines at 80 characters

(setq-default fill-column 80)

;; delete the selection with a keypress

(delete-selection-mode 1)

;; store all backup and autosave files in the tmp dir

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; revert buffers automatically when underlying files are changed externally

(global-auto-revert-mode t)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; align code in a pretty way

(global-set-key (kbd "C-x \\")		  #'align-regexp)
(define-key 'help-command (kbd "C-i")  #'info-display-manual)

;; smart tab behavior - indent or complete

(setq tab-always-indent 'complete)

;; enable some commands that are disabled by default
(put 'erase-buffer 'disabled nil)


(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; built-in packages

(use-package paren
  :config
  (show-paren-mode +1))

(use-package elec-pair
  :config
  (electric-pair-mode +1))

;; saveplace remembers your location in a file when saving files

(use-package saveplace
  :config
  (setq save-place-file (expand-file-name "saveplace" dajanah-savefile-dir))
  (setq-default save-place t))

(use-package savehist
  :config
  (setq savehist-additional-variables
        '(search-ring regexp-search-ring)
        savehist-autosave-interval 60
        savehist-file (expand-file-name "savehist" dajanah-savefile-dir))
  (savehist-mode +1))


;; third-party packages

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

(use-package git-timemachine
  :ensure t
  :bind (("s-g" . git-timemachine)))

(use-package move-text
  :ensure t
  :bind
  (([(meta shift up)] . move-text-up)
   ([(meta shift down)] . move-text-down)))

;; graphql-mode
(use-package graphql-mode
  :ensure t
  :mode
  ("\\.graphqls$" . graphql-mode))

;; clojure

(use-package clojure-mode
  :ensure t
  :config
  (define-clojure-indent
    (returning 1)
    (testing-dynamic 1)
    (testing-print 1))

  (add-hook 'clojure-mode-hook                          #'paredit-mode)
  (add-hook 'clojure-mode-hook                          #'subword-mode))

(use-package inf-clojure
  :ensure t
  :config
  (add-hook 'inf-clojure-mode-hook                      #'paredit-mode))

;; cider

(use-package cider
  :ensure t
  :config
  (setq nrepl-log-messages t)
  (add-hook 'cider-repl-mode-hook                       #'paredit-mode))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("28dcd76b4127bd2fa1c4cfdc42f9e7b8b74011b39a367773bea2eaf998012bd1" "1c5a027900ef0832c259731a20b525e12da5d91d9c03d1c271b8341127b546b5" "20c1e2cedbbee44d99d876243af769880c5ca44f0ed9372d71628d98afcae6b1" "c7e436563c0331ea16de47ca89daae6fe8bb40dda1020b977cd1aacfec25a9ce" "9a9bc26f9cb83ff5a5fe1e45ef108f784d442dda2469dc848cf79f009bfdb2dd" "dd700ece1c74272076889bc90f7def7be767a118a02061fdf1f02b2ae5725c45" "779545f58318d8ee83d07e5c53f101bc87ccea301451d291d5a911db723b13b5" "1120c7870281720bb3c034b6b4edfea1447e9b9cda44c5039207a2d4d3afffcc" "c48551a5fb7b9fc019bf3f61ebf14cf7c9cdca79bcb2a4219195371c02268f11" "9b59e147dbbde5e638ea1cde5ec0a358d5f269d27bd2b893a0947c4a867e14c1" defaualt))
 '(package-selected-packages
   '(typescript-mode tide highlight-parentheses auto-complete ## sublime-themes zop-to-char yaml-mode which-key utop use-package super-save selectrum-prescient rust-mode rainbow-mode rainbow-delimiters paredit move-text merlin-eldoc markdown-mode magit inf-ruby inf-clojure imenu-anywhere hl-todo haskell-mode git-timemachine flycheck-ocaml flycheck-joker flycheck-eldev expand-region exec-path-from-shell erlang elixir-mode elisp-slime-nav eglot easy-kill dune diminish diff-hl crux consult company cider cask-mode adoc-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil))))
 '(font-lock-comment-face ((t (:foreground "dimgray"))))
 '(font-lock-string-face ((t (:foreground "palevioletred1")))))

(unless (package-installed-p 'cider)
  (package-install 'cider))


;; cleanup

(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))


(defun cleanup-buffer ()
  (interactive)
  (indent-buffer)
  (untabify-buffer))


(global-set-key (kbd "C-c n") 'cleanup-buffer)

;; autocomplete


(unless (package-installed-p 'auto-complete)
  (package-install 'auto-complete))

(require 'auto-complete-config)
(ac-config-default)

;; ido mode
(ido-mode t)

;; paredit

(use-package paredit
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook                       #'paredit-mode)
  (add-hook 'lisp-interaction-mode-hook                 #'paredit-mode)
  (add-hook 'ielm-mode-hook                             #'paredit-mode)
  (add-hook 'lisp-mode-hook                             #'paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook      #'paredit-mode)
  (diminish 'paredit-mode "()"))


;; highlight-parentheses

(unless (package-installed-p 'highlight-parentheses)
  (package-install 'highlight-parentheses))

(require 'highlight-parentheses)
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))

(add-hook 'emacs-lisp-mode-hook 'highlight-parentheses-mode)
(add-hook 'scheme-mode-hook 'highlight-parentheses-mode)
(add-hook 'clojure-mode-hook 'highlight-parentheses-mode)
(add-hook 'cider-repl-mode-hook 'highlight-parentheses-mode)

(use-package highlight-parentheses
  :ensure t
  :pin melpa
  :config 
  (setq hl-paren-colors '("violetred3"))
  (add-hook 'emacs-lisp-mode-hook 'highlight-parentheses-mode)
  (add-hook 'scheme-mode-hook 'highlight-parentheses-mode)
  (add-hook 'clojure-mode-hook 'highlight-parentheses-mode)
  (add-hook 'cider-repl-mode-hook 'highlight-parentheses-mode))

;; bind-comment-region to C-c C-k

(global-set-key (kbd "C-c C-k") 'comment-region)

;; bind uncomment-region to C-c C-u
(global-set-key (kbd "C-c C-u") 'uncomment-region)

(defun smarter-move-beginning-of-line (arg)
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(global-set-key [remap move-beginning-of-line]
		'smarter-move-beginning-of-line)

;; custom theme 
(load-theme 'dajanah t)

(setq enable-local-variables :safe) 



(put 'upcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)

(require 'org)

;; Enable terraform-mode for .tf files
(require 'terraform-mode)
(add-to-list 'auto-mode-alist '("\\.tf\\'" . terraform-mode))

;; Enable automatic indentation in terraform-mode
(add-hook 'terraform-mode-hook #'terraform-format-on-save-mode)
