;; [[file:../org/emacs-init.org::*Preamble][Preamble:1]]
;;; package --- Tom's init.el

  ;;; Commentary:

  ;; DO NOT EDIT: Generated from emacs-init.org 

  ;;; Code:

  ;; Initialize package sources

  (defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)
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
;; Preamble:1 ends here

;; [[file:../org/emacs-init.org::*GUI][GUI:1]]
(setq initial-frame-alist
      (append initial-frame-alist
              '((left   . 50)
                (top    . 50)
                (width  . 160)
                (height . 60))))
;; GUI:1 ends here

;; [[file:../org/emacs-init.org::*UI and Sanity][UI and Sanity:1]]
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

(set-frame-font "Hasklug Nerd Font 12" nil t)
;; (set-frame-font "Monaco 13" nil t)
;; UI and Sanity:1 ends here

;; [[file:../org/emacs-init.org::*UI and Sanity][UI and Sanity:2]]
;; TODO generate this..
      (setenv "PATH" (concat (getenv "PATH")
"/Users/tcammann/.nvm/versions/node/v12.22.7/bin:/Users/tcammann/.nvm/versions/node/v12.22.7/bin:/Users/tcammann/.nvm/versions/node/v10.24.1/bin:/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/findutils/libexec/gnubin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/TeX/texbin:/usr/local/go/bin:/Users/tcammann/.pyenv/shims:/Users/tcammann/.nvm/versions/node/v10.24.1/bin:/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/findutils/libexec/gnubin:/usr/local/opt/coreutils/libexec/gnubin:/Users/tcammann/apache-maven-3.6.3/bin/:/Users/tcammann/Downloads/google-cloud-sdk/bin/:/Users/tcammann/apache-maven-3.6.3/bin/:/Users/tcammann/Downloads/google-cloud-sdk/bin/" ; ":/Users/tom.cammann/.pyenv/shims:/Users/tom.cammann/.pyenv/bin:/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/findutils/libexec/gnubin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:/Users/tom.cammann/Downloads/google-cloud-sdk/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/TeX/texbin:/Library/Apple/usr/bin:/Library/Frameworks/Mono.framework/Versions/Current/Commands:/Users/tom.cammann/.nvm/versions/node/v11.15.0/bin:/Users/tom.cammann/.pyenv/shims:/Users/tom.cammann/.pyenv/bin:/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/findutils/libexec/gnubin:/usr/local/opt/coreutils/libexec/gnubin:/Users/tom.cammann/Downloads/google-cloud-sdk/bin:/Users/tom.cammann/Library/Python/3.8/bin:/Users/tom.cammann/go/bin:/Users/tom.cammann/bin:/Users/tom.cammann/Downloads/google-cloud-sdk/bin/:/usr/local/go/bin:/Users/tom.cammann/Library/Python/3.8/bin:/Users/tom.cammann/go/bin:/Users/tom.cammann/bin:/Users/tom.cammann/Downloads/google-cloud-sdk/bin/:/usr/local/go/bin"
  ))


      (setq exec-path (append exec-path (split-string (getenv "PATH") ":")))
;; UI and Sanity:2 ends here

