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
   '(ag aggressive-indent company consult corfu counsel-projectile
        delight geiser geiser-chez git-timemachine lispy lsp-ui magit
        marginalia orderless rainbow-mode rustic smart-mode-line
        solarized-theme vertico yascroll)))

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

;; (eval-when-compile
;;   (require 'use-package))

;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(custom-safe-themes
;;    '("0009d1723a4b328571cac33b80695a606142f8fd675cc7cad9fb2857505bfbbb" "4c56af497ddf0e30f65a7232a8ee21b3d62a8c332c6b268c81e9ea99b11da0d3" "0598c6a29e13e7112cfbc2f523e31927ab7dce56ebb2016b567e1eff6dc1fd4f" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" default))
;;  '(ivy-sort-matches-functions-alist
;;    '((t)
;;      (counsel-M-x . ivy--shorter-matches-first)
;;      (counsel-find-file lambda
;;                         (name candidates)
;;                         (ivy--prefix-sort name
;;                                           (ivy--shorter-matches-first name candidates)))
;;      (ivy-completion-in-region . ivy--shorter-matches-first)
;;      (ivy-switch-buffer . ivy-sort-function-buffer)))
;;  '(js-indent-level 2)
;;  '(js-indent-switch-body t)
;;  '(js2-strict-missing-semi-warning nil)
;;  '(mac-option-modifier '(:ordinary super :function alt :mouse alt))
;;  '(org-adapt-indentation t)
;;  '(package-selected-packages
;;    '(yaml-mode geiser-chez vue-mode csound-mode python lsp-ui rustic lsp-mode geiser-mode async geiser-mit tide ag counsel-projectile projectile js2-mode markdown-mode pug-mode git-timemachine lispy rainbow-mode coffee-mode ace-window magit delight counsel solarized-theme ivy company aggressive-indent org-mode use-package)))


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

