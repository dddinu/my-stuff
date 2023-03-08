(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(modus-vivendi))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(all-the-icons doom-modeline ggtags cmake-mode smooth-scroll iedit auto-complete-c-headers yasnippet-snippets yasnippet-classic-snippets yasnippet auto-complete))
 '(warning-suppress-types '(((python python-shell-completion-native-turn-on-maybe)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; CUSTOM SETTINGS


;;;;;;;;;; NON-PACKAGE GENERAL SETTINGS ;;;;;;;;;;

;; disable backup files
(setq make-backup-files nil)
;; disable the tool bar
(tool-bar-mode -1)
;; disable auto-save
(setq auto-save-default nil)
;; enable current line highlighting
;; (global-hl-line-mode 1)
;; make the cursor a bar
(setq-default cursor-type 'bar)
;; maximize on startup
(add-hook 'window-setup-hook 'toggle-frame-maximized t)
;; enable line numbers to be shown on all buffers
(global-linum-mode 1)
;; rebind kill buffer
(global-set-key (kbd "C-x C-k") 'kill-buffer)
;; turn off beeping
(setq visible-bell 1)
;; screen scrolling
(defun my-scroll-up ()
  (interactive)
  (scroll-down 1)
  )
(defun my-scroll-down ()
  (interactive)
  (scroll-up 1)
  )
(global-set-key (kbd "M-<up>") 'my-scroll-up)
(global-set-key (kbd "M-<down>") 'my-scroll-down)


;; disable the *scratch* buffer
(add-hook 'emacs-startup-hook (lambda ()
				(when (get-buffer "*scratch*")
				  (kill-buffer "*scratch*")
				  )))
;; disable *Messages* buffer
(setq-default message-log-max nil)
(kill-buffer "*Messages*")
;; disable *Completions* buffer
(add-hook 'minibuffer-exit-hook
	  (lambda ()
	     (let ((buffer "*Completions*"))
	       (and (get-buffer buffer)
		    (kill-buffer buffer)
		    ))))


;;;;;;;;;; DIRED SETTINGS ;;;;;;;;;;

;; make dired not have so many fucking buffers
(put 'dired-find-alternate-file 'disabled nil)
;; enable line highlighting when in dired
(add-hook 'dired-mode-hook
	  (lambda ()
	    (hl-line-mode 1)
	    ;; remap enter and previous directory
	    (define-key dired-mode-map (kbd "C-<right>") 'dired-find-alternate-file)
	    (define-key dired-mode-map (kbd "C-<left>") 'dired-up-directory)))


;;;;;;;;;; PACKAGE SPECIFIC SETTINGS ;;;;;;;;;;

;; start package with emacs
(require 'package)
;; add MELPA to repository list
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/")
	     '("melpa-stable" . "https://stable.melpa.org/packages/"))
;; initialize package
(package-initialize)
;; refresh the package list so we can instal shit
(package-refresh-contents)

;; rest of config depends on use-package, install it if it's not here
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
  

;; ibuffer settings
(use-package ibuffer
  :ensure t
  :config
  ;; use ibuffer for buffer list
  (global-set-key (kbd "C-x C-b") 'ibuffer)
  ;; define a function to put the cursor at the most recent buffer when we call ibuffer
  (defun ibuffer-jump-to-last-buffer ()
    (ibuffer-jump-to-buffer (buffer-name (cadr (buffer-list))))
    )
  ;; add this function as a hook
  (add-hook 'ibuffer-hook #'ibuffer-jump-to-last-buffer)

  ;; set file modes per file type
  (setq ibuffer-saved-filter-groups
	(quote (("default"
		 ("dired" (mode . dired-mode))
		 ("py" (mode . python-mode))
		 ("c++" (mode . c++-mode))
		 ("c" (mode . c-mode))
		 ("llvm" (mode . llvm-mode))
		 ("shell" (mode . shell-script-mode))
		 ("emacs" (name . "^\\*"))
		 ))))
  ;; don't show empty filter groups
  (setq ibuffer-show-empty-filter-groups nil)
  ;; add the ibuffer hook
  (add-hook 'ibuffer-mode-hook
	    (lambda()
	      (ibuffer-auto-mode 1)
	      (hl-line-mode 1) ;; have line highlighting on
	      (ibuffer-switch-to-saved-filter-groups "default")
	      ))
  )

;; good-scroll settings
(use-package good-scroll
  :ensure t
  :config
  ;; keep it globally on
  (good-scroll-mode 1)
  ;; rebind page up and page down
  (global-set-key [next] 'good-scroll-up-full-screen)
  (global-set-key [prior] 'good-scroll-down-full-screen)
  )


;; github downloaded LLVM IR mode
(add-to-list 'load-path "~/.emacs.d/llvm")
(require 'llvm-mode)



;; yasnippet settings
(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1)
  )

;; iedit settings
(use-package iedit
  :ensure t
  :config
  ;; set iedit keybind
  (define-key global-map (kbd "C-c ;") 'iedit-mode)
  )


;;;;;;;;;; C++ development settings ;;;;;;;;;;
;; TODO: put this in a seperate file


;; get the current gcc version
(setq gcc-version (string-chop-newline (shell-command-to-string "gcc --version | head -n 1 | cut -d ' ' -f 3")))
(setq cpp-include-dirs (list (format "/usr/include/c++/%s" gcc-version)
			 (format "/usr/include/c++/%s/backward" gcc-version)
			 (format "/usr/lib/gcc/x86_64-pc-linux-gnu/%s/include" gcc-version)
			 (format "/usr/lib/gcc/x86_64-pc-linux-gnu/%s/include-fixed" gcc-version)
			 (format "/usr/lib/gcc/x86_64-pc-linux-gnu/%s" gcc-version)))
;; auto-complete settings
(unless (package-installed-p 'auto-complete)
  (package-install 'auto-complete))
(require 'auto-complete)
;; auto-complete config setings
(unless (package-installed-p 'auto-complete-config)
  (package-install 'auto-complete-config))
(require 'auto-complete-config)
(ac-config-default)

;; define function to intiialize auto-complete-c-headers
(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (setq achead:include-directories
	(append cpp-include-dirs achead:include-directories)) ;; add all these directories for auto complete
  )
;; call the function for c/c++ mode hooks
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

;; turn on semantic mode
(semantic-mode 1)
;; define function to add semantic as a suggestion backend for auto-complete
(defun my:add-semantic-to-auto-complete ()
  (add-to-list 'ac-sources 'ac-source-semantic)
  )
;; call this function for c/c++ hooks
(add-hook 'c-mode-common-hook 'my:add-semantic-to-auto-complete)

;; kernel development settings
(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
         (column (c-langelem-2nd-pos c-syntactic-element))
         (offset (- (1+ column) anchor))
         (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

(add-hook 'c-mode-common-hook
	  (lambda ()
	    ;; Add kernel style
	    (c-add-style
	     "linux-tabs-only"
	     '("linux" (c-offsets-alist
			(arglist-cont-nonempty
			 c-lineup-gcc-asm-reg
			 c-lineup-arglist-tabs-only))))))


;; adding this to c-mode-common-hook breaks for some reason, probably bc it happens before the above hook
(add-hook 'c-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode t)
	    (setq show-trailing-whitespace t)
	    (c-set-style "linux-tabs-only")))

(add-hook 'c++-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode t)
	    (setq show-trailing-whitespace t)
	    (c-set-style "linux-tabs-only")))


