;;; doom/.config/doom/config/toggle_term.el -*- lexical-binding: t; -*-

;;; toggle_term.el -*- lexical-binding: t; -*-

(defvar my/terminal-buffer "*vterm-popup*")

(defun my/toggle-floating-terminal ()
  "Toggle floating VTerm."
  (interactive)
  (let ((window (get-buffer-window my/terminal-buffer)))
    (if (window-live-p window)
        (progn
          (delete-window window)
          (when (bound-and-true-p evil-mode)
            (evil-normal-state)))
      (let ((buffer (get-buffer my/terminal-buffer)))
        (unless (and buffer (buffer-live-p buffer))
          (setq buffer (get-buffer-create my/terminal-buffer))
          (with-current-buffer buffer
            (vterm-mode)))
        (let ((window
               (display-buffer-in-side-window
                buffer
                '((side . bottom)
                  (slot . 0)
                  (window-height . 0.3)))))
          (select-window window))))))

(map! :map vterm-mode-map
      "C-\\" #'my/toggle-floating-terminal)

(map! :map evil-insert-state-map
      "C-\\" #'my/toggle-floating-terminal)

(map! :map evil-normal-state-map
      "C-\\" #'my/toggle-floating-terminal)
