;;; doom/.config/doom/config/lsp.el -*- lexical-binding: t; -*-

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

;; LSP
(after! lsp-mode
  (setq lsp-semantic-tokens-enable t
        lsp-enable-semantic-highlighting t
        lsp-enable-symbol-highlighting t
        lsp-use-on-type-formatting t)

  (map! :map lsp-mode-map
        :n "g D" #'lsp-find-declaration))



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
