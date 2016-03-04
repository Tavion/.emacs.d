;; -*- coding: utf-8 -*-

(setq user-full-name "Sheck Gu")
(setq user-login-name "Sheck")
(setq user-mail-address "gukan@xs.ustb.edu.cn")
(setq emacs-load-start-time (current-time))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))

;;----------------------------------------------------------------------------
;; Which functionality to enable (use t or nil for true and false)
;;----------------------------------------------------------------------------
(setq *macbook-pro-support-enabled* t)
(setq *is-a-mac* (eq system-type 'darwin))
(setq *is-carbon-emacs* (and *is-a-mac* (eq window-system 'mac)))
(setq *is-cocoa-emacs* (and *is-a-mac* (eq window-system 'ns)))
;;(setq *win32* (eq system-type 'windows-nt) )
;;(setq *cygwin* (eq system-type 'cygwin) )
(setq *linux* (or (eq system-type 'gnu/linux) (eq system-type 'linux)) )
(setq *unix* (or *linux* (eq system-type 'usg-unix-v) (eq system-type 'berkeley-unix)) )
(setq *linux-x* (and window-system *linux*) )
(setq *xemacs* (featurep 'xemacs) )
(setq *emacs24* (and (not *xemacs*) (or (>= emacs-major-version 24))) )
(setq *no-memory* (cond
                   (*is-a-mac*
                    (< (string-to-number (nth 1 (split-string (shell-command-to-string "sysctl hw.physmem")))) 4000000000))
                   (*linux* nil)
                   (t nil)))

;;----------------------------------------------------------------------------
;; Less GC, more memory
;;----------------------------------------------------------------------------
(defun my-optimize-gc (NUM PER)
  "By default Emacs will initiate GC every 0.76 MB allocated (gc-cons-threshold == 800000).
@see http://www.gnu.org/software/emacs/manual/html_node/elisp/Garbage-Collection.html
We increase this to 16MB by `(my-optimize-gc 16 0.5)` "
  (setq-default gc-cons-threshold (* 1024 1024 NUM)
                gc-cons-percentage PER))


(require 'init-modeline)
(require 'cl-lib)
(require 'init-compat)
(require 'init-utils)
(require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el

;; win32 auto configuration, assuming that cygwin is installed at "c:/cygwin"
;; (condition-case nil
;;     (when *win32*
;;       ;; (setq cygwin-mount-cygwin-bin-directory "c:/cygwin/bin")
;;       (setq cygwin-mount-cygwin-bin-directory "c:/cygwin64/bin")
;;       (require 'setup-cygwin)
;;       ;; better to set HOME env in GUI
;;       ;; (setenv "HOME" "c:/cygwin/home/someuser")
;;       )
;;   (error
;;    (message "setup-cygwin failed, continue anyway")
;;    ))

(require 'idle-require)
(require 'init-elpa)
(require 'init-exec-path) ;; Set up $PATH
(require 'init-frame-hooks)
;; any file use flyspell should be initialized after init-spelling.el
;; actually, I don't know which major-mode use flyspell.
(require 'init-spelling)
(require 'init-xterm)
(require 'init-gui-frames)
(require 'init-ido)
(require 'init-dired)
(require 'init-uniquify)
(require 'init-ibuffer)
(require 'init-flymake)
(require 'init-smex)
(require 'init-helm)
(require 'init-hippie-expand)
(require 'init-windows)
(require 'init-sessions)
(require 'init-git)
(require 'init-crontab)
(require 'init-markdown)
(require 'init-erlang)
(require 'init-javascript)
(require 'init-org)
(require 'init-org-mime)
(require 'init-css)
(require 'init-python-mode)
(require 'init-haskell)
(require 'init-ruby-mode)
(require 'init-lisp)
(require 'init-elisp)
(require 'init-yasnippet)
;; Use bookmark instead
(require 'init-zencoding-mode)
(require 'init-cc-mode)
(require 'init-gud)
(require 'init-linum-mode)
;; (require 'init-gist)
(require 'init-moz)
(require 'init-gtags)
;;use evil mode (vi key binding)
;;(require 'init-evil)
(require 'init-sh)
(require 'init-ctags)
(require 'init-bbdb)
(require 'init-gnus)
(require 'init-lua-mode)
(require 'init-workgroups2)
(require 'init-term-mode)
(require 'init-web-mode)
(require 'init-slime)
(require 'init-clipboard)
(require 'init-company)
(require 'init-chinese-pyim) ;; cannot be idle-required
;; need statistics of keyfreq asap
(require 'init-keyfreq)
(require 'init-httpd)

(require 'php-mode)

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; start emacs-org-mode with indent-mode
(setq org-startup-indented t)

;; 80 line-end-position
(require 'fill-column-indicator)
(setq-default fill-column 80)
(setq-default fci-column 80)
(setq-default fci-rule-column 80)
(define-globalized-minor-mode
  global-fci-mode fci-mode (lambda () (fci-mode 1)))
(add-hook 'c-mode-hook 'fci-mode)
(add-hook 'c++-mode-hook 'fci-mode)
(add-hook 'php-mode-hook 'fci-mode)
(add-hook 'ess-mode-hook 'fci-mode)
(add-hook 'java-mode-hook 'fci-mode)
(add-hook 'python-mode-hook 'fci-mode)

;; electric-operator-mode
(add-hook 'c-mode-hook 'electric-operator-mode)
(add-hook 'c++-mode-hook 'electric-operator-mode)
(add-hook 'php-mode-hook 'electric-operator-mode)
(add-hook 'ess-mode-hook 'electric-operator-mode)
(add-hook 'java-mode-hook 'electric-operator-mode)
(add-hook 'python-mode-hook 'electric-operator-mode)

(add-hook 'c-mode-hook 'hl-todo-mode)
(add-hook 'c++-mode-hook 'hl-todo-mode)
(add-hook 'php-mode-hook 'hl-todo-mode)
(add-hook 'ess-mode-hook 'hl-todo-mode)
(add-hook 'java-mode-hook 'hl-todo-mode)
(add-hook 'python-mode-hook 'hl-todo-mode)

;; about speedbar
;; (speedbar 1)
                                        ;显示所有文件
(setq speedbar-show-unknown-files t)

;; projectile costs 7% startup time

;; misc has some crucial tools I need immediately
(require 'init-misc)
(if (or (display-graphic-p) (string-match-p "256color"(getenv "TERM")))
    (require 'init-color-theme))
(require 'init-emacs-w3m)

;; {{ idle require other stuff
(setq idle-require-idle-delay 3)
(setq idle-require-symbols '(init-misc-lazy
                             init-which-func
                             init-fonts
                             init-hs-minor-mode
                             init-stripe-buffer
                             init-textile
                             init-csv
                             init-writting
                             init-doxygen
                             init-pomodoro
                             init-emacspeak
                             init-artbollocks-mode
                             init-semantic))
(idle-require-mode 1) ;; starts loading
;; }}

(when (require 'time-date nil t)
  (message "Emacs startup time: %d seconds."
           (time-to-seconds (time-since emacs-load-start-time))))

;;----------------------------------------------------------------------------
;; Locales (setting them earlier in this file doesn't work in X)
;;----------------------------------------------------------------------------
(require 'init-locales)

;; my personal setup, other major-mode specific setup need it.
;; It's dependent on init-site-lisp.el
(if (file-exists-p "~/.custom.el") (load-file "~/.custom.el"))

;; have packages installed by Homebrew
(let ((default-directory "/usr/local/share/emacs/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

;; active AucTex
(load "/usr/local/share/emacs/site-lisp/auctex.el" nil t t)
(load "/usr/local/share/emacs/site-lisp/preview-latex.el" nil t t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(setq TeX-output-view-style (quote (("^pdf$" "." "Preview %o %(outpage)"))))
(add-hook 'LaTeX-mode-hook
          (lambda ()
            (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
            (setq TeX-command-default "XeLaTeX")))

(require 'ess-site)
(setq ess-use-auto-complete t)
(setq ess-default-style 'DEFAULT)
(require 'r-autoyas)
(add-hook 'ess-mode-hook 'r-autoyas-ess-activate)

;; ace-jump-mode
(add-to-list 'load-path "~/.emacs.d/elpa/ace-jump-mode-2.0/")
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
(define-key global-map (kbd "C-c j") 'ace-jump-mode)
;; enable a more powerful jump back function from ace jump mode
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

(setq-default indent-tabs-mode nil);

;; remember-mode
;;(setq org-default-notes-file (concat org-directory "~/.emacs.d/notes"))
(define-key global-map (kbd "C-c c") 'org-capture)
(setq org-capture-templates
      '(("t" "task in inbox" entry (file+headline "~/GTD/inbox.org" "Tasks")
         "* %?\n输入于: %U\n")
        ("i" "idea in inbox" entry (file+datetree "~/GTD/inbox.org")
         "* %?\n输入于: %U\n")
        ("b" "I want to read it" entry (file+headline "~/GTD/task.org" "Reading and Learning")
         "** SOMEDAY find and read %?")))

;;以下设置仅在使用GUI时起效，终端中无效
(when (display-graphic-p)
  ;;中文与外文字体设置
  ;; Setting English Font
  (set-face-attribute 'default nil :font "Menlo")
  ;; Chinese Font
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)charset(font-spec :family "PingFang SC" :size 12)))
  ;;设置启动窗口的大小
  (setq default-frame-alist
        '((height . 57) (width . 202))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(display-time-mode t)
 '(fci-rule-color "gray50")
 '(fci-rule-use-dashes nil)
 '(git-gutter:handled-backends (quote (svn hg git)))
 '(menu-bar-mode nil)
 '(safe-local-variable-values (quote ((lentic-init . lentic-orgel-org-init))))
 '(session-use-package t nil (session))
 '(standard-indent 2)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(artbollocks-lexical-illusions-face ((t (:foreground "gray"))))
 '(artbollocks-passive-voice-face ((t (:foreground "Gray"))))
 '(bmkp-snippet ((t (:inherit region :foreground "textBackgroundColor"))))
 '(font-latex-sectioning-0-face ((t (:inherit font-latex-sectioning-1-face :foreground "dark gray" :height 1.1))))
 '(font-latex-sectioning-1-face ((t (:inherit font-latex-sectioning-2-face :foreground "dark gray" :height 1.1))))
 '(font-latex-sectioning-2-face ((t (:inherit font-latex-sectioning-3-face :foreground "dark gray" :height 1.1))))
 '(font-latex-sectioning-3-face ((t (:inherit font-latex-sectioning-4-face :foreground "dark gray" :height 1.1))))
 '(linum ((t (:inherit (shadow default) :background "#3c3f41" :foreground "#a9b7c6"))))
 '(org-level-2 ((t (:inherit outline-2 :foreground "#198899"))))
 '(region ((t (:background "highlightColor" :foreground "#465a61" :inverse-video t :underline nil :slant normal :weight normal))))
 '(window-numbering-face ((t (:foreground "DeepPink" :underline "DeepPink" :weight bold))) t))
(menu-bar-mode -1)
;;; Local Variables:
;;; no-byte-compile: t
;;; End:
(put 'erase-buffer 'disabled nil)
