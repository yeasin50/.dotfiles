;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;
(setq user-full-name "Md. Yeasin Sheikh"
      user-mail-address "")

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 14))
(setq-default line-spacing 4)

(use-package! wakatime-mode
  :config
  (global-wakatime-mode 1))

;; Smooth mouse/trackpad scrolling
(pixel-scroll-precision-mode 1)

(setq scroll-conservatively 101
      scroll-margin 3
      scroll-preserve-screen-position t)


;; open  link like nvim
(map! :leader
      :desc "Open URL at point"
      "g x" #'browse-url-at-point)

;; open vterm with 'SPC o t'
(map! "C-`" #'vterm)

;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; File navigation
(map! :leader
      :desc "Recent files"
      "f f" #'recentf-open-files

      :desc "Find project files"
      "c f" #'projectile-find-file)

;; Terminal
(map! "C-\\" #'vterm)

;; Buffer tabs
(after! centaur-tabs
  (centaur-tabs-mode 1)

  ;; Alt + 1 through 9
  (dotimes (i 9)
    (let ((n (1+ i)))
      (define-key evil-normal-state-map
        (kbd (format "M-%d" n))
        `(lambda ()
           (interactive)
           (centaur-tabs-select-visible-tab ,n))))))


;; Soft wrapping
(global-visual-line-mode 1)

;; Evil visual-line navigation
(setq evil-respect-visual-line-mode t
      line-move-visual t)

;; Normal mode
(map! :n
      "j" #'evil-next-visual-line
      "k" #'evil-previous-visual-line
      "<down>" #'evil-next-visual-line
      "<up>" #'evil-previous-visual-line)

;; Insert mode
(map! :i
      "<down>" #'evil-next-visual-line
      "<up>" #'evil-previous-visual-line)
