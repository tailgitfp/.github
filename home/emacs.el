(setq gc-cons-threshold most-positive-fixnum ; 2^61 bytes
      gc-cons-percentage 0.6
      read-process-output-max (* 1024 1024))

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 100 1024 1024)
                  gc-cons-percentage 0.1)))

(setq large-file-warning-threshold 200000000)

(when (boundp 'w32-pipe-read-delay)
  (setq w32-pipe-read-delay 0))
;; Set the buffer size to 64K on Windows (from the original 4K)
(when (boundp 'w32-pipe-buffer-size)
  (setq irony-server-w32-pipe-buffer-size (* 64 1024)))

(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)
(setq initial-scratch-message nil)

(set-default-coding-systems 'utf-8)

(setq-default
 blink-cursor-interval 0.4
 bookmark-default-file (locate-user-emacs-file ".bookmarks.el")
 bookmark-save-flag 1
 buffers-menu-max-size 30
 case-fold-search t
 column-number-mode t
 load-prefer-newer t
 ediff-split-window-function 'split-window-horizontally
 ediff-window-setup-function 'ediff-setup-windows-plain
 indent-tabs-mode nil
 create-lockfiles nil
 auto-save-default nil
 make-backup-files nil
 mouse-yank-at-point t
 tab-width 4
 save-interprogram-paste-before-kill t
 scroll-preserve-screen-position 'always
 set-mark-command-repeat-pop t
 tooltip-delay 1.5
 fill-column 100
 truncate-lines nil
 truncate-partial-width-windows nil)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(horizontal-scroll-bar-mode -1)

;; Auto-revert mode
(global-auto-revert-mode 1)
(setq auto-revert-interval 0.5)

(fset 'yes-or-no-p 'y-or-n-p)
(save-place-mode 1)
(show-paren-mode 1)
(global-subword-mode 1)
(global-display-fill-column-indicator-mode 1)
(global-display-line-numbers-mode 1)
(global-hl-line-mode 1)
(delete-selection-mode 1)

(set-face-attribute 'default nil
                    :family "Comic Code" :weight 'semibold' :height 160)

(let ((map global-map))
  ;; (define-key map (kbd "C-x g") nil)
  ;; (define-key map (kbd "C-t") nil)
  (define-key map (kbd "C-z") nil)
  (define-key map (kbd "C-z") #'eval-buffer)
  (define-key map (kbd "C-x 4 B") #'bookmark-jump-other-window)
  )

(require 'recentf)
(recentf-mode t)
(setq recentf-max-saved-items 50)

(require 'savehist)
(setq savehist-save-minibuffer-history t)
(add-hook 'after-init-hook #'savehist-mode)

(autoload 'zap-up-to-char "misc"
  "Kill up to, but not including ARGth occurrence of CHAR." t)

(global-set-key (kbd "M-/") 'hippie-expand)

(setq hippie-expand-try-functions-list
      '(try-complete-file-name-partially
        try-complete-file-name
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill))

;; (fido-mode)

(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file."
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

(global-set-key (kbd "C-x C-r") 'ido-recentf-open)

(ido-mode t)
  (ido-everywhere t)
  (setq ido-enable-flex-matching t)
  (setq ido-use-filename-at-point 'guess)
  (setq ido-use-virtual-buffers t)
  (setq ido-create-new-buffer 'always)
  (setq ido-file-extensions-order '(".org" ".vtl" ".js" ".html" ".xml" ".el" ".ini" ".cfg" ".cnf"))
  ;; (add-to-list 'ido-ignore-files "\.bak" "")
  ;; (add-to-list 'completion-ignored-extensions ".bak" ".o" ".a" ".so" ".git" "node_modules")
  (setq magit-completing-read-function 'magit-ido-completing-read)

    (global-set-key
     "\M-x"
     (lambda ()
       (interactive)
       (call-interactively
        (intern
         (ido-completing-read
          "M-x "
          (all-completions "" obarray 'commandp))))))


;; (icomplete-mode)
(setq icomplete-compute-delay 0)

;; (setq icomplete-in-buffer 1)
;; (define-key map (kbd "RET") 'icomplete-vertical-goto-last)

;; (global-set-key (kbd "C-\\") 'fido-vertical-mode)

(setq completion-styles
      '(basic substring initials flex partial-completion))
(setq completion-category-overrides
      '((file (styles . (basic partial-completion)))))
(setq completion-cycle-threshold 2)
(setq completion-flex-nospace nil)
(setq completion-pcm-complete-word-inserts-delimiters nil)
(setq completion-pcm-word-delimiters "-_./:| ")
(setq completion-ignore-case t)
(setq completions-detailed t)
(setq-default case-fold-search t)   ; For general regexp

;; Grouping of completions for Emacs 28
(setq completions-group t)
(setq completions-group-sort nil)
(setq completions-group-format
      (concat
       (propertize "    " 'face 'completions-group-separator)
       (propertize " %s " 'face 'completions-group-title)
       (propertize " " 'face 'completions-group-separator
                   'display '(space :align-to right))))

(setq read-buffer-completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

(setq completion-show-inline-help nil)

(setq completions-detailed t)

(setq xref-show-definitions-function #'xref-show-definitions-completing-read) ; for M-.
(setq xref-show-xrefs-function #'xref-show-definitions-buffer) ; for grep and the like
(setq xref-file-name-display 'project-relative)
;; (setq xref-search-program 'rg)
