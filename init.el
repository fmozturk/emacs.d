;;; package --- Summary
;;; Commentary:
;;; Code:
;; Initialize package source
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(unless package-archive-contents
  (package-refresh-contents))
(setq package-load-list '(all))
(package-initialize)

;; Initialize use-package on non-Linux platform
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; (set-face-attribute 'default nil :font "Cascadia Code-10")
;; (set-face-attribute 'default nil :font "Cascadia Mono-10")
;; (set-face-attribute 'default nil :font "Consolas-10")
;; (set-face-attribute 'default nil :font "Courier New-10")
;; (set-face-attribute 'default nil :font "DejaVu LGC Sans Mono-10")
;; (set-face-attribute 'default nil :font "DejaVu Sans Mono-10")
;; (set-face-attribute 'default nil :font "Droid Sans Mono-10")
;; (set-face-attribute 'default nil :font "Fira Code-10")
;; (set-face-attribute 'default nil :font "Inconsolata-10")
(set-face-attribute 'default nil :font "JetBrains Mono-9")
;; (set-face-attribute 'default nil :font "Liberation Mono-10")
;; (set-face-attribute 'default nil :font "Lucida Console-10")
;; (set-face-attribute 'default nil :font "MS Gothic-10")
;; (set-face-attribute 'default nil :font "Noto Mono-10")
;; (set-face-attribute 'default nil :font "NSimSun-10")
;; (set-face-attribute 'default nil :font "Source Code Pro-10")
;; (set-face-attribute 'default nil :font "Ubuntu Mono-10")

(fset 'yes-or-no-p 'y-or-n-p)
(set-language-environment 'English)
(set-default-coding-systems 'utf-8)
(setq-default tab-width 4)
;; (load-theme 'wombat)
(load-theme 'adwaita)

(defalias 'list-buffers 'ibuffer)

(setq backup-by-copying t
      backup-directory-alist '(("." . "~/.emacs.d/backups"))
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(calendar-date-style 'iso)
 '(calendar-latitude 41.01)
 '(calendar-location-name "İstanbul, TR")
 '(calendar-longitude 28.95)
 '(calendar-week-start-day 1)
 '(column-number-indicator-zero-based nil)
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(display-time-24hr-format t)
 '(display-time-mode t)
 '(fill-column 120)
 '(gc-cons-threshold 100000000)
 '(global-display-line-numbers-mode t)
 '(global-hl-line-mode nil)
 '(global-linum-mode nil)
 '(ido-mode 1 nil (ido))
 '(indent-line-function 'insert-tab t)
 '(indent-tabs-mode nil)
 '(indo-enable-flex-matching t t)
 '(inhibit-startup-screen t)
 '(initial-frame-alist '((fullscreen . maximized)))
 '(ivy-mode 1)
 '(lsp-idle-delay 0.5)
 '(lsp-keymap-prefix "C-c l")
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(lsp-java dap-mode lsp-treemacs lsp-ivy helm-lsp lsp-mode hydra helm yasnippet flycheck neotree counsel-projectile projectile company general helpful ivy-rich counsel swiper which-key use-package))
 '(read-process-output-max (* 1024 1024) t)
 '(ring-bell-function 'ignore)
 '(scroll-bar-mode nil)
 '(show-paren-mode 1)
 '(system-time-locale "C" t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(visible-bell t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package which-key
  :init (which-key-mode)
  :config (setq which-key-idle-delay 1))

;;; Alternatif search view
(use-package swiper)

;; Don't show line number when org, term and shell modes active
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;;; Completion tool
(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :config (setq ivy-initial-inputs-alist nil)) ;; Don't start searches with ^

;;; Completion tool
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :init (ivy-rich-mode 1))

;;; More readable help
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-descrive-variabel)
  ([remap describe-key] . helpful-key))

;;; Key Bindings
(use-package general)
(general-define-key "C-M-j" 'counsel-switch-buffer)

;;; Text completion in buffer
(use-package company
  :config
  (global-company-mode t))

;;; Project Management
(use-package projectile
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(defun neotree-project-dir ()
    "Open NeoTree using the git root."
    (interactive)
    (let ((project-dir (projectile-project-root))
          (file-name (buffer-file-name)))
      (neotree-toggle)
      (if project-dir
          (if (neo-global--window-exists-p)
              (progn
                (neotree-dir project-dir)
                (neotree-find file-name)))
        (message "Could not find git project root."))))

(use-package neotree
  :config
  (global-set-key [f8] 'neotree-toggle)) ;;'neotree-project-dir))
(setq noe-smart-open t)

;;; Git user interface
;; (use-package magit
;;   :commands (magit-status magit-get-current-branch)
;;   :custom
;;   (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; (use-package forge)

;;; Org Mode
(use-package org
  :pin org
  :init (custom-set-variables '(org-agenda-files '("~/.emacs.d/orgdocs"))
                              '(org-agenda-include-diary t)
                              '(org-agenda-span 90)
                              '(org-clock-persist 'history)
                              '(org-src-fontify-natively t)
                              '(org-todo-keywords
                                '((sequence "TODO(t)" "PROG(p@/!)" "NEXT(n)" "|" "DONE(d@/!)")
                                  (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)")))
                              '(org-default-priority 1)
                              '(org-highest-priority 1)
                              '(org-lowest-priority 4))
  )

(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))

;; Standart key bindings
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

;; Org-mode issue with src block not expanding
;; This is a fix for bug in org-mode where <s TAB does not expand SRC block
(when (version<= "9.2" (org-version))
  (require 'org-tempo))

;;; Syntax Checking
(use-package flycheck)

;;; Template system
(use-package yasnippet
  :config (yas-global-mode))

;;; Helm is an Emacs incremental and narrowing framework
(use-package helm
  :config (helm-mode))

;;; Make bindings that stick around.
(use-package hydra)

;;; Language Server
(use-package lsp-mode
  :init (custom-set-variables '(lsp-keymap-prefix "C-c l") ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
                              '(gc-cons-threshold 100000000)
                              '(read-process-output-max (* 1024 1024))
                              '(lsp-idle-delay 0.500)
                              '(lsp-enable-links nil))
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         ;; (XXX-mode . lsp)
	     (lsp-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; optionally
;; Normally, lsp-ui is very fast but in some systems (especially when using Windows)
;; lsp-ui overlays and popups might slow down emacs.
;; (use-package lsp-ui
;;  :commands lsp-ui-mode)

;; if you are helm user
(use-package helm-lsp
  :commands helm-lsp-workspace-symbol)

;; if you are ivy user
(use-package lsp-ivy
  :commands lsp-ivy-workspace-symbol)

(use-package lsp-treemacs
  :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;;; Java support for lsp-mode
(use-package lsp-java
   :config (add-hook 'java-mode-hook 'lsp))

(require 'lsp-java-boot)

;; to enable the lenses
(add-hook 'lsp-mode-hook #'lsp-lens-mode)
(add-hook 'java-mode-hook #'lsp-java-boot-lens-mode)