;; [[file:../org/emacs-init.org::*Undo Stuff][Undo Stuff:1]]
;; (use-package undo-tree
;;   :init
;;   (global-undo-tree-mode)
;;   (setq undo-tree-auto-save-history t)
;;   (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo"))))
;; Undo Stuff:1 ends here

;; [[file:../org/emacs-init.org::*Undo Stuff][Undo Stuff:2]]
(use-package undo-fu
    :after evil
    :init
    (setq evil-undo-system 'undo-fu)
    (setq evil-undo-function 'undo-fu-only-undo)
    (setq evil-redo-function 'undo-fu-only-redo))

;; Persistent undo
(use-package undo-fu-session
  :init
  (global-undo-fu-session-mode)
  :config
  (setq undo-fu-session-incompatible-files '("/COMMIT_EDITMSG\\'" "/git-rebase-todo\\'")))
;; Undo Stuff:2 ends here

;; [[file:../org/emacs-init.org::*Core][Core:1]]
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
  (setq evil-respect-visual-line-mode t)
  ;; Disable C-i to jump forward to restore TAB functionality in Org mode.
  ;; (setq evil-want-C-i-jump nil)

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

  ;; (define-key evil-insert-state-map (kbd "C-i") 'evil-jump-forward)
  ;; (define-key evil-normal-state-map (kbd "C-i") 'evil-jump-forward)

  ;; Disable restore TAB functionality in Org mode.
  (evil-define-key 'normal org-mode-map (kbd "<tab>") #'org-cycle)

  )
;; Core:1 ends here

;; [[file:../org/emacs-init.org::*Extras][Extras:1]]
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

;; (use-package evil-org
;;  :ensure t
;;  :after org
;;  :hook (org-mode . (lambda () evil-org-mode))
;;  :config
;;  (require 'evil-org-agenda)
;;  (evil-org-agenda-set-keys))
;; Extras:1 ends here

;; [[file:../org/emacs-init.org::*Core][Core:1]]
(straight-use-package 'org)
(require 'org-tempo)

(defun air-org-skip-subtree-if-priority (priority)
  "Skip an agenda subtree if it has a priority of PRIORITY.

PRIORITY may be one of the characters ?A, ?B, or ?C."
  (let ((subtree-end (save-excursion (org-end-of-subtree t)))
        (pri-value (* 1000 (- org-lowest-priority priority)))
        (pri-current (org-get-priority (thing-at-point 'line t))))
    (if (= pri-value pri-current)
        subtree-end
      nil)))
                                        ; https://blog.aaronbieber.com/2016/09/24/an-agenda-for-life-with-org-mode.html
  (defun air-org-skip-subtree-if-habit ()
    "Skip an agenda entry if it has a STYLE property equal to \"habit\"."
    (let ((subtree-end (save-excursion (org-end-of-subtree t))))
      (if (string= (org-entry-get nil "STYLE") "habit")
          subtree-end
        nil)))

    (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
    (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
    (add-to-list 'org-structure-template-alist '("py" . "src python"))

    (use-package org
      :bind
      ("C-c !" . org-time-stamp-inactive)
       :config
       (setq org-export-backends '(ascii html icalendar latex md odt confluence))
       (setq org-agenda-custom-commands
        '(("d" "Daily agenda and all TODOs"
           ((tags "PRIORITY=\"A\""
                  ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                   (org-agenda-overriding-header "High-priority unfinished tasks:")))
            (agenda "" ((org-agenda-ndays 1)))
            (alltodo ""
                     ((org-agenda-skip-function '(or (air-org-skip-subtree-if-habit)
                                                     (air-org-skip-subtree-if-priority ?A)
                                                     (org-agenda-skip-if nil '(scheduled deadline))))
                      (org-agenda-overriding-header "ALL normal priority tasks:"))))
           ((org-agenda-compact-blocks t)))))
       (setq org-src-fontify-natively t)
       :hook (org-mode . (lambda ()
                          (org-indent-mode)
                         ;; (variable-pitch-mode 1)
                           (visual-line-mode 1)
                            ))
      )


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

    ;; (setq org-ellipsis "⤵")
    (setq org-ellipsis "▼")
;; Core:1 ends here

;; [[file:../org/emacs-init.org::*Org Extras][Org Extras:1]]
;;  (use-package org-modern)
;;  (use-package org-modern-indent
;;  ;; :load-path "~/code/emacs/org-modern-indent/"
;;  ; or
;;  :straight (org-modern-indent :type git :host github :repo "jdtsmith/org-modern-indent")
;;  :config ; add late to hook
;;  (add-hook 'org-mode-hook #'org-modern-indent-mode 90))

;;  (setq
;; ;; Edit settings
;; org-auto-align-tags nil
;; org-tags-column 0
;; org-catch-invisible-edits 'show-and-error
;; org-special-ctrl-a/e t
;; org-insert-heading-respect-content t

;; ;; Org styling, hide markup etc.
;; org-hide-emphasis-markers t
;; org-pretty-entities t
;; org-ellipsis "…")
;; Org Extras:1 ends here

;; [[file:../org/emacs-init.org::*Org Extras][Org Extras:2]]
(use-package org-brain
  :init
  (with-eval-after-load 'evil
    (evil-set-initial-state 'org-brain-visualize-mode 'emacs))
  :after org)

;; (use-package org-superstar
;;   :after org
;;   :hook (org-mode . (lambda () (org-superstar-mode 1))))

(use-package org-roam
    :after
    org
    :init
    (org-roam-db-autosync-mode)
    :custom
    (org-roam-directory "~/org/roam")
    :bind
    (("C-c n l" . org-roam-buffer-toggle)
    ("C-c n f" . org-roam-node-find)
    ("C-c n i" . org-roam-node-insert))
    :ensure t)

      (use-package org-bullets
      :after org
      :hook (org-mode . org-bullets-mode))
;; Org Extras:2 ends here

;; [[file:../org/emacs-init.org::*Org Extras][Org Extras:3]]
(use-package hide-mode-line)

    (defun efs/presentation-setup ()
      ;; Hide the mode line
      (hide-mode-line-mode 1)

      ;; Display images inline
      (org-display-inline-images) ;; Can also use org-startup-with-inline-images

      ;; Scale the text.  The next line is for basic scaling:
      (setq text-scale-mode-amount 3)
      (text-scale-mode 1))

      ;; This option is more advanced, allows you to scale other faces too
      ;; (setq-local face-remapping-alist '((default (:height 2.0) variable-pitch)
      ;;                                    (org-verbatim (:height 1.75) org-verbatim)
      ;;                                    (org-block (:height 1.25) org-block))))

    (defun efs/presentation-end ()
      ;; Show the mode line again
      (hide-mode-line-mode 0)

      ;; Turn off text scale mode (or use the next line if you didn't use text-scale-mode)
      (text-scale-mode 0)

      ;; If you use face-remapping-alist, this clears the scaling:
      ;; (setq-local face-remapping-alist '((default variable-pitch default)))
)

    (use-package org-tree-slide
      :after org
      :hook ((org-tree-slide-play . efs/presentation-setup)
             (org-tree-slide-stop . efs/presentation-end))
      :custom
      (org-tree-slide-slide-in-effect t)
      (org-tree-slide-activate-message "Presentation started!")
      (org-tree-slide-deactivate-message "Presentation finished!")
      (org-tree-slide-header t)
      (org-tree-slide-breadcrumbs " > ")
      (org-image-actual-width nil))
;; Org Extras:3 ends here

;; [[file:../org/emacs-init.org::*Org Extras][Org Extras:4]]
(add-to-list 'safe-local-variable-values '(eval add-hook 'after-save-hook (lambda nil (org-babel-tangle)) nil t))
(add-to-list 'safe-local-variable-values '(org-confirm-babel-evaluate))
;; Org Extras:4 ends here

;; [[file:../org/emacs-init.org::*GNUPlot support][GNUPlot support:1]]
(use-package gnuplot-mode)
(use-package gnuplot)
;; GNUPlot support:1 ends here

;; [[file:../org/emacs-init.org::*Calendar][Calendar:1]]
;; (use-package calfw)
;; Calendar:1 ends here

;; [[file:../org/emacs-init.org::*Themes & Icons & Dashboard][Themes & Icons & Dashboard:1]]
(use-package doom-themes
  :init (load-theme 'doom-one t))

(use-package all-the-icons
  :ensure t
)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))
;; Themes & Icons & Dashboard:1 ends here

;; [[file:../org/emacs-init.org::*Help Packages][Help Packages:1]]
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
;; Help Packages:1 ends here

;; [[file:../org/emacs-init.org::*Ivy & Counsel][Ivy & Counsel:1]]
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

  (use-package prescient)
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

(use-package all-the-icons-ivy
  :init (add-hook 'after-init-hook 'all-the-icons-ivy-setup))
;; Ivy & Counsel:1 ends here

;; [[file:../org/emacs-init.org::*Projectile][Projectile:1]]
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

(use-package ag)
;; Projectile:1 ends here

;; [[file:../org/emacs-init.org::*Company (auto-complete)][Company (auto-complete):1]]
(use-package company
  :bind
  ("M-n" . comany-complete)
  :config
  (company-mode t))

(use-package company-box
  :hook (company-mode . company-box-mode))
;; Company (auto-complete):1 ends here

;; [[file:../org/emacs-init.org::*Git][Git:1]]
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
;; Git:1 ends here

;; [[file:../org/emacs-init.org::*Git][Git:2]]
(use-package git-link)
(use-package git-timemachine)
;; Git:2 ends here

;; [[file:../org/emacs-init.org::*LSP][LSP:1]]
(use-package lsp-mode
  :commands (lsp lsp-deferred)
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
;; LSP:1 ends here

;; [[file:../org/emacs-init.org::*Dired][Dired:1]]
(use-package dired
:straight (:type built-in)
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
;; Dired:1 ends here

;; [[file:../org/emacs-init.org::*Terminal][Terminal:1]]
(use-package vterm)
;; Terminal:1 ends here

;; [[file:../org/emacs-init.org::*Flycheck][Flycheck:1]]
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))
;; Flycheck:1 ends here

;; [[file:../org/emacs-init.org::*Flyspell][Flyspell:1]]
(use-package flyspell
  :config
  (setq ispell-program-name "/usr/local/bin/aspell")
  :init
  (progn
    (add-hook 'prog-mode-hook 'flyspell-prog-mode)
    (add-hook 'text-mode-hook 'flyspell-mode)
    ))
;; Flyspell:1 ends here

;; [[file:../org/emacs-init.org::*Whitespace][Whitespace:1]]
(use-package whitespace
  :ensure t
  :diminish whitespace-mode
  ;; :init
  ;; (add-hook 'prog-mode-hook 'whitespace-mode)
  )
;; Whitespace:1 ends here

;; [[file:../org/emacs-init.org::*Python][Python:1]]
(setq python-interpreter "/Users/tcammann/.pyenv/shims/python")
(setq python-shell-interpreter "/Users/tcammann/.pyenv/shims/python")
;; (use-package python-mode)
;; (use-package pyenv-mode)
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred
;; Python:1 ends here

;; [[file:../org/emacs-init.org::*Json][Json:1]]
(use-package json-mode)
;; Json:1 ends here

;; [[file:../org/emacs-init.org::*Yaml][Yaml:1]]
(use-package yaml-mode)
;; Yaml:1 ends here

;; [[file:../org/emacs-init.org::*Markdown][Markdown:1]]
(use-package markdown-mode)
;; Markdown:1 ends here

;; [[file:../org/emacs-init.org::*HTML/CSS/JS][HTML/CSS/JS:1]]
(use-package web-mode)
;; HTML/CSS/JS:1 ends here

;; [[file:../org/emacs-init.org::*Jsonnet][Jsonnet:1]]
(use-package jsonnet-mode)
;; Jsonnet:1 ends here

;; [[file:../org/emacs-init.org::*Graphviz][Graphviz:1]]
(use-package graphviz-dot-mode
  :ensure t
  :config
  (setq graphviz-dot-indent-width 4))
;; Graphviz:1 ends here

;; [[file:../org/emacs-init.org::*CodeGPT][CodeGPT:1]]
;; (use-package openai
  ;; :straight (openai :type git :host github :repo "emacs-openai/openai"))
;; (use-package codegpt
  ;; :straight (codegpt :type git :host github :repo "emacs-openai/codegpt"))
;; CodeGPT:1 ends here
