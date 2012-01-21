;;; prelude-ui.el --- Emacs Prelude: UI optimizations and tweaks.
;;
;; Copyright (c) 2011 Bozhidar Batsov
;;
;; Author: Bozhidar Batsov <bozhidar.batsov@gmail.com>
;; URL: http://www.emacswiki.org/cgi-bin/wiki/Prelude
;; Version: 1.0.0
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:

;; We dispense with most of the point and click UI, reduce the startup noise,
;; configure smooth scolling and a nice theme that's easy on the eyes (zenburn).

;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

;; the toolbar is just a waste of valuable screen estate
;; in a tty tool-bar-mode does not properly auto-load, and is
;; already disabled anyway
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
;; the menu bar is mostly useless as well
(if window-system (menu-bar-mode 1))
;; OSX
(if (eq system-type 'darwin)
    (setq mac-allow-anti-aliasing nil)
    (aquamacs-autoface-mode 0)
    (set-default-font " -apple-Monaco-medium-normal-normal-*-10-*-*-*-m-0-fontset-auto1")
)
;; the blinking cursor is nothing, but an annoyance
(blink-cursor-mode -1)

;; disable startup screen
(setq inhibit-startup-screen t)

;; nice scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; mode line settings
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; custom Emacs 24 color themes support
(add-to-list 'custom-theme-load-path (concat prelude-dir "themes/"))

;; use zenburn as the default theme
(load-theme 'adam t)

; Escreen
(load "escreen")
(escreen-install)

;; add C-\ l to list screens with emphase for current one
;; http://blog.tapoueh.org/news.dim.html#%20Escreen%20integration
(defun escreen-get-active-screen-numbers-with-emphasis ()
   "what the name says"
   (interactive)
   (let ((escreens (escreen-get-active-screen-numbers))
         (emphased ""))

     (dolist (s escreens)
       (setq emphased
             (concat emphased (if (= escreen-current-screen-number s)
                                  (propertize (number-to-string s)
                                              ;;'face 'custom-variable-tag) " ")
                                              'face 'info-title-3)
                                              ;;'face 'font-lock-warning-face)
                                              ;;'face 'secondary-selection)
                                (number-to-string s))
                     " ")))
     (message "escreen: active screens: %s" emphased)))



; Show approx buffer size in modeline
(if (fboundp 'size-indication-mode)
    (size-indication-mode))

; Make URLs in comments/strings clickable
(if (fboundp 'goto-address-prog-mode)
    (add-hook 'find-file-hooks 'goto-address-prog-mode))

(provide 'prelude-ui)
;;; prelude-ui.el ends here
