(setq package-install-upgrade-built-in t)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)
(setq use-package-always-ensure t)

;; Change the default font
(defvar FONT "MesloLGS NF-13")
(set-face-attribute 'default nil :font FONT)
(set-frame-font FONT nil t)

;; Don't show the splash screen
(setq inhibit-startup-message t)

;; Turn off some unneeded UI elements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Remembering recently edited files
(recentf-mode 1)

;; Remembering minibuffer prompt history
(setq history-length 30)
(savehist-mode 1)

;; Remember and restore the last cursor location of opened files
(save-place-mode 1)

;; Wrapping lines at the end of the screen
(global-visual-line-mode t)

;; Move customization variables to a separate file and load it
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror 'nomessage)

;; Don't pop up UI dialogs when prompting
(setq use-dialog-box nil)

;; Revert buffers when the underlying file has changed
(global-auto-revert-mode 1)

;; Revert Dired and other buffers
(setq global-auto-revert-non-file-buffers t)

;; Display column numbers
(column-number-mode)

;; Display line numbers in every buffer...
(global-display-line-numbers-mode 1)

;; ... except for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Setting up the custom folder theme
(setq custom-theme-directory "~/.config/emacs/themes")

;; Install doom-themes
(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic nil)
  (load-theme 'doom-solarized-dark-high-contrast t)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

;; Display time and date in the modeline
(setq display-time-day-and-date t
      display-time-default-load-average nil)
(display-time)

;; Display battery info in the modeline
(display-battery-mode 1)

;; Better options for backups
(setq backup-by-copying t
      backup-directory-alist
      '(("." . "~/.config/emacs/backup"))
      delete-old-versions 5
      kept-new-versions 5
      kept-old-versions 5
      version-control t)

;; Setting org-roam folder for inclusion in the agenda
(setq org-agenda-files
      (list "~/Documents/Notes/" "~/Documents/Notes/Daily"))

;; Defining TODO keywords
(setq org-todo-keywords
  '((sequence "TODO" "NEXT" "WAIT" "DONE")))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; Adding flex (fuzzy, scatter) completion to completion-styles.
(setq completion-styles '(basic partial-completion emacs22 flex))

;; Adding org-roam options.
(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory
   (file-truename "~/Documents/Notes/"))
  (org-roam-dailies-directory "Daily/")
  (org-roam-mode-sections
      (list #'org-roam-backlinks-section
            #'org-roam-reflinks-section))

  (org-roam-capture-templates
      '(("d" "default" entry
         "* %?"
         :target (file+head "%<%Y%m%d%H%M%S>.org"
                            "#+title: %<%Y%m%d%H%M%S>\n")
	 :unnarrowed t)))

  (org-roam-dailies-capture-templates
      '(("d" "default" entry
         "* %?"
         :target (file+head "%<%Y-%m-%d>.org"
                            "#+title: %<%Y-%m-%d>\n"))))

  :bind
  (("C-c r b t" . org-roam-buffer-toggle)
   ("C-c r n f" . org-roam-node-find)
   ("C-c r g" . org-roam-graph)
   ("C-c r n i" . org-roam-node-insert)
   ("C-c r c" . org-roam-capture)
   ;; Dailies
   ("C-c r d c d" . org-roam-dailies-capture-date)
   ("C-c r d c t" . org-roam-dailies-capture-today)
   ("C-c r d c T" . org-roam-dailies-capture-tomorrow)
   ("C-c r d g d" . org-roam-dailies-goto-date)
   ("C-c r d g t" . org-roam-dailies-goto-today)
   ("C-c r d g T" . org-roam-dailies-goto-tomorrow)
   ("C-c r d g y" . org-roam-dailies-goto-yesterday))

  :config
  (org-roam-setup)
  (org-roam-db-autosync-mode))

;; Working memory opens with Emacs
(find-file "~/Documents/Notes/Working memory.txt")