;; (use-package company
;;   :ensure t
;;   :config
;;   (setq company-tooltip-align-annotations t)
;;   :bind (:map
;;          company-mode-map
;;          ("<tab>" . company-indent-or-complete-common)
;;          :map company-active-map
;;          ("C-n" . 'company-select-next-or-abort)
;;          ("C-p" . 'company-select-previous-or-abort))
;;   :hook ((emacs-lisp-mode typescript-mode) . company-mode))

;; (use-package counsel
;;   :ensure t
;;   :bind
;;   (("M-x".  counsel-M-x)
;;    ("C-x C-f" . counsel-find-file)
;;    ("<f1> f" . counsel-describe-function)
;;    ("<f1> v" . counsel-describe-variable)
;;    ("<f1> l" . counsel-find-library)
;;    ("<f2> i" . counsel-info-lookup-symbol)
;;    ("<f2> u" . counsel-unicode-char)))

;; (use-package ivy
;;   :ensure t
;;   :config
;;   (ivy-mode 1)
;;   (setq ivy-use-virtual-buffers t)
;;   (setq ivy-count-format "(%d/%d) ")
;;   :bind (("C-s" . swiper)
;;          :map ivy-minibuffer-map
;;          ("C-m"   . ivy-alt-done)               ; RET
;;          ("C-j"   . ivy-done)
;;          ("C-M-m" . ivy-immediate-done)
;;          ("C-M-j" . ivy-call)))

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
  :init
  (setq magit-completing-read-function 'ivy-completing-read)
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
  ;; :after ace-window                     ; M-o conflicts
  :hook ((emacs-lisp-mode geiser-mode) . lispy-mode)
  :config
  (defun conditionally-enable-lispy ()
    (when (eq this-command 'eval-expression)
      (lispy-mode 1)))
  (add-hook 'minibuffer-setup-hook 'conditionally-enable-lispy)
  :bind
  (:map lispy-mode-map
        (":" . self-insert-command)
        ("M-o" . ace-window)))

;; (use-package flycheck
;;   :ensure t
;;   :init
;;   (setq flycheck-check-syntax-automatically '(save mode-enabled))
;;   :hook ((typescript-mode) . flycheck-mode))

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

;; (use-package projectile
;;   :ensure t
;;   :after (ag)
;;   :init
;;   (projectile-mode +1)
;;   :bind (:map
;;          projectile-mode-map
;;          ("s-p" . projectile-command-map)
;;          ("C-c p" . projectile-command-map)))

;; (use-package counsel-projectile
;;   :ensure t
;;   :after (projectile)
;;   :config
;;   (progn
;;     (assoc-delete-all "s" counsel-projectile-key-bindings)
;;     ;; (lambda (s1 s2)
;;     ;;   (if (stringp s1)
;;     ;;       (equal (substring s1 0 1)
;;     ;;              (substring s2 0 1))
;;     ;;     nil))
;;     (add-to-list 'counsel-projectile-key-bindings '("s" . counsel-projectile-ag) t)
;;     (counsel-projectile-mode)))

;; (setq load-path (append (list "~/.emacs.d/6.945-config") load-path))
;; (require 'mit-scheme-doc)

(use-package geiser
  :ensure t
  ;; :bind (:map geiser-mode-map ("C-c C-d C-d" . 'mit-scheme-doc-lookup))
  )

(use-package geiser-chez
  :ensure t
  :config
  (setq geiser-chez-binary "chez"))

;; (use-package rustic
;;   :ensure t
;;   :bind (:map rustic-mode-map
;;               ("M-j" . lsp-ui-imenu)
;;               ("M-?" . lsp-find-references)
;;               ("C-c C-c l" . flycheck-list-errors)
;;               ("C-c C-c a" . lsp-execute-code-action)
;;               ("C-c C-c r" . lsp-rename)
;;               ("C-c C-c q" . lsp-workspace-restart)
;;               ("C-c C-c Q" . lsp-workspace-shutdown)
;;               ("C-c C-c s" . lsp-rust-analyzer-status))
;;   :config
;;   ;; uncomment for less flashiness
;;   ;; (setq lsp-eldoc-hook nil)
;;   ;; (setq lsp-enable-symbol-highlighting nil)
;;   ;; (setq lsp-signature-auto-activate nil)

;;   ;; comment to disable rustfmt on save
;;   (setq rustic-format-on-save t)
;;   :hook
;;   (rustic-mode . (lambda ()
;;                    (setq tab-width 4)
;;                    (setq indent-tabs-mode t))))

;; (use-package lsp-mode
;;   :ensure t
;;   :commands lsp
;;   :custom
;;   ;; what to use when checking on-save. "check" is default, I prefer clippy
;;   (lsp-rust-analyzer-cargo-watch-command "clippy")
;;   (lsp-eldoc-render-all t)
;;   (lsp-idle-delay 0.6)
;;   (lsp-rust-analyzer-server-display-inlay-hints t)
;;   ;; (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
;;   ;; (lsp-rust-analyzer-display-chaining-hints t)
;;   ;; (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
;;   ;; (lsp-rust-analyzer-display-closure-return-type-hints t)
;;   ;; (lsp-rust-analyzer-display-parameter-hints nil)
;;   ;; (lsp-rust-analyzer-display-reborrow-hints nil)
;;   :config
;;   (add-hook 'lsp-mode-hook 'lsp-ui-mode))

;; (use-package lsp-ui
;;   :ensure t
;;   :commands lsp-ui-mode
;;   :custom
;;   (lsp-ui-peek-always-show t)
;;   (lsp-ui-sideline-show-hover t)
;;   (lsp-ui-doc-enable nil))

;; (use-package lsp-mode
;;   :ensure t
;;   :init
;;   ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
;;   (setq lsp-keymap-prefix "C-c l")
;;   :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
;;          lsp-rust-server to 'rust-analyzer
;;          ;; (XXX-mode . lsp)
;;          ;; if you want which-key integration
;;          ;; (lsp-mode . lsp-enable-which-key-integration)
;;          )
;;   :commands lsp)

;; ;; optionally
;; (use-package lsp-ui :commands lsp-ui-mode)
;; if you are ivy user
;; (use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
;; (use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
;; (use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; optional if you want which-key integration
;; (use-package which-key
;;   :config
;;   (which-key-mode))


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
  (completion-category-overrides '((file (styles basic partial-completion))))
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
