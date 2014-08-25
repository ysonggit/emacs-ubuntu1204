;; ;解决emacs shell 乱码 
;; (setq ansi-color-for-comint-mode t) 
;; (customize-group 'ansi-colors) 
;; (kill-this-buffer);关闭customize窗口 
(setq default-major-mode 'text-mode);一打开就起用 text 模式
;; ;自定义按键 
(global-set-key [f1] 'shell);F1进入Shell
;; ;;目的是开一个shell的小buffer，用于更方便地测试程序(也就是运行程序了)，我经常会用到。
;; ;;f1就是另开一个buffer然后打开shell，C-f1则是在当前的buffer打开shell
;; (global-set-key [C-f5] 'previous-error)
;; (global-set-key [f5] 'next-error)
(setq backup-inhibited t);;不产生备份
(setq auto-save-default nil);不生成名为#filename# 的临时文件
;; (defun open-eshell-other-buffer ()
;;   "Open eshell in other buffer"
;;   (interactive)
;;   (split-window-vertically)
;;   (eshell))
;; (global-set-key [C-f1] 'open-eshell-other-buffer)
;; ;;(global-set-key [C-f1] 'eshell)

;; ;;ruby mode 
(add-to-list 'auto-mode-alist
	     '("\\.\\(?:gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist
	     '("\\(Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode))

;; python mode
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(load-file "~/lisp/epy/epy-init.el")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Load Cedet ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;;加载cedet
(add-to-list 'load-path "~/lisp/cedet/speedbar")
(add-to-list 'load-path "~/lisp/cedet/ede")
(add-to-list 'load-path "~/lisp/cedet/eieio")
(add-to-list 'load-path "~/lisp/cedet/semantic")
(add-to-list 'load-path "~/lisp/cedet/common")
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/auto-complete/")
(add-to-list 'load-path "~/.emacs.d/auto-install")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Set Color Theme ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'color-theme)
;; ;(color-theme-calm-forest)
;; (setq color-theme-load-all-themes nil)
(require 'color-theme-tangotango)

;; ;; select theme - first list element is for windowing system, second is for console/terminal
;; ;; Source : http://www.emacswiki.org/emacs/ColorTheme#toc9
(setq color-theme-choices 
      '(color-theme-tangotango color-theme-tangotango))

;; default-start
(funcall (lambda (cols)
    	   (let ((color-theme-is-global nil))
    	     (eval 
    	      (append '(if (window-system))
    		      (mapcar (lambda (x) (cons x nil)) 
    			      cols)))))
    	 color-theme-choices)

;; test for each additional frame or console
(require 'cl)
(fset 'test-win-sys 
      (funcall (lambda (cols)
    		 (lexical-let ((cols cols))
    		   (lambda (frame)
    		     (let ((color-theme-is-global nil))
		       ;; must be current for local ctheme
		       (select-frame frame)
		       ;; test winsystem
		       (eval 
			(append '(if (window-system frame)) 
				(mapcar (lambda (x) (cons x nil)) 
					cols)))))))
    	       color-theme-choices ))
;; hook on after-make-frame-functions
(add-hook 'after-make-frame-functions 'test-win-sys)

(color-theme-tangotango)

(require 'cedet)
;;加载ecb
(add-to-list 'load-path "~/lisp/ecb")
;;(require 'ecb)
(require 'ecb-autoloads)
;;(ecb-activate)
(when (require 'ecb nil 'noerror)
  (setq ecb-tip-of-the-day nil)
  (setq ecb-auto-compatibility-check nil)
  (setq ecb-primary-secondary-mouse-buttons 'mouse-1--C-mouse-1))

;; ;; 用M-x执行某个命令的时候，在输入的同时给出可选的命令名提示
(icomplete-mode 1)
;; (define-key minibuffer-local-completion-map (kbd "SPC") 'minibuffer-complete-word)
(setq column-number-mode t) 
(setq line-number-mode t)
(global-linum-mode 'linum-mode);;在左边显示行号
;;(global-set-key (kbd "C-a") 'view-file-other-window)
(global-font-lock-mode t);语法高亮 
(setq font-lock-maximum-decoration t)
(setq font-lock-global-modes '(not shell-mode text-mode))
(setq font-lock-verbose t)
(setq font-lock-maximum-size '((t . 1048576) (vm-mode . 5250000))) 
(setq-default kill-whole-line t);;C-k 删除该行
(fset 'yes-or-no-p 'y-or-n-p);以 y/n代表 yes/no 
(column-number-mode t);显示列号 
(show-paren-mode t);显示括号匹配 

(setq show-paren-mode t) ;;打开括号匹配显示模式
(setq show-paren-style 'parenthesis)
(display-time-mode 1);显示时间，格式如下 
(setq display-time-24hr-format t) 
(setq display-time-day-and-date t) 
(setq display-time-use-mail-icon t);;时间栏旁边启用邮件设置
(setq display-time-interval 10);;时间的变化频率，单位多少来着？
(tool-bar-mode nil);去掉那个大大的工具栏 
(scroll-bar-mode nil);去掉滚动条 
(auto-save-mode nil);;禁止自动保存
(put 'scroll-left 'disabled nil);;允许屏幕左移
(put 'scroll-right 'disabled nil);;允许屏幕右移
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil) 
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'LaTeX-hide-environment 'disabled nil)
(mouse-avoidance-mode 'animate);光标靠近鼠标指针时，让鼠标指针自动让开 
(setq mouse-yank-at-point t);支持中键粘贴 
(transient-mark-mode t);允许临时设置标记 
;; ;; 高亮显示C/C++中的可能的错误(CWarn mode)
(global-cwarn-mode 1)
;; (global-set-key (kbd "C-x /") 'help-command);;重新绑定帮助快捷键
;;  (global-set-key (kbd "<C-down-mouse-1>") nil) ;; 去掉原来的帮定关系
;;  (global-set-key (kbd "<C-mouse-1>") 'mouse-buffer-menu);;ctrl+鼠标左键调出选择切换buffer功能
;; (global-set-key (kbd "<C-down-mouse-2>") 'mouse-popup-menuar-stuff);;ctrl+鼠标右键调出和编辑相关功能
;; (global-set-key [C-f2] 'slime-compile-file);slime编译文件
(global-set-key [C-f3] 'python-shell);F3进入Python-Shell
(global-set-key [C-f6] 'gdb);F5调试程序 
;; (setq compile-command "make -f Makefile") 
;; ;;(global-set-key [f7] 'compile);F7编译文件 
;; ;;  C-f7, 设置编译命令; f7, 保存所有文件然后编译当前窗口文件 
;; (defun du-onekey-compile ()
;;   "Save buffers and start compile"
;;   (interactive)
;;   (save-some-buffers t)
;;   (switch-to-buffer-other-window "*compilation*")
;;   (compile compile-command))
;; (global-set-key [C-f7] 'compile)
;; (global-set-key [f7] 'du-onekey-compile)
(setq speedbar-show-unknown-files t);;可以显示所有目录以及文件
;; ;;让 dired 可以递归的拷贝和删除目录。
;; (setq dired-recursive-copies 'top)
;; (setq dired-recursive-deletes 'top)
(global-set-key (kbd "C-x C-e")  'ecb-activate);;启动Ecb
;; (global-set-key [C-f9] 'dired);;设置[C-f9]为调用dired命令
(global-set-key [C-f10] 'undo);;设置C-F10为撤销
;; (global-set-key [C-f11] 'calendar) ;;设置C-F11快捷键指定Emacs 的日历系统
;; (global-set-key [C-f12] 'list-bookmarks);;设置C-F12 快速察看日程安排
;; (global-set-key (kbd "C-|") 'other-window);窗口间跳转 
(global-set-key [f2] 'kill-this-buffer);F2关闭当前buffer
(global-set-key [M-return] 'kill-this-buffer);M-return关闭当前buffer 
(global-set-key [f10] 'split-window-vertically);F10分割窗口 
(global-set-key [f11] 'delete-other-windows);F11 关闭其它窗口 
(global-set-key [f12] 'my-fullscreen);F12 全屏 
;; (global-set-key (kbd "C-,") 'backward-page);文件首 
;; (global-set-key (kbd "C-.") 'forward-page);文件尾 
;; (global-set-key (kbd "C-'") 'next-buffer);转到下一个buffer
;; (global-set-key (kbd "C-;") 'previous-buffer);转到上一个buffer
;; (global-set-key (kbd "C-/") 'next-multiframe-window);;转到下一个窗口
;; (global-set-key (kbd "C-?") 'previous-multiframe-window);;转到上一个窗口
;; (global-set-key (kbd "C-a") 'beginning-of-line);;跳转到行首
;; (global-set-key (kbd "C-e") 'end-of-line);;跳转到行尾
;; (global-set-key (kbd "C-c C-g") 'goto-char) ;;跳转到行任意位子
;; (setq mouse-drag-copy-region nil);;取消鼠标选择即复制 
;; ;普通设置 
(setq inhibit-startup-message t);关闭起动时闪屏 
;; (setq visible-bell t);关闭出错时的提示声 
;; ;;(menu-bar-mode nil);;关闭菜单
;;  ;;shell,gdb退出后，自动关闭该buffer   
;;  (defun kill-buffer-when-shell-command-exit ()
;;   "Close current buffer when `shell-command' exit."
;;   (let ((process (ignore-errors (get-buffer-process (current-buffer)))))
;;     (when process
;;       (set-process-sentinel process
;;                             (lambda (proc change)
;;                               (when (string-match "\\(finished\\|exited\\)" change)
;;                                 (kill-buffer (process-buffer proc))))))))
 
;; ;; 退出gdb的时候关闭gdb对应的buffer
;; (add-hook 'gdb-mode-hook 'kill-buffer-when-shell-command-exit)
;; ;; 退出term的时候关闭term对应的buffer
;; (add-hook 'term-mode-hook 'kill-buffer-when-shell-command-exit)
;; ;;编译成功后自动关闭*compilation* 函数
;; (defun kill-buffer-when-compile-success (process)
;;   "Close current buffer when `shell-command' exit."
;;   (set-process-sentinel process
;;                         (lambda (proc change)
;;                           (when (string-match "finished" change)
;;                             (delete-windows-on (process-buffer proc))))))
 
;; ;; 编译成功后自动关闭*compilation* buffer
;; (add-hook 'compilation-start-hook 'kill-buffer-when-compile-success)
;; ;;退出时寻问 
;; (setq kill-emacs-query-functions
;;       (lambda ()
;;         (y-or-n-p "Do you really want to quit? ")))
;; (global-set-key (kbd "M-g") 'goto-line);;设置M-g为goto-line

;; ;; 尽快显示按键序列
;; (setq echo-keystrokes 0.1)
;; (setq system-time-locale "C")


;; (setq compile-command "make")
;; ;;emacs的默认compile命令是调用make -k，我把它改成了make。你也可以把它改成其他的，比如gcc之类的.
;; ;;把c语言风格设置为k&r风格
(add-hook 'c-mode-hook
'(lambda ()
(c-set-style "k&r")))
;; ;;把C++语言风格设置为stroustrup风格
(add-hook 'c++-mode-hook
'(lambda()
(c-set-style "stroustrup")))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;C/C++设定;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;; ;;;;缩进策略 
(defun my-indent-or-complete () 
  (interactive) 
  (if (looking-at "\\>") 
      (hippie-expand nil) 
    (indent-for-tab-command))) 
;;按键定义 
(define-key c-mode-base-map [(return)] 'newline-and-indent)  
(define-key c-mode-base-map [(meta \`)] 'c-indent-command) 

(defun indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (save-excursion
    (if (region-active-p)
        (progn
          (indent-region (region-beginning) (region-end))
          (message "Indented selected region."))
      (progn
        (indent-buffer)
        (message "Indented buffer.")))))

(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer) 

;; ;;能把一个代码块缩起来，需要的时候再展开
;;   M-x     hs-minor-mode
;;   C-c @ ESC C-s    show all
;;   C-c @ ESC C-h    hide all
;;   C-c @ C-s        show block
;;   C-c @ C-h        hide block
;;   C-c @ C-c toggle hide/show

;; (load-library "hideshow") 
(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'c++-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook 'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'lisp-mode-hook 'hs-minor-mode)
(add-hook 'scheme-mode-hook 'hs-minor-mode)
(add-hook 'css-mode-hook 'hs-minor-mode)
(add-hook 'html-mode-hook 'hs-minor-mode)
(global-set-key (kbd "C-c C-:") 'hs-show-all);;显示
(global-set-key (kbd "C-c C-\"") 'hs-hide-all);;隐藏

;; ;;输入左边的括号，就会自动补全右边的部分.包括(), "", [] , {} , 等等。
(defun my-common-mode-auto-pair ()
  (interactive)
  (make-local-variable 'skeleton-pair-alist)
  (setq skeleton-pair-alist  '(
    (? ? _ "''")
    (? ? _ """")
    (? ?  _ "()")
    (? ?  _ "[]")
    (?{ \n > _ \n ?} >)))
  (setq skeleton-pair t)
  (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "\'") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "[") 'skeleton-pair-insert-maybe))
(add-hook 'c-mode-hook 'my-common-mode-auto-pair)
(add-hook 'c++-mode-hook 'my-common-mode-auto-pair)
(add-hook 'java-mode-hook 'my-common-mode-auto-pair)
(add-hook 'lisp-mode-hook 'my-common-mode-auto-pair)
(add-hook 'php-mode-hook 'my-common-mode-auto-pair)
;; (add-hook 'python-mode-hook 'my-common-mode-auto-pair)
;; (add-hook 'html-mode-hook 'my-common-mode-auto-pair)
;; (add-hook 'scheme-mode-hook 'my-common-mode-auto-pair)
(add-hook 'css-mode-hook 'my-common-mode-auto-pair)
;; (add-hook 'sql-mode-hook 'my-common-mode-auto-pair)
(add-hook 'emacs-lisp-mode-hook 'my-common-mode-auto-pair)
;; (add-hook 'text-mode-hook 'my-common-mode-auto-pair)

(setq x-select-enable-clipboard t);支持emacs和外部程序的粘贴 
(setq frame-title-format '("Emacs@ " buffer-file-name " " ));在标题栏显示buffer名称 
 

;; ;;设置home键指向buffer开头，end键指向buffer结尾
(global-set-key [home] 'beginning-of-buffer)
(global-set-key [end] 'end-of-buffer)
(setq default-fill-column 80);;把 fill-column 设为 80. 这样的文字更好读

;; ;; 实现程序变量得自动对齐
(require 'align)
(global-set-key "\C-x\C-j" 'align)

;; ;鼠标滚轮，默认的滚动太快，这里改为3行 
;; (defun up-slightly () (interactive) (scroll-up 1)) 
;; (defun down-slightly () (interactive) (scroll-down 1)) 
;; (global-set-key [mouse-4] 'down-slightly) 
;; (global-set-key [mouse-5] 'up-slightly) 
(add-to-list 'load-path "/usr/share/emacs/site-lisp/xcscope.el")
(require 'xcscope)
;;自动补全 yasnippet
(add-to-list 'load-path "~/.emacs.d/plugins")
(require 'yasnippet-bundle)
(add-to-list 'load-path "~/.emacs.d/plugins/wcy-swbuff.el");;加载wcy-swbuff
(require 'wcy-swbuff)
;; then you can use <C-tab> and <C-S-kp-tab> to switch buffer.
 (global-set-key (kbd "<C-tab>") 'wcy-switch-buffer-forward);;设置C-TAB为切换BUFFER
 (global-set-key (kbd "<C-S-kp-tab>") 'wcy-switch-buffer-backward)
(setq wcy-switch-buffer-active-buffer-face  'highlight)
(setq wcy-switch-buffer-inactive-buffer-face  'secondary-selection )
;; ;;=================================
;; (require 'psvn)
;; ;;;;;多窗口GDB
;; (load-library "multi-gud.el")
;; (load-library "multi-gdb-ui.el")
;; (setq gdb-many-windows t)
;; (require 'recentf)
;; (defun recentf-open-files-compl ()
;;   (interactive)
;;   (let* ((all-files recentf-list)
;; 	 (tocpl (mapcar (function 
;; 			 (lambda (x) (cons (file-name-nondirectory x) x))) all-files))
;; 	 (prompt (append '("File name: ") tocpl))
;; 	 (fname (completing-read (car prompt) (cdr prompt) nil nil)))
;;     (find-file (cdr (assoc-ignore-representation fname tocpl))))) 

;; (global-set-key [(control x)(control r)] 'recentf-open-files-compl)
;; (require 'util)
;; ;;(require 'thumbs)
;; ;; 把文件或buffer彩色输出成html
;; (require 'htmlize) 
;; ;; 高亮当前行
;; (load "hl-line-settings")

;; (autoload 'table-insert "table" "WYGIWYS table editor")

;;全屏 
(defun my-fullscreen () 
  (interactive) 
  (x-send-client-message 
   nil 0 nil "_NET_WM_STATE" 32 
   '(2 "_NET_WM_STATE_FULLSCREEN" 0))) 

;最大化 
(defun my-maximized () 
  (interactive) 
  (x-send-client-message 
   nil 0 nil "_NET_WM_STATE" 32 
   '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)) 
  (x-send-client-message 
   nil 0 nil "_NET_WM_STATE" 32 
   '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))) 

;; ;; 启动emacs时窗口最大化 
(when window-system
  (my-maximized))

;; ;; 启动窗口大小 
(when window-system
(setq default-frame-alist 
'((height . 33) (width . 158) (menu-bar-lines . 20) (tool-bar-lines . 0))))

;; Enable haml model
(require 'haml-mode)
(add-hook 'haml-mode-hook
               (lambda ()
                 (setq indent-tabs-mode nil)
                 (define-key haml-mode-map "\C-m" 'newline-and-indent)))

;; ;;;;;;;;;;;;我的 Common Lisp;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (add-to-list 'load-path "~/lisp/src/slime/")
;; (add-to-list 'load-path "~/lisp/src/slime/contrib")

;; (require 'slime)
;; (slime-setup '(slime-fancy slime-asdf slime-tramp))

;; (setq inferior-lisp-program "/usr/bin/sbcl --noinform"
;;       lisp-indent-function 'common-lisp-indent-function ;lisp-indent-function
;;       slime-complete-symbol-function 'slime-fuzzy-complete-symbol
;;       slime-net-coding-system 'utf-8-unix
;;       slime-startup-animation t
;;       slime-default-lisp 'sbcl
;;       slime-enable-evaluate-in-emacs nil
;;       slime-log-events t
;;       slime-outline-mode-in-events-buffer nil
;;       ;;slime-repl-return-behaviour :send-only-if-after-complete
;;       slime-autodoc-use-multiline-p t
;;       slime-use-autodoc-mode t
;;       slime-highlight-compiler-notes t
;;       slime-fuzzy-completion-in-place nil)
;; (global-set-key [f4] 'slime);F4进入Slime
;; (defun lisp-indent-or-complete (&optional arg)
;;   (interactive "p")
;;   (if (or (looking-back "^\\s-*") (bolp))
;;       (call-interactively 'lisp-indent-line)
;;       (call-interactively 'slime-indent-and-complete-symbol)))


;; (eval-after-load "lisp-mode"
;;   '(progn
;;     (define-key lisp-mode-map (kbd "TAB") 'lisp-indent-or-complete)))


;; ;;;;;;;;;;;;;;;;;;;;;;代码跳转;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (global-set-key [f8] 'semantic-ia-fast-jump)
;; (global-set-key [S-f8]
;;                 (lambda ()
;;                   (interactive)
;;                   (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
;;                       (error "Semantic Bookmark ring is currently empty"))
;;                   (let* ((ring (oref semantic-mru-bookmark-ring ring))
;;                          (alist (semantic-mrub-ring-to-assoc-list ring))
;;                          (first (cdr (car alist))))
;; 		    (if (semantic-equivalent-tag-p (oref first tag)
;;                                                    (semantic-current-tag))
;;                         (setq first (cdr (car (cdr alist)))))
;;                     (semantic-mrub-switch-tags first))))
;; (define-key c-mode-base-map [M-f1] 'semantic-analyze-proto-impl-toggle)

;;;;;;;;;;;;;;;;;;可视化书签;;;;;;;;;;;;;;;;;;;;;;;;;;
; (enable-visual-studio-bookmarks)
;;;;;h/cpp切换;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'eassist nil 'noerror)
;; (define-key c-mode-base-map [M-f12] 'eassist-switch-h-cpp)
;; (setq eassist-header-switches
;;       '(("h" . ("cpp" "cxx" "c++" "CC" "cc" "C" "c" "mm" "m"))
;;         ("hh" . ("cc" "CC" "cpp" "cxx" "c++" "C"))
;;         ("hpp" . ("cpp" "cxx" "c++" "cc" "CC" "C"))
;;         ("hxx" . ("cxx" "cpp" "c++" "cc" "CC" "C"))
;;         ("h++" . ("c++" "cpp" "cxx" "cc" "CC" "C"))
;;         ("H" . ("C" "CC" "cc" "cpp" "cxx" "c++" "mm" "m"))
;;         ("HH" . ("CC" "cc" "C" "cpp" "cxx" "c++"))
;;         ("cpp" . ("hpp" "hxx" "h++" "HH" "hh" "H" "h"))
;;         ("cxx" . ("hxx" "hpp" "h++" "HH" "hh" "H" "h"))
;;         ("c++" . ("h++" "hpp" "hxx" "HH" "hh" "H" "h"))
;;         ("CC" . ("HH" "hh" "hpp" "hxx" "h++" "H" "h"))
;;         ("cc" . ("hh" "HH" "hpp" "hxx" "h++" "H" "h"))
;;         ("C" . ("hpp" "hxx" "h++" "HH" "hh" "H" "h"))
;;         ("c" . ("h"))
;;         ("m" . ("h"))
;;         ("mm" . ("h"))))

;; ;;;F12 u 更新当前版本
;; (global-set-key (kbd "C-u") 'vc-next-action) 

;; auto detect and display languages
(require 'unicad)

;; emms setup 
(require 'emms-setup)
          (emms-all)
          (emms-default-players)
;; add flv and ogv
(define-emms-simple-player mplayer '(file url)
      (regexp-opt '(".ogg" ".mp3" ".wav" ".mpg" ".mpeg" ".wmv" ".wma"
                    ".mov" ".avi" ".divx" ".ogm" ".asf" ".mkv" "http://" "mms://"
                    ".rm" ".rmvb" ".mp4" ".flac" ".vob" ".m4a" ".flv" ".ogv" ".pls"))
      "mplayer" "-slave" "-quiet" "-really-quiet" "-fullscreen")

(require 'w3m-load)
(require 'mime-w3m)
(add-hook 'w3m-mode-hook
	  (lambda ()
	    (setq w3m-new-session-in-background t)
	    (setq-local mouse-1-click-follows-link nil)
	    (local-set-key [backspace] #'w3m-view-previous-page)
	    (local-set-key (kbd "<C-tab>") #'w3m-next-buffer)
	    (local-set-key [mouse-1] #'w3m-mouse-view-this-url)
	    (local-set-key [mouse-2] #'w3m-mouse-view-this-url-new-session)))

;; load emms-get-lyrics.el to show lyrics
(require 'emms-get-lyrics)

;; customize setting for Auctex
; (setq TeX-auto-save t)
(load-file "~/.emacs.d/auto-complete-auctex/auto-complete-auctex.el")
;(setq TeX-parse-self t)
;(setq-default TeX-master nil)
;; Set pdflatex
(setq TeX-PDF-mode t)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
;; ;; auto-complete math symbols
;; (add-to-list 'load-path "~/.emacs.d/ac-math")
;; (require 'ac-math)
;; (add-to-list 'ac-modes 'latex-mode)   ; make auto-complete aware of `latex-mode`
;; (defun ac-latex-mode-setup ()         ; add ac-sources to default ac-sources
;;   (setq ac-sources
;;      (append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
;;                ac-sources)))
;; (add-hook 'latex-mode-hook 'ac-latex-mode-setup)
;; (ac-flyspell-workaround)

;; roslaunch highlighting
(add-to-list 'auto-mode-alist '("\\.launch$" . xml-mode))


;; Julia Mode
(require 'julia-mode)
;; ESS not working 
;; (add-to-list 'load-path "~/.emacs.d/ESS/lisp/ess-site")
;; (setq inferior-julia-program-name "path/to/julia/julia")
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
)
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
)


