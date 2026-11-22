;; -*- lexical-binding: t; -*-

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("ccf4950201b6895d5ad3713ac4b92a13142a5327b45c4a43dd36a011ec7bcc32"
     "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223"
     default))
 '(package-selected-packages
   '(ag aggressive-indent cider clojure-mode company consult corfu
        counsel-projectile delight geiser geiser-chez git-timemachine
        lispy lsp-ui magit marginalia orderless rainbow-mode rustic
        smart-mode-line solarized-theme vertico yascroll)))

(setq mac-command-modifier 'meta)

(tool-bar-mode -1)
(menu-bar-mode 1)
(show-paren-mode 1)
;; (mac-auto-operator-composition-mode)
(column-number-mode 1)
(setq inhibit-startup-message t)
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))

(use-package solarized-theme
  :ensure t
  :config
  ;; (setq solarized-use-less-bold t)
  (setq solarized-scale-org-headlines nil)
  (setq x-underline-at-descent-line t)
  (load-theme 'solarized-selenized-dark t))

;; (require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("MELPA Stable" . "https://stable.melpa.org/packages/") t)
(setq package-archive-priorities
      '(("MELPA Stable" . 10)))
(package-initialize)

(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(use-package yascroll
  :ensure t
  :config
  (global-yascroll-bar-mode 1)

  ;; Optional: Customize how quickly it fades away (in seconds)
  (setq yascroll:delay-to-hide 0.5))

(use-package vertico-directory
  :after vertico
  :ensure nil ;; It is already included with the vertico package
  ;; Bind the Counsel-like directory behaviors to the Vertico keymap
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  ;; Tidy shadowed file names (e.g. typing ~/ after a long path clears the old path)
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode))
  :custom
  (markdown-command "pandoc -f gfm -t html5")
  (markdown-fontify-code-blocks-natively t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Fira Code" :foundry "nil" :slant normal :weight normal :height 130 :width normal)))))

(setq-default indent-tabs-mode nil)

(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.saves"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups

(use-package aggressive-indent
  :ensure t
  :config
  (global-aggressive-indent-mode 0)
  (add-to-list 'aggressive-indent-excluded-modes 'scheme-interaction-mode)
  (add-to-list 'aggressive-indent-excluded-modes 'geiser-repl-mode))

(setq tramp-default-method "ssh")

(use-package smart-mode-line
  :ensure t
  :init
  (setq sml/theme 'respectful)
  :config
  (sml/setup))

(use-package delight
  :ensure t
  :config
  (delight 'visual-line-mode nil "simple"))

(use-package magit
  :ensure t
  :bind (("C-x g" . 'magit-status)
         ("C-c g" . 'magit-file-dispatch)))

(use-package git-timemachine
  :ensure t)

(use-package ace-window
  :ensure t
  :init
  (setq aw-keys '(?h ?t ?n ?s ?a ?o ?e ?u ))
  :bind
  (("M-o" . 'ace-window)
   ("C-x o" . 'ace-window)))

(use-package rainbow-mode
  :ensure t)

(use-package lispy
  :ensure t
  :hook ((emacs-lisp-mode geiser-mode clojure-mode) . lispy-mode)
  :config
  (defun conditionally-enable-lispy ()
    (when (eq this-command 'eval-expression)
      (lispy-mode 1)))
  (add-hook 'minibuffer-setup-hook 'conditionally-enable-lispy)
  :bind
  (:map lispy-mode-map
        (":" . self-insert-command)
        ("M-o" . ace-window)))

(use-package clojure-mode
  :ensure t)

(use-package cider
  :ensure t
  :after clojure-mode
  :custom
  (cider-repl-display-help-banner nil)
  (cider-repl-pop-to-buffer-on-connect 'display-only)
  (cider-save-file-on-load t)
  (nrepl-hide-special-buffers t))

(use-package eglot
  :hook (clojure-mode . eglot-ensure)
  :bind (:map eglot-mode-map
              ("C-c l r" . eglot-rename)
              ("C-c l a" . eglot-code-actions)
              ("C-c l f" . eglot-format-buffer))
  ;; Uncomment if docs from both CIDER and eglot in the echo area get noisy:
  ;; :config
  ;; (setq eglot-ignored-server-capabilities '(:hoverProvider))
  )

(use-package eldoc
  :hook ((typescript-mode) . eldoc-mode))

;; Whitespace, etc
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(defun my-bell-function ()
  (unless (memq this-command
                '(isearch-abort abort-recursive-edit exit-minibuffer minibuffer-keyboard-quit
                                keyboard-quit mwheel-scroll down up next-line previous-line
                                backward-char forward-char))
    (ding)))
(setq ring-bell-function 'my-bell-function)

(use-package ag
  :ensure t)

(use-package projectile
  :ensure t
  :demand t
  :config
  (define-key projectile-mode-map (kbd "s-p")   #'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") #'projectile-command-map)
  (define-key projectile-command-map (kbd "s") #'projectile-ag)
  (projectile-mode +1))


(use-package geiser
  :ensure t)

(use-package geiser-chez
  :ensure t
  :config
  (setq geiser-chez-binary "chez"))

(use-package org
  :mode ("\\.org" . org-mode)
  :hook ((org-mode) . visual-line-mode)
  :custom
  (org-startup-indented t)
  (org-startup-folded 'no-fold))

(use-package vertico
  :ensure t
  :init
  (vertico-mode)
  :custom
  (vertico-cycle t))

(use-package savehist
  :ensure t
  :init
  (savehist-mode))

(use-package marginalia
  :ensure t
  :after vertico
  :init
  (marginalia-mode))

(use-package orderless
  :ensure t
  :custom
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)

  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion))
                                   (cider (styles basic))))
  (completion-category-defaults nil) ;; Disable defaults, use our settings
  (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring

(use-package consult
  :ensure t
  :bind (;; Drop-in replacements for Ivy/Counsel
         ("C-s" . consult-line)        ;; Replaces Swiper
         ("C-x b" . consult-buffer)    ;; Replaces Ivy-Switch-Buffer
         ("M-y" . consult-yank-pop)    ;; Replaces Counsel-Yank-Pop
         ("M-g g" . consult-goto-line) ;; Replaces Goto-Line
         ("M-g i" . consult-imenu) ;; Jump to function/variable in file
         ("C-x r b" . consult-bookmark)) ;; Bookmarks
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :init
  ;; Better register preview
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)
  (advice-add #'register-preview :override #'consult-register-window))

(use-package corfu
  :ensure t
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto t)                    ;; Enable auto completion
  (corfu-quit-no-match 'separator)) ;; Quit if no match


(use-package emacs
  :custom
  ;; Enable context menu. `vertico-multiform-mode' adds a menu in the minibuffer
  ;; to switch display modes.
  (context-menu-mode t)
  ;; Support opening new minibuffers from inside existing minibuffers.
  (enable-recursive-minibuffers t)
  ;; Hide commands in M-x which do not work in the current mode.  Vertico
  ;; commands are hidden in normal buffers. This setting is useful beyond
  ;; Vertico.
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; Do not allow the cursor in the minibuffer prompt
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt)))
