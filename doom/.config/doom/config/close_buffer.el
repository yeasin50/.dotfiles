;;; doom/.config/doom/config/close_buffer.el -*- lexical-binding: t; -*-

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
