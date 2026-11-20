;;; doom/.config/doom/config/floating_window.el -*- lexical-binding: t; -*-

(add-to-list 'load-path ;; temporary load it; it wasn;t working without it or any pkg
             (expand-file-name
              ".local/straight/build-29.3/vertico-posframe"
              doom-emacs-dir))
(use-package! vertico-posframe
  :after vertico
  :config
  (setq vertico-posframe-width 90
        vertico-posframe-height 12
        vertico-posframe-border-width 2
        vertico-posframe-parameters
        '((left-fringe . 8)
          (right-fringe . 8)
          (internal-border-width . 12))
        vertico-posframe-poshandler
        #'posframe-poshandler-frame-center)

  (vertico-posframe-mode 1))

(after! vertico
  (setq vertico-count 10
        vertico-cycle t))

