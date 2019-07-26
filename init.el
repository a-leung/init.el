(require 'package)
(add-to-list 'package-archives
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
    '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
    '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(package-initialize)

;; === packages to install ===
;; magit
;; multiple-cursors
;; web-mode
;; w3m  ;; https://sourceforge.net/projects/w3m/files/latest/download?source=files
;;   -> brew install w3m on macos
;; company-mode


;; load theme: evenhold https://github.com/evenhold/evenhold-theme
;; curl -O https://raw.githubusercontent.com/evenhold/evenhold-theme/master/evenhold-theme.el
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")  ;; install theme...?

(load-theme 'evenhold t)

(menu-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode 1)
(ido-mode 1)
(display-time-mode 1)
(show-paren-mode t)

(global-set-key "\C-w" 'backward-kill-word)

;; autosave stuff
(make-directory "~/.emacs.d/autosaves/" t)
(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))

(setq uniquify-buffer-name-style 'post-foward-angle-brackets)


(defun kill-line-or-region (beg end)
  "kill region if active only or kill line normally"
  (interactive "r")
  (if (region-active-p)
      (call-interactively 'kill-region)
    (call-interactively 'kill-line)))
(global-set-key (kbd "C-k") 'kill-line-or-region)

;; window and cursor navigation:

(global-set-key (kbd "C-M-J")
    (lambda () (interactive) (swap-with 'down)))
(global-set-key (kbd "C-M-K")
    (lambda () (interactive) (swap-with 'up)))
(global-set-key (kbd "C-M-H")
    (lambda () (interactive) (swap-with 'left)))
(global-set-key (kbd "C-M-L")
    (lambda () (interactive) (swap-with 'right)))

(global-set-key (kbd "M-J") (lambda () (interactive) (enlarge-window 1)))
(global-set-key (kbd "M-K") (lambda () (interactive) (enlarge-window -1)))
(global-set-key (kbd "M-H") (lambda () (interactive) (enlarge-window -1 t)))
(global-set-key (kbd "M-L") (lambda () (interactive) (enlarge-window 1 t)))
(global-set-key (kbd "M-j") 'windmove-down)
(global-set-key (kbd "M-k") 'windmove-up)
(global-set-key (kbd "M-h") 'windmove-left)
(global-set-key (kbd "M-l") 'windmove-right)

;; add some key support for ansi-term (and other terms)
(eval-after-load "term"
  '(progn
     (define-key term-raw-map (kbd "M-j") 'windmove-down)
     (define-key term-raw-map (kbd "M-k") 'windmove-up)
     (define-key term-raw-map (kbd "M-h") 'windmove-left)
     (define-key term-raw-map (kbd "M-l") 'windmove-right)

     (define-key term-raw-map (kbd "M-J") (lambda () (interactive) (enlarge-window 1)))
     (define-key term-raw-map (kbd "M-K") (lambda () (interactive) (enlarge-window -1)))
     (define-key term-raw-map (kbd "M-H") (lambda () (interactive) (enlarge-window -1 t)))
     (define-key term-raw-map (kbd "M-L") (lambda () (interactive) (enlarge-window 1 t)))
     (define-key term-raw-map (kbd "M-v") 'scroll-down)
     (define-key term-raw-map (kbd "C-v") 'scroll-up)
     ))

;; automatically save buffers associated with files on buffer switch
;; and on windows switch
(defadvice switch-to-buffer (before save-buffer-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice other-window (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-up (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-down (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-left (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-right (before other-window-now activate)
  (when buffer-file-name (save-buffer)))

;; commenting regions
(global-set-key (kbd "C-c c") 'comment-region)
(global-set-key (kbd "C-c u") 'uncomment-region)
