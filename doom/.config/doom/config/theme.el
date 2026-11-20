;;; doom/.config/doom/config/theme.el -*- lexical-binding: t; -*-

;;; theme.el --- Custom Tokyo Night Storm theme

(deftheme tokyo-night-storm
  "A custom Tokyo Night Storm theme.")

(let ((bg          "#24283b")
      (bg-dark     "#1f2335")
      (bg-highlight "#292e42")
      (fg          "#c0caf5")
      (fg-dark     "#a9b1d6")
      (comment     "#565f89")
      (blue        "#7aa2f7")
      (cyan        "#7dcfff")
      (green       "#9ece6a")
      (orange      "#ff9e64")
      (magenta     "#bb9af7")
      (red         "#f7768e")
      (yellow      "#e0af68"))

  (custom-theme-set-faces
   'tokyo-night-storm

   `(default ((t (:background ,bg :foreground ,fg))))
   `(cursor ((t (:background ,blue))))
   `(region ((t (:background ,bg-highlight))))
   `(highlight ((t (:background ,bg-highlight))))
   `(fringe ((t (:background ,bg))))
   `(vertical-border ((t (:foreground ,comment))))

   `(mode-line ((t (:background ,bg-dark :foreground ,fg))))
   `(mode-line-inactive ((t (:background ,bg :foreground ,comment))))

   `(minibuffer-prompt ((t (:foreground ,blue :weight bold))))
   `(link ((t (:foreground ,cyan :underline t))))

   `(font-lock-comment-face ((t (:foreground ,comment :italic t))))
   `(font-lock-string-face ((t (:foreground ,green))))
   `(font-lock-keyword-face ((t (:foreground ,magenta))))
   `(font-lock-function-name-face ((t (:foreground ,blue))))
   `(font-lock-variable-name-face ((t (:foreground ,fg))))
   `(font-lock-type-face ((t (:foreground ,cyan))))
   `(font-lock-constant-face ((t (:foreground ,orange))))
   `(font-lock-builtin-face ((t (:foreground ,cyan))))
   `(font-lock-warning-face ((t (:foreground ,red :weight bold))))
   `(font-lock-number-face ((t (:foreground ,orange))))

   `(line-number ((t (:foreground ,comment :background ,bg))))
   `(line-number-current-line
     ((t (:foreground ,yellow :background ,bg :weight bold))))

   `(org-level-1 ((t (:foreground ,blue :weight bold))))
   `(org-level-2 ((t (:foreground ,magenta :weight bold))))
   `(org-level-3 ((t (:foreground ,cyan))))
   `(org-level-4 ((t (:foreground ,green))))
   `(org-block ((t (:background ,bg-dark))))
   `(org-code ((t (:foreground ,green))))
   `(org-link ((t (:foreground ,cyan :underline t))))

   `(error ((t (:foreground ,red :weight bold))))
   `(warning ((t (:foreground ,yellow))))
   `(success ((t (:foreground ,green))))

   `(escape-glyph ((t (:foreground ,orange))))
   `(trailing-whitespace ((t (:background ,red))))))

(provide-theme 'tokyo-night-storm)

;;; theme.el ends here
