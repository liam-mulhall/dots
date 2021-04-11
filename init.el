;     ___           _ _
;    /   \___  _ __( ) |_
;   / /\ / _ \| '_ \/| __|
;  / /_// (_) | | | || |_
; /___,' \___/|_| |_| \__|
;
;           _ _ _
;   ___  __| (_) |_
;  / _ \/ _` | | __|
; |  __/ (_| | | |_
;  \___|\__,_|_|\__|
;
;      _ _               _   _
;   __| (_)_ __ ___  ___| |_| |_   _
;  / _` | | '__/ _ \/ __| __| | | | |
; | (_| | | | |  __/ (__| |_| | |_| |_
;  \__,_|_|_|  \___|\___|\__|_|\__, (_)
;                              |___/
;    __   _ _ _
;   /__\_| (_) |_
;  /_\/ _` | | __|
; //_| (_| | | |_
; \__/\__,_|_|\__|
;
;  _   _
; | |_| |__   ___
; | __| '_ \ / _ \
; | |_| | | |  __/
;  \__|_| |_|\___|
;
;    ___                                     _
;   /___\_ __ __ _       _ __ ___   ___   __| | ___
;  //  // '__/ _` |_____| '_ ` _ \ / _ \ / _` |/ _ \
; / \_//| | | (_| |_____| | | | | | (_) | (_| |  __/
; \___/ |_|  \__, |     |_| |_| |_|\___/ \__,_|\___|
;            |___/
;   __ _ _
;  / _(_) | ___
; | |_| | |/ _ \
; |  _| | |  __/_
; |_| |_|_|\___(_)
;

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(setq initial-buffer-choice "~/base/gtd/todo.org")

(set-fringe-mode 10)

(tooltip-mode -1)

(tool-bar-mode -1)

(scroll-bar-mode -1)

(column-number-mode)

;; Enable line numbers for some modes.
(dolist (mode '(text-mode-hook
                prog-mode-hook
                conf-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 1))))

;; Override some modes which derive from the above.
(dolist (mode '(org-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

(add-to-list 'default-frame-alist
             '(font . "Courier"))

(use-package all-the-icons)

(use-package doom-modeline
  :init
  (doom-modeline-mode 1))

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-solarized-light t)
  (doom-themes-visual-bell-config)
  (setq doom-themes-treemacs-theme "doom-colors") ; Use the colorful Treemacs theme.
  (doom-themes-treemacs-config)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package counsel
  :demand
  t
  :bind
  (("M-x" . counsel-M-x)
  ("C-x b" . counsel-ibuffer)
  ("C-x C-f" . counsel-find-file)
  ("C-M-j" . counsel-switch-buffer)
  ("C-M-l" . counsel-imenu)
  :map
  minibuffer-local-map
  ("C-r" . 'counsel-minibuffer-history)))

(use-package swiper)

(use-package ivy
  :diminish
  :bind
  (("C-s" . swiper)
  :map
  ivy-minibuffer-map
  ("TAB" . ivy-alt-done)
  ("C-l" . ivy-alt-done)
  ("C-j" . ivy-next-line)
  ("C-k" . ivy-previous-line)
  :map
  ivy-switch-buffer-map
  ("C-k" . ivy-previous-line)
  ("C-l" . ivy-done)
  ("C-d" . ivy-switch-buffer-kill)
  :map
  ivy-reverse-i-search-map
  ("C-k" . ivy-previous-line)
  ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package which-key
  :init
  (which-key-mode)
  :diminish
  which-key-mode
  :config
  (setq which-key-idle-delay 0.2))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . helpful-function)
  ([remap describe-symbol] . helpful-symbol)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-command] . helpful-command)
  ([remap describe-key] . helpful-key))

(unless (package-installed-p 'evil)
  (package-install 'evil))
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1))
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)

(use-package evil-collection
  :after
  evil
  :config
  (evil-collection-init))

(use-package projectile
  :diminish
  projectile-mode
  :config
  (projectile-mode)
  :custom
  ((projectile-completion-system 'ivy))
  :demand
  t
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/base")
  (setq projectile-project-search-path '("~/base")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config
  (counsel-projectile-mode))

(use-package magit)

(use-package forge)

(setq auth-sources '("~/.authinfo.gpg"))

(defun lem/org-mode-setup ()
  (org-indent-mode))

(use-package org
  :hook
  (org-mode . lem/org-mode-setup)
  :config
  (setq org-ellipsis " ▾"
        org-hide-emphasis-markers t))

(use-package org-superstar
  :after
  org
  :hook
  (org-mode . org-superstar-mode))

(setq org-agenda-files
      '("~/base/gtd/todo.org" "~/base/gtd/calendar.org"))

(use-package mu4e
  :ensure
  nil 
  :defer
  20 ; Wait 20 seconds after startup.
  
  :config

  ;; Tell Emacs where mu4e is.
  ;; (add-to-list 'load-path "/opt/local/bin/mu")
  (setq mu4e-mu-binary "/opt/local/bin/mu")
  
  ;; This is set to true to avoid mail syncing issues when using mbsync.
  (setq mu4e-change-filenames-when-moving t)

  ;; Refresh mail using isync every 10 minutes.
  (setq mu4e-update-interval (* 10 60))
  (setq mu4e-get-mail-command "mbsync -a")
  (setq mu4e-maildir "~/base/mail")

  ;; Set folders.
  (setq mu4e-drafts-folder "/[Gmail]/Drafts")
  (setq mu4e-sent-folder   "/[Gmail]/Sent Mail")
  (setq mu4e-refile-folder "/[Gmail]/All Mail")
  (setq mu4e-trash-folder  "/[Gmail]/Trash")

  ;; Set shortcuts.
  (setq mu4e-maildir-shortcuts
      '(("/Inbox"             . ?i)
        ("/[Gmail]/Sent Mail" . ?s)
        ("/[Gmail]/Trash"     . ?t)
        ("/[Gmail]/Drafts"    . ?d)
        ("/[Gmail]/All Mail"  . ?a))))
