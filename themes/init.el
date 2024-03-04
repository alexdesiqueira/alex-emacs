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

;; Move customization variables to a separate file and load it
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror 'nomessage)

;; Don't pop up UI dialogs when prompting
(setq use-dialog-box nil)

;; Revert buffers when the underlying file has changed
(global-auto-revert-mode 1)

;; Revert Dired and other buffers
(setq global-auto-revert-non-file-buffers t)

;; Display line numbers in every buffer
(global-display-line-numbers-mode 1)

;; Setting up the custom theme directory location
(setq custom-theme-directory "~/.config/emacs/themes")

;; Load theme
(load-theme 'parus t)

;; Display time and date in the modeline
(setq display-time-day-and-date t
      display-time-default-load-average nil)
(display-time)

;; Display battery info in the modeline
(display-battery-mode 1)

;; Better options for backups
(setq backup-by-copying t
      backup-directory-alist
      '(("." . "~/.config/emacs/backups"))
      delete-old-versions 5
      kept-new-versions 5
      kept-old-versions 5
      version-control t)
