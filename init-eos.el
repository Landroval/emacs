
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; L'INSTALLATION VIA LES PACKAGES NE FONCTIONNE PAS.
;; (require 'package)
;; (add-to-list 'package-archives
;;        '("melpa" . "http://melpa.org/packages/") t)
;; (package-initialize)


;; Custom variable, créé automatiquement.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(inhibit-startup-screen t)
 '(org-agenda-files (quote ("~/Perso/OrgNote/task.org")))
 '(package-selected-packages (quote (better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rainbow-delimiters-depth-1-face ((t (:foreground "cyan"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "orange"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "yellow"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "green"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "red"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "violet"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "purple"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "black"))))
 '(rainbow-delimiters-unmatched-face ((t (:background "cyan"))))
 )

;; ===============================================================
;; = Modification personnelle du fichier de configuration .emacs =
;; ===============================================================

;; ----- GÉNÉRAL ----
;; Répertoire par défaut
(setq default-directory "/home/aburlot/")
(setq backup-directory-alist `(("." . "~/.saves")))

;; Charge automatiquement tous les sous-dossiers de .emacs.d
(let ((default-directory "~/.emacs.d/"))
  (normal-top-level-add-subdirs-to-load-path))
;;(add-to-list 'load-path "~/.emacs.d/site-lisp/")
;;(add-to-list 'load-path "~/.emacs.d/site-lisp/auctex")
(add-to-list 'load-path "/home/aburlot/.emacs.d/melpa/")
(add-to-list 'load-path "/home/aburlot/.emacs.d/melpa/magit-20161019.2021/")

;; Upgrade packages
;;(spu-package-upgrade-daily)

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))

;; Proxy pour les packages
(setq url-proxy-services
   '(("no_proxy" . "^\\(localhost\\|10.*\\)")
     ("http" . "proxy.onecert.fr:80")
     ("https" . "proxy.onecert.fr:80")))

;; Mettre le nom du buffer courant en titre de frame
(setq frame-title-format "%b")

;; Cacher la barre de menu et la barre d'outils
(menu-bar-mode -1)
(tool-bar-mode -1)

;; Charge le thème deep blue par défaut à l'ouverture
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'monokai t)
;;(load-theme 'zenburn t)
;;(load-theme 'material t)
;;(load-theme 'desert t)

;; Ajout automatique d'un header
;;(add-hook 'emacs-lisp-mode-hook 'auto-make-header)

;; Paramètre pour défilement ligne par ligne
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

;; Permet d'imprimer un code avec la coloration syntaxique, associé à [C-f12]
(setq ps-paper-type 'a4;letter
      ps-font-size 9.0
      ps-print-header nil
      ps-landscape-mode nil
      ps-number-of-columns 1)

;; Affiche le numéro de ligne
(global-linum-mode t)

;; Mise en surbrillance des parenthèses
(show-paren-mode 1)
(setq show-paren-delay 0)

;; Mise en surbrillance du symbole sélectionné
(require 'highlight-symbol)
;; voir les raccourcis dans la section dédiée plus bas

;; ------- LaTeX -------
;; Charge le mode pdflatex par défaut
(setq TeX-PDF-mode t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

;; Charger le fichier auctex au démarrage
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
	
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode) ;; Activer la correction à la volée
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode) ;; Activer le mode math en latex automatiquement

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

;; ----- PYTHON -----
;; (add-hook 'python-mode-hook
;;       (lambda ()
;;         (setq indent-tabs-mode t)
;;         (setq tab-width 4)
;;         (setq python-indent 4)))
(setq python-indent-offset 4)
(global-set-key [C-\<] 'python-indent-shift-left)
(global-set-key [C-\>] 'python-indent-shift-right)

;; Auto-completion pour python
(if (string-equal system-name "eos511z")
    (progn
      (message "JEDI ACTIVÉ !")
      (setenv "PIP_PROXY" "http://proxy.onecert.fr:80")
      (setenv "http_proxy" "http://proxy.onecert.fr:80")
      (setenv "https_proxy" "https://proxy.onecert.fr:80")
      (defvar python-shell-virtualenv-path "/home/aburlot/.local/bin/")
      (custom-set-variables
       '(jedi:environment-root "jedi"))
      (require 'jedi-core)
      (add-hook 'python-mode-hook 'jedi:setup)
      (setq jedi:complete-on-dot t)))

;; ----- Terminal -----
(if (not window-system)
    (xterm-mouse-mode 1))

;; ----- Cassiopée -----
;;(load-library "/home/benoit/Cassiopee/Kernel/extra/Cassiopee")

;; ----- MARKDOWN MODE -----
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; (autoload 'gfm-mode "gfm-mode"
;;    "Major mode for editing GitHub Flavored Markdown files" t)
;; (add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

;; ----- Package tabbar-ruler
(setq tabbar-ruler-global-tabbar t) ; If you want tabbar
(setq tabbar-ruler-global-ruler nil) ; if you want a global ruler
(setq tabbar-ruler-popup-menu nil) ; If you want a popup menu.
(setq tabbar-ruler-popup-toolbar nil) ; If you want a popup toolbar
(setq tabbar-ruler-popup-scrollbar t) ; If you want to only show the
                                        ; scroll bar when your mouse is moving.
(require 'tabbar-ruler)

;; ----- SMART MODE LINE
(sml/setup)
(setq sml/theme 'dark)
(setq sml/name-width 60)

;; ----- RAINBOW DELIMITERS
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)


;; ----- DÉFINITION DE FONCTIONS PERSONNALISÉES -----
;; Commenter une région ou une ligne
(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)
    (when (comment-only-p beg end)
        (next-logical-line))))

;; Compilation du buffer courant
(defun tex-custom-compile-std (arg)
  (interactive "P")
  "Calls `~/.bin/maketex' on file associated with current buffer. With C-u calls `~/.bin/maketex' instead"
  (let (script texFile)
    (cond
     ((save-buffer) (buffer-file-name)
      (equal arg '(4)) (setq script "~/.bin/maketex "))
     (t (setq script "~/.bin/maketex ")))
    (async-shell-command (concat script (buffer-file-name)))) 
  ;;(delete-windows-on "*Async Shell Command*")
)

;; Ouvrir un buffer sur stelvio
(defun connect-stelvio ()
  (interactive)
  (dired "/ssh:stelvio:/tmp_user/stelvio/aburlot/"))

;; REVERT BUFFER SANS CONFIRMATION
(defun revert-buffer-no-confirm ()
    "Revert buffer without confirmation."
    (interactive) (revert-buffer t t))

;; Vérification du chargement d'un package
;;(when (require 'header2 nil :noerror)
;; (message "header2 is loaded"))

;; ------- ORG -------
(setq org-src-fontify-natively t) ;; Colorer les blocs nativement
(setq org-startup-truncated t)
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(add-to-list 'org-structure-template-alist '("C" "#+begin_comment\n?\n#+end_comment"))

;; ----- Function pour copier une ligne ou une région
(defun xah-copy-line-or-region ()
  "Copy current line, or text selection.
When called repeatedly, append copy subsequent lines.
When `universal-argument' is called first, copy whole buffer (respects `narrow-to-region').

URL `http://ergoemacs.org/emacs/emacs_copy_cut_current_line.html'
Version 2016-06-18"
  (interactive)
  (let (-p1 -p2)
    (if current-prefix-arg
        (setq -p1 (point-min) -p2 (point-max))
      (if (use-region-p)
          (setq -p1 (region-beginning) -p2 (region-end))
        (setq -p1 (line-beginning-position) -p2 (line-end-position))))
    (if (eq last-command this-command)
        (progn
          (progn ; hack. exit if there's no more next line
            (end-of-line)
            (forward-char)
            (backward-char))
          ;; (push-mark (point) "NOMSG" "ACTIVATE")
          (kill-append "\n" nil)
          (kill-append (buffer-substring-no-properties (line-beginning-position) (line-end-position)) nil)
          (message "Line copy appended"))
      (progn
        (kill-ring-save -p1 -p2)
        (if current-prefix-arg
            (message "Buffer text copied")
          (message "Text copied"))))
    (end-of-line)
    (forward-char)
    ))

;; ----- RACCOURCIS -----
;; F1 activates help like C-h
(global-set-key [C-f1] 'outline-minor-mode) ;; Raccourci pour activer outline-minor-mode
;; Sous Gnome, M-f1 ouvre le menu application
;; (global-set-key [s-f1] ')

(global-set-key [f2] 'xah-copy-line-or-region) ;; Raccourci pour renommer la fenêtre
;; (global-set-key [C-f2] ')
;; Sous Gnome, M-f2 ouvre la boîte de dialogue pour lancer une application
(global-set-key [s-f2] 'connect-stelvio)

;; F3 activates the macro definition
(global-set-key [(control f3)] 'highlight-symbol)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)
;; (global-set-key [s-f3] ')

(global-set-key [f4] 'comment-or-uncomment-region-or-line) ;; Commenter / décommenter une région
;; (global-set-key [C-f4] 'uncomment-region) ;; Décommenter une région
;; Sous Gnome, M-f4 ferme la fenêtre !
;; (global-set-key [s-f4] ')

(global-set-key [f5] 'split-window-vertically) ;; Raccourci pour séparation verticale (haut bas)
;; (global-set-key [C-f5] ')
;; (global-set-key [M-f5] ')
;; (global-set-key [s-f5] ')

(global-set-key [f6] 'split-window-horizontally) ;; Raccourci pour séparation horizontale (gauche droite)
;; (global-set-key [C-f6] ')
;; (global-set-key [M-f6] ')
;; (global-set-key [s-f6] ')

(global-set-key [f7] 'tex-custom-compile-std) ;; compiler le buffer courant avec maketex (script perso)
;; (global-set-key [C-f7] ')
;; Sous Gnome, M-f7 active le déplacement de la fenêtre
;; (global-set-key [s-f7] ')

(global-set-key [f8] 'revert-buffer-no-confirm) ;; recharger le fichier depuis le disque (sans confirmation)
(global-set-key [C-f8] 'auto-revert-mode) ;; recharger automatiquement le buffer
;; Sous Gnome, M-f8 active le redimensionnement à partir du bord haut gauche de la fenête 
;;(global-set-key [s-f8] ')

(global-set-key [f9] 'undo) ;; Autre raccourci pour undo
;; (global-set-key [C-f9] ')
;; (global-set-key [M-f9] ')
;; (global-set-key [s-f9] ')

;; F10 opens the Global menu as Ctrl+Left clic
;; (global-set-key [C-f10] ')
;; M-f10 resizes the frame
;; (global-set-key [s-f10] ')

(global-set-key [f11] 'highlight-symbol)
;; (global-set-key [C-f11] ')
;; (global-set-key [M-f11] ')
;; (global-set-key [s-f11] ') ;; Sur Gnome, mettre en plein écran

(global-set-key [f12] 'query-replace) ;; Remplacer une expression
(global-set-key [C-f12] 'ps-print-buffer-with-faces) ;; Imprimer le buffer en conservant la coloration syntaxique
;; (global-set-key [M-f12] ')
(global-set-key [s-f12] 'insert-char) ;; Insérer un caractère unicode

(global-set-key [C-tab] 'other-window) ;; Naviguer entre fenetre

;; Duplique une ligne entière
(global-set-key "\C-c\C-d" "\C-a\C- \C-e\M-w\C-m\C-a\C-y")
;; Copie la ligne actuelle
(global-set-key "\C-c\C-c\C-c" "\C-a\C- \C-e\M-w")

(global-set-key (kbd "C-c t") 'tabbar-ruler-move) ;; basculer entre les différents onglets

;; Ajout de bouton à la barre d'outil
;; (defun omar-hotel ()
;;   "another nonce menu function"
;;   (interactive)
;;   (message "hotel, motel, holiday inn"))

;; (tool-bar-add-item "spell" 'omar-hotel
;; 		   'omar-hotel
;; 		   :help   "Run fonction omar-hotel")

;; ------- MAGIT------
;;(global-set-key (kbd "C-x g") 'magit-status)

