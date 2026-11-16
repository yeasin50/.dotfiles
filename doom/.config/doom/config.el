;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; Personal Doom Emacs configuration.

(setq user-full-name "Md. Yeasin Sheikh"
      user-mail-address "")

;; Appearance
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 14)
      display-line-numbers-type 'relative
      font-lock-maximum-decoration t)
(setq-default line-spacing 4)

(menu-bar-mode -1)

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

;; ;; Terminal
;; (map! "C-`" #'vterm
;;       "C-\\" #'vterm)

;; Close current buffer
(map! "C-q" #'kill-this-buffer)



;; Centaur Tabs: Switch top tabs with Alt+1..9 everywhere (including vterm)
(after! centaur-tabs
  (centaur-tabs-mode 1)

  (defun my/centaur-tabs-select-tab (index)
    "Switch to the INDEX-th visible tab in the top Centaur Tabs bar."
    (let* ((tabs (centaur-tabs-view (centaur-tabs-current-tabset)))
           (tab (nth (1- index) tabs)))
      (when tab
        (centaur-tabs-buffer-select-tab tab))))

  (dotimes (i 9)
    (let* ((n (1+ i))
           (key (format "M-%d" n)))
      (map! :niv key
            (lambda ()
              (interactive)
              (my/centaur-tabs-select-tab n))))))

;; Prevent vterm from swallowing Alt+1..9 so you can switch out of terminal tabs
(after! vterm
  (dolist (n (number-sequence 1 9))
    (add-to-list 'vterm-keymap-exceptions (format "M-%d" n))))




;; Visual line navigation
(global-visual-line-mode 1)


;; LSP
(after! lsp-mode
  (setq lsp-semantic-tokens-enable t
        lsp-enable-semantic-highlighting t
        lsp-enable-symbol-highlighting t
        lsp-use-on-type-formatting t)

  (map! :map lsp-mode-map
        :desc "Go to Declaration"
        "g D" #'lsp-find-declaration))

;; LSP Leader Keybindings
(map! :leader
      :desc "Go to Definition"       "g d" #'lsp-find-definition
      :desc "Go to References"       "g r" #'lsp-find-references
      :desc "Go to Implementation"   "g i" #'lsp-find-implementation
      :desc "Go to Type Definition"  "g D" #'lsp-find-type-definition
      :desc "Document Symbols"       "d s" #'consult-lsp-file-symbols
      :desc "Workspace Symbols"      "w s" #'consult-lsp-symbols
      :desc "Rename Symbol"          "c r" #'lsp-rename
      :desc "Code Actions"           "c a" #'lsp-execute-code-action)


;; Tab & Indentation (2 spaces)
(setq-default tab-width 2
              standard-indent 2
              indent-tabs-mode nil)


;; LSP Autocomplete: Confirm with Enter instead of Tab
(after! corfu
  (setq corfu-preselect 'first)
  (define-key corfu-map (kbd "RET") #'corfu-insert)
  (define-key corfu-map (kbd "<return>") #'corfu-insert)
  (define-key corfu-map (kbd "TAB") nil)
  (define-key corfu-map (kbd "<tab>") nil)
  (map! :map corfu-map
        :i "RET"      #'corfu-insert
        :i "<return>" #'corfu-insert
        :i "TAB"      nil
        :i "<tab>"    nil))

(after! company
  (setq company-frontends '(company-pseudo-tooltip-frontend company-echo-metadata-frontend))
  (define-key company-active-map (kbd "RET") #'company-complete-selection)
  (define-key company-active-map (kbd "<return>") #'company-complete-selection)
  (define-key company-active-map (kbd "TAB") nil)
  (define-key company-active-map (kbd "<tab>") nil)
  (define-key company-tng-map (kbd "TAB") nil)
  (define-key company-tng-map (kbd "<tab>") nil)
  (map! :map company-active-map
        :i "RET"      #'company-complete-selection
        :i "<return>" #'company-complete-selection
        :i "TAB"      nil
        :i "<tab>"    nil))
