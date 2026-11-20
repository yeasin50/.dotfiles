;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; Personal Doom Emacs configuration.

(setq user-full-name "Md. Yeasin Sheikh"
      user-mail-address "")

;; Appearance
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 16)
      display-line-numbers-type 'relative
      font-lock-maximum-decoration t)
(setq-default line-spacing 4)

(menu-bar-mode -1)


;; smooth scroll not working
(after! ultra-scroll
  (setq scroll-conservatively 101
        scroll-margin 3
        scroll-preserve-screen-position t)

  ;; Restore normal Evil half-page scrolling
  (define-key evil-motion-state-map (kbd "C-d") #'evil-scroll-down)
  (define-key evil-motion-state-map (kbd "C-u") #'evil-scroll-up))
;; < end of smooth  scroll


;; WakaTime
(use-package! wakatime-mode
  :config
  (global-wakatime-mode 1))


;; Org
(setq org-directory "~/org/")

;; Navigation
(map! :leader
      :desc "Recent files"       "f f" #'recentf-open-files
      :desc "Find project files" "c f" #'projectile-find-file
      :desc "Open URL at point"  "g x" #'browse-url-at-point)

;; Visual line navigation
(global-visual-line-mode 1)


;; Tab & Indentation (2 spaces)
(setq-default tab-width 2
              standard-indent 2
              indent-tabs-mode nil)


(map! :leader
      "r" (lambda ()
            (interactive)
            (when (get-buffer "*vterm*")
              (with-current-buffer "*vterm*"
                (vterm-send-string "r")
                (vterm-send-return))))
      )

;; Load custom Tokyo Night Storm theme
(add-to-list 'custom-theme-load-path doom-user-dir)
(setq doom-theme 'tokyo-night-storm)

;;; end of config
(load! "config/toggle_term")
(load! "config/floating_window")
(load! "config/close_buffer")
(load! "config/lsp")
