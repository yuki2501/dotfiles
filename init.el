;; -*- lexical-binding: t; -*-

(eval-and-compile
  (when (or load-file-name byte-compile-current-file)
    (setq user-emacs-directory
          (file-name-as-directory
           (expand-file-name
            (file-name-directory
             (or load-file-name byte-compile-current-file))))))

  (require 'package)
  (require 'subr-x)

  (setq package-archives
        '(("gnu"   . "https://elpa.gnu.org/packages/")
          ("nongnu" . "https://elpa.nongnu.org/nongnu/")
          ("melpa" . "https://melpa.org/packages/")))

  (package-initialize)

  (unless (package-installed-p 'leaf)
    (unless package-archive-contents
      (package-refresh-contents))
    (package-install 'leaf))

  (unless (package-installed-p 'leaf-keywords)
    (unless package-archive-contents
      (package-refresh-contents))
    (package-install 'leaf-keywords))

  (require 'leaf)
  (require 'leaf-keywords)
  (leaf-keywords-init)

  ;; compile 時の free variable / unknown function 警告を抑えるための最低限
  (require 'org nil t)
  (require 'dired nil t)
  (require 'markdown-mode nil t)

  (defvar dired-use-ls-dired)
  (defvar exec-path-from-shell-variables)
  (defvar eglot-server-programs)
  (defvar treesit-language-source-alist)
  (defvar markdown-mode-map)
  (defvar org-roam-directory)
  (defvar org-roam-dailies-map)

  (declare-function markdown-shifttab "markdown-mode")

  (defvar my/org-dir
    (or (getenv "EMACS_ORG_DIR")
        (error "Environment variable EMACS_ORG_DIR is not set")))
  (defvar my/org-roam-dir
    (or (getenv "EMACS_ORG_ROAM_DIR")
        (error "Environment variable EMACS_ORG_ROAM_DIR is not set")))
  (defvar my/icloud-org-dir
    (or (getenv "EMACS_ICLOUD_ORG_DIR")
        (error "Environment variable EMACS_ICLOUD_ORG_DIR is not set")))
  (declare-function eglot-booster-mode "eglot-booster")
  (declare-function evil-org-agenda-set-keys "evil-org-agenda")

(leaf emacs
  :custom
  ((tab-always-indent . 'complete)
   (read-extended-command-predicate . #'command-completion-default-include-p))
  :config
  (setq ring-bell-function #'ignore)
  (set-language-environment "Japanese")
  )

(setq custom-file (locate-user-emacs-file "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file nil 'nomessage))

(leaf catppuccin-theme
  :ensure t
  :custom
  ((catppuccin-flavor . 'macchiato))
  :config
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme 'catppuccin t))

(leaf moody
  :ensure t
  :config
  (setq x-underline-at-descent-line t)
  (set-face-attribute 'mode-line nil :box nil)
  (set-face-attribute 'mode-line-inactive nil :box nil)
  (moody-replace-mode-line-front-space)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode))

(leaf evil
  :ensure t
  :custom
  ((evil-want-abbrev-expand-on-insert-exit . nil)
   (evil-esc-delay . 0.001))
  :config
  (evil-mode 1)
  (evil-set-leader 'normal ",")
  (evil-define-key 'normal 'global
    (kbd "<leader>fw") #'consult-ripgrep
    (kbd "<leader>ff") #'consult-fd
    (kbd "<leader>e")  #'dired
    (kbd "<leader>b")  #'consult-buffer))
(leaf dired
  :preface
  (defun my/open-org-icloud-directory ()
    (interactive)
    (dired (expand-file-name
            my/icloud-org-dir)))
  :bind
  (("C-c o" . my/open-org-icloud-directory))
  :config
  (setq dired-use-ls-dired nil)
  (with-eval-after-load 'evil
    (evil-define-key 'normal dired-mode-map
      (kbd "n") #'evil-search-next
      (kbd "N") #'evil-search-previous
      (kbd "g g") #'evil-goto-first-line
      (kbd "G")   #'evil-goto-line)))

(leaf autorevert
  :config
  (global-auto-revert-mode 1))

(leaf delsel
  :config
  (delete-selection-mode 1))

(leaf paren
  :config
  (show-paren-mode 1))

(leaf org
  :ensure t
  :preface
  (defun change-truncation ()
    (interactive)
    (setq truncate-lines (not truncate-lines)))
  :config
  (setq org-directory my/org-dir)
  (let ((bookmemofile   (expand-file-name "bookmemo.org" org-directory))
        (labmemofile    (expand-file-name "lab.org" org-directory))
        (circlememofile (expand-file-name "circle.org" org-directory))
        (hobbymemofile  (expand-file-name "hobby.org" org-directory)))
    (setq org-default-notes-file
          (expand-file-name "notes.org" org-directory)
          org-capture-templates
          `(("b" "読書メモ" entry (file+headline ,bookmemofile "Books")
             "** %?\n%t\n")
            ("l" "研究TODO" entry (file+headline ,labmemofile "■Capture")
             "* REMIND %? (wrote on %U)")
            ("c" "サークルTODO" entry (file+headline ,circlememofile "■Capture")
             "* REMIND %? (wrote on %U)")
            ("h" "趣味TODO" entry (file+headline ,hobbymemofile "■Capture")
             "* REMIND %? (wrote on %U)"))
          org-agenda-files
          (list labmemofile circlememofile hobbymemofile)
          org-todo-keywords
          '((sequence "TODO(t)" "WAIT(w)" "REMIND(r)" "|" "DONE(d)" "SOMEDAY(s)"))
          org-log-done 'time))
  (setq org-preview-latex-default-process 'dvisvgm)
  (setq org-startup-truncated nil)
  :bind
  (("C-c l" . org-store-link)
   ("C-c a" . org-agenda)
   ("C-c c" . org-capture)))

(leaf org-roam
  :ensure t
  :after org
  :config
  (setq org-roam-directory
        (file-truename my/org-roam-dir))
  (make-directory org-roam-directory t)

  (setq org-roam-completion-everywhere t)
  (setq org-roam-node-display-template
        (concat "${title:*} "
                (propertize "${tags:15}" 'face 'org-tag)))
  (setq org-roam-capture-templates
        '(("d" "default" plain
           "%?"
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+title: ${title}\n")
           :unnarrowed t)
          ("r" "reference" plain
           "%?"
           :if-new (file+head "refs/%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+title: ${title}\n#+filetags: :reference:\n#+roam_refs: \n")
           :unnarrowed t)
          ("c" "concept" plain
           "%?"
           :if-new (file+head "concepts/%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+title: ${title}\n#+filetags: :concept:\n")
           :unnarrowed t)
          ("w" "weekly" plain
           "* やったこと\n%?\n* 振り返り\n"
           :if-new (file+head "weekly/%<%Y-W%V>.org"
                              "#+title: %<%Y-W%V>\n#+filetags: :weekly:\n")
           :unnarrowed t)))

  (setq org-roam-dailies-directory "daily/")
  (make-directory
   (expand-file-name org-roam-dailies-directory org-roam-directory)
   t)

  (setq org-roam-dailies-capture-templates
        '(("d" "default" entry
           "* %<%H:%M> %?\n"
           :target (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%Y-%m-%d>\n"))))

  (setq find-file-visit-truename t)
  (org-roam-db-autosync-mode 1)
  (with-eval-after-load 'org-roam-dailies
    (global-set-key (kbd "C-c d") org-roam-dailies-map)))

(defun my/setup-exec-path-from-shell ()
  (require 'exec-path-from-shell)
  (unless (boundp 'exec-path-from-shell-variables)
    (setq exec-path-from-shell-variables nil))
  (dolist (var '("SSH_AUTH_SOCK"
                 "SSH_AGENT_PID"
                 "GPG_AGENT_INFO"
                 "LANG"
                 "LC_CTYPE"
                 "NIX_SSL_CERT_FILE"
                 "NIX_PATH"))
    (add-to-list 'exec-path-from-shell-variables var))
  (exec-path-from-shell-initialize))

(leaf exec-path-from-shell
  :ensure t
  :config
  (when (or (daemonp)
            (memq window-system '(mac ns x)))
    (my/setup-exec-path-from-shell)))


(leaf ddskk
  :ensure t
  :bind
  (("C-x C-j" . skk-mode)
   ("C-l"     . skk-latin-mode))
  :custom
  ((skk-sticky-key . ";")
   (skk-jisyo-code . 'utf-8)
   (skk-server-host . "localhost")
   (skk-server-portnum . 1178)))

(leaf which-key
  :config
  (which-key-mode 1))

(leaf nerd-icons
  :ensure t)

(leaf vertico
  :ensure t
  :config
  (vertico-mode 1))

(leaf marginalia
  :ensure t
  :config
  (marginalia-mode 1))
(defvar my/search-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "s") #'isearch-forward)
    (define-key map (kbd "C-s") #'isearch-forward-regexp)
    (define-key map (kbd "r") #'consult-ripgrep)
    map))

(global-set-key (kbd "C-M-s") my/search-map)
(leaf consult
  :ensure t
  :preface
  (defun my/consult-line (&optional at-point)
    "Consult-line uses thing-at-point if called with prefix argument."
    (interactive "P")
    (if at-point
        (consult-line (thing-at-point 'symbol))
      (consult-line)))
  :custom
  ((xref-show-xrefs-function . #'consult-xref)
   (xref-show-definitions-function . #'consult-xref)
   (consult-line-start-from-top . t)
   (consult-async-min-input . 1))
  :bind
  (([remap switch-to-buffer] . consult-buffer)
   ([remap project-switch-to-buffer] . consult-project-buffer)
   ([remap goto-line] . consult-goto-line)
   ([remap imenu] . consult-imenu)
   ("M-g f" . consult-flymake)
   ("C-s" . my/consult-line))
  :config
  (define-key minibuffer-local-map (kbd "C-r") #'consult-history))




(leaf orderless
  :ensure t
  :custom
  ((completion-styles . '(orderless basic))
   (completion-category-defaults . nil)
   (completion-category-overrides . '((file (styles partial-completion))))))



(leaf company
  :ensure t
  :custom
  ((company-idle-delay . 0.2)
   (company-minimum-prefix-length . 1)
   (company-tooltip-align-annotations . t))
  :config
  (global-company-mode 1))

(leaf company-box
  :ensure t
  :after company
  :if (display-graphic-p)
  :hook
  ((company-mode-hook . company-box-mode)))

(leaf eglot
  :ensure t
  :custom
  ((eldoc-echo-area-use-multiline-p . nil)
   (eglot-connect-timeout . 600))
  :config
  (add-to-list 'eglot-server-programs '((perl-mode perl-ts-mode) . ("pls")))
  :hook
  ((rust-ts-mode-hook       . eglot-ensure)
   (typescript-ts-mode-hook . eglot-ensure)
   (tsx-ts-mode-hook        . eglot-ensure)
   (css-ts-mode-hook        . eglot-ensure)
   (python-mode-hook        . eglot-ensure)
   (go-ts-mode-hook         . eglot-ensure)
   (nix-mode-hook           . eglot-ensure)
   (LaTeX-mode-hook         . eglot-ensure)
   (latex-mode-hook         . eglot-ensure)
   (tex-mode-hook           . eglot-ensure)
   (perl-ts-mode-hook       . eglot-ensure)
))

(leaf css-ts-mode
  :mode ("\\.css\\'" . css-ts-mode))

(leaf rust-ts-mode
  :mode ("\\.rs\\'" . rust-ts-mode))

(leaf go-ts-mode
  :mode (("\\.go\\'"      . go-ts-mode)
         ("go\\.mod\\'"   . go-mod-ts-mode)))

(defvar my/local-bin-alist
  '(("node_modules" . "node_modules/.bin")
    (".venv"        . ".venv/bin")))

(defun my/add-local-bin-path ()
  (dolist (entry my/local-bin-alist)
    (when-let* ((root (locate-dominating-file default-directory (car entry)))
                (bin  (expand-file-name (cdr entry) root)))
      (when (file-directory-p bin)
        (setq-local exec-path (cons bin exec-path))
        (setq-local process-environment
                    (cons (concat "PATH=" bin path-separator (getenv "PATH"))
                          process-environment))))))

(dolist (hook '(typescript-ts-mode-hook tsx-ts-mode-hook css-ts-mode-hook python-mode-hook))
  (add-hook hook #'my/add-local-bin-path))

(leaf perl-ts-mode
  :ensure t
  :mode (("\\.pl\\'" . perl-ts-mode)
         ("\\.pm\\'" . perl-ts-mode)
         ("\\.t\\'"  . perl-ts-mode)))

(leaf eglot-booster
  :when (executable-find "emacs-lsp-booster")
  :vc (:url "https://github.com/jdtsmith/eglot-booster")
  :config
  (eglot-booster-mode 1))


(leaf direnv
  :ensure t
  :config
  (direnv-mode 1))

(leaf magit
  :ensure t)

(leaf git-gutter
  :ensure t
  :custom
  ((git-gutter:added-sign . "+")
   (git-gutter:deleted-sign . "-")
   (git-gutter:modified-sign . "="))
  :config
  (global-git-gutter-mode 1))

(leaf org-modern
  :ensure t
  :after org
  :hook
  ((org-mode-hook . org-modern-mode)
   (org-agenda-finalize-hook . org-modern-agenda))
  :config
  (global-org-modern-mode 1)
  (set-face-attribute 'org-modern-symbol nil :family "Iosevka"))

(leaf org-journal
  :ensure t
  :custom
  ((org-journal-date-format . "%A, %d %B %Y")
   (org-journal-file-format . "%Y%m%d.org"))
  :config
  (setq org-journal-dir (expand-file-name "journal" my/org-dir))
  (global-set-key (kbd "C-c j") #'org-journal-new-entry))

(leaf evil-org
  :ensure t
  :after org
  :config
  (with-eval-after-load 'org
    (require 'evil-org)
    (require 'evil-org-agenda)
    (evil-org-agenda-set-keys)
    (add-hook 'org-mode-hook #'evil-org-mode)))


(leaf nix-mode
  :ensure t
  :mode ("\\.nix\\'" . nix-mode))

(leaf treesit
  :config
  (when (fboundp 'treesit-language-available-p)
    (setq treesit-language-source-alist
          '((json "https://github.com/tree-sitter/tree-sitter-json")
            (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
            (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
            (nix "https://github.com/nix-community/tree-sitter-nix")
            (elisp "https://github.com/Wilfred/tree-sitter-elisp")
            (ocaml "https://github.com/tree-sitter/tree-sitter-ocaml" "master" "grammars/ocaml/src")
            (ocaml-interface "https://github.com/tree-sitter/tree-sitter-ocaml" "master" "grammars/interface/src")
            (perl "https://github.com/tree-sitter-perl/tree-sitter-perl" "release" "src")
            (pod  "https://github.com/tree-sitter-perl/tree-sitter-pod" "release" "src")
            (css    "https://github.com/tree-sitter/tree-sitter-css")
            (rust   "https://github.com/tree-sitter/tree-sitter-rust")
            (go     "https://github.com/tree-sitter/tree-sitter-go")
            (gomod  "https://github.com/camdencheek/tree-sitter-go-mod")))
    (dolist (element treesit-language-source-alist)
      (let ((lang (car element)))
        (unless (treesit-language-available-p lang)
          (message "treesit: %s is not installed" lang)
          (treesit-install-language-grammar lang))))))

(leaf markdown-mode
  :ensure t
  :mode ("\\.md\\'" . gfm-mode)
  :config
  (setopt markdown-fontify-code-blocks-natively t)
  (setopt markdown-header-scaling t)
  (setopt markdown-indent-on-enter 'indent-and-new-item)
  (with-eval-after-load 'markdown-mode
    (define-key markdown-mode-map (kbd "<S-tab>") #'markdown-shifttab)))



(leaf satysfi-ts-mode
  :ensure t
  :vc (:url "https://github.com/Kyure-A/satysfi-ts-mode")
  :mode (("\\.saty\\'"  . satysfi-ts-mode)
         ("\\.satyh\\'" . satysfi-ts-mode)
         ("\\.satyg\\'" . satysfi-ts-mode)))


(provide 'init))
