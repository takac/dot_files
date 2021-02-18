;;; package --- Tom's init.el

;;; Commentary:

;; DO NOT EDIT: Generated from emacs-init.org 

;;; Code:

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")
                         ))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; NOTE: If you want to move everything out of the ~/.emacs.d folder
;; reliably, set `user-emacs-directory` before loading no-littering!
(setq user-emacs-directory "~/.cache/emacs")

(use-package no-littering)
;; no-littering doesn't set this by default so we must place
;; auto save files in the same path as it uses for sessions
(setq auto-save-file-name-transforms
    `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

;; Simplify UI

(setq inhibit-startup-message t)

;; Disable tool bar, menu bar, scroll bar.
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(set-fringe-mode 10)        ; Give some breathing room
(setq scroll-step 1)
(setq scroll-margin 7)
;; Turn off sounds
(setq ring-bell-function 'ignore)
(column-number-mode)
(global-display-line-numbers-mode t)
(setq-default display-line-numbers-width 5)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(save-place-mode 1)

(set-frame-font "Hasklig 12" nil t)

(setenv "PATH" (concat (getenv "PATH") ":/Users/tom.cammann/.pyenv/shims:/Users/tom.cammann/.pyenv/bin:/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/findutils/libexec/gnubin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:/Users/tom.cammann/Downloads/google-cloud-sdk/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/TeX/texbin:/Library/Apple/usr/bin:/Library/Frameworks/Mono.framework/Versions/Current/Commands:/Users/tom.cammann/.nvm/versions/node/v11.15.0/bin:/Users/tom.cammann/.pyenv/shims:/Users/tom.cammann/.pyenv/bin:/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/findutils/libexec/gnubin:/usr/local/opt/coreutils/libexec/gnubin:/Users/tom.cammann/Downloads/google-cloud-sdk/bin:/Users/tom.cammann/Library/Python/3.8/bin:/Users/tom.cammann/go/bin:/Users/tom.cammann/bin:/Users/tom.cammann/Downloads/google-cloud-sdk/bin/:/usr/local/go/bin:/Users/tom.cammann/Library/Python/3.8/bin:/Users/tom.cammann/go/bin:/Users/tom.cammann/bin:/Users/tom.cammann/Downloads/google-cloud-sdk/bin/:/usr/local/go/bin"))

(setq exec-path (append exec-path (split-string (getenv "PATH") ":")))

(use-package undo-tree
  :init
  (undo-tree-mode))

(use-package general
  :config
  (general-unbind 'normal "C-f")
  (general-unbind 'emacs "C-f")
  (general-unbind 'insert "C-f")
  )

;; evil
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  ;; (setq evil-want-C-u-scroll t)
  ;; (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)

  (define-key evil-insert-state-map (kbd "C-u") 'evil-scroll-up)
  (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)

  (define-key evil-insert-state-map (kbd "C-p") nil)
  (define-key evil-normal-state-map (kbd "C-p") nil)

  (define-key evil-insert-state-map (kbd "C-n") nil)
  (define-key evil-normal-state-map (kbd "C-n") nil)

  (define-key evil-insert-state-map (kbd "C-e") nil)
  (define-key evil-normal-state-map (kbd "C-e") nil)

  ;; (define-key evil-insert-state-map (kbd "C-f") nil)
  ;; (define-key evil-normal-state-map (kbd "C-f") nil)

  (define-key evil-insert-state-map (kbd "C-b") 'backward-char)
  (define-key evil-insert-state-map (kbd "C-f") 'forward-char)
  (define-key evil-motion-state-map (kbd "C-b") 'backward-char)
  (define-key evil-motion-state-map (kbd "C-f") 'forward-char)

  (define-key evil-motion-state-map (kbd "C-e") 'end-of-line)
  (define-key evil-insert-state-map (kbd "C-a") 'beginning-of-line-text)
  (define-key evil-normal-state-map (kbd "C-a") 'beginning-of-line-text)

  (define-key evil-insert-state-map (kbd "C-b") nil)
  (define-key evil-normal-state-map (kbd "C-b") nil)
  )

  (use-package evil-collection
    :after evil
    :config
    (evil-collection-init))


  (use-package evil-commentary
    :ensure t
    :bind (:map evil-normal-state-map
                ("gc" . evil-commentary)))

(use-package evil-visualstar
  :ensure t
    :bind (:map evil-visual-state-map
                ("*" . evil-visualstar/begin-search-forward)
                ("#" . evil-visualstar/begin-search-backward)))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package evil-easymotion
  :config
  (evilem-default-keybindings "SPC")
  (evilem-define (kbd "SPC w") 'evil-forward-word-begin)
  (evilem-define (kbd "SPC b") 'evil-backward-word-begin)
  )

(require 'org-tempo)

    (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
    (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
    (add-to-list 'org-structure-template-alist '("py" . "src python"))

    (use-package org
      :config
      (setq org-src-fontify-natively t)
      :hook (org-mode . (lambda ()
                          (org-indent-mode)
                          ;; (variable-pitch-mode 1)
                          (visual-line-mode 1)
                          ))
      )

    (use-package org-bullets
      :after org
      :hook (org-mode . org-bullets-mode))

  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (shell . t)
     (emacs-lisp . t)
     (org . t)
     (shell . t)
     (C . t)
     (python . t)
     (gnuplot . t)
     (octave . t)
     (R . t)
     (dot . t)
     (awk . t)
     ))

(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)

(use-package gnuplot-mode)
(use-package gnuplot)

(use-package doom-themes
  :init (load-theme 'doom-one t))

(use-package all-the-icons)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.5))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key)
  )

(use-package ivy
  :diminish
  ;; :bind (("C-s" . swiper)
  ;; 	:map ivy-minibuffer-map
  ;; 	("TAB" . ivy-alt-done)
  ;; 	("C-l" . ivy-alt-done)
  ;; 	("C-j" . ivy-next-line)
  ;; 	("C-k" . ivy-previous-line)
  ;; 	:map ivy-switch-buffer-map
  ;; 	("C-k" . ivy-previous-line)
  ;; 	("C-l" . ivy-done)
  ;; 	("C-d" . ivy-switch-buffer-kill)
  ;; 	:map ivy-reverse-i-search-map
  ;; 	("C-k" . ivy-previous-line)
  ;; 	("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1)
  ;; The default sorter is much to slow and the default for `ivy-sort-max-size'
  ;; is way too big (30,000). Turn it down so big repos affect project
  ;; navigation less.
  (setq ivy-sort-max-size 7500)
  :init
  (let ((standard-search-fn #'+ivy-prescient-non-fuzzy)
           ;; #'ivy--regex-plus)
        (alt-search-fn #'ivy--regex-fuzzy))
           ;; Ignore order for non-fuzzy searches by default
           ;; #'ivy--regex-ignore-order)))
    (setq ivy-re-builders-alist
          `((counsel-rg     . ,standard-search-fn)
            (swiper         . ,standard-search-fn)
            (swiper-isearch . ,standard-search-fn)
            (t . ,alt-search-fn))
          ivy-more-chars-alist
          '((counsel-rg . 1)
            (counsel-search . 2)
            (t . 3))))
)

(setq ivy-sort-max-size 7500)

(use-package counsel
  :bind (("C-M-j" . 'counsel-switch-buffer)
	 ("C-c r" . counsel-recentf)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  (counsel-mode 1))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

;; This Prescient configuration is optimized for use in System
;; Crafters videos and streams, check out the
;; [[https://youtu.be/T9kygXveEz0][video on prescient.el]] for more
;; details on how to configure it!

(use-package ivy-prescient
  :after counsel
  :custom
  (ivy-prescient-enable-filtering nil)
  :config
  (prescient-persist-mode 1)
  (ivy-prescient-mode 1))

(use-package flx
  :defer t  ; is loaded by ivy
  :init (setq ivy-flx-limit 10000))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/git/")
    (setq projectile-project-search-path '("~/git/")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package company
  :bind
  ("M-n" . comany-complete)
  :config
  (company-mode t))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package magit)

(use-package diff-hl
   :ensure t
   :defer 1
   :diminish
   :init
   :config
   ;; Highlight changes to the current file in the fringe
   ;; (add-hook 'prog-mode-hook #'diff-hl-mode)
   ;; (add-hook 'org-mode-hook #'diff-hl-mode)
   (global-diff-hl-mode)
   ;; Highlight changed files in the fringe of Dired
   (add-hook 'dired-mode-hook 'diff-hl-dired-mode)
   ;; Fall back to the display margin, if the fringe is unavailable
   ;; (unless (display-graphic-p) (diff-hl-margin-mode))
   ;; (setq diff-hl-fringe-bmp-function 'diff-hl-fringe-bmp-from-type)
   (diff-hl-margin-mode)
   (setq diff-hl-margin-side 'right)
   )

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  ;; :hook (lsp-mode . efs/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package lsp-treemacs
  :after lsp)

(use-package lsp-ivy)

(use-package dired
:ensure nil
:commands (dired dired-jump)
:bind (("C-x C-j" . dired-jump))
;; :custom ((dired-listing-switches "-agho --group-directories-first"))
:config
(evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-single-up-directory
    "l" 'dired-single-buffer))

  (use-package dired-single)

  (use-package all-the-icons-dired
    :hook (dired-mode . all-the-icons-dired-mode))

(use-package vterm)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package flyspell
  :config
  (setq ispell-program-name "/usr/local/bin/aspell")
  :init
  (progn
    (add-hook 'prog-mode-hook 'flyspell-prog-mode)
    (add-hook 'text-mode-hook 'flyspell-mode)
    ))

(use-package whitespace
  :ensure t
  :diminish whitespace-mode
  ;; :init
  ;; (add-hook 'prog-mode-hook 'whitespace-mode)
  )

(use-package python-mode)

(use-package json-mode)

(use-package yaml-mode)

(use-package markdown-mode)

(use-package web-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   '((eval add-hook 'after-save-hook
	   (lambda nil
	     (org-babel-tangle))
	   nil t))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
