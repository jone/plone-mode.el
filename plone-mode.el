;;; plone-mode.el --- Tools for developing plone / zope / python with emacs.

;; Copyright (C) 2011 Jonas Baumann

;; Author: Jonas Baumann, http://github.com/jone
;; URL: http://github.com/jone/plone-mode.el
;; Version: 0.1
;; Created: 13 February 2011
;; Keywords: emacs plone zope python

;; This file is NOT part of GNU Emacs.

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
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

(require 'json)

;;;; custom

(defgroup plone-mode nil
  "plone-mode customization"
  :group 'applications)

(defcustom plone-zope-instance-paths "bin/instance
bin/instance0
bin/instanceadm
bin/instance1"
  "Zope instance paths relative to buildout root."
  :type 'string
  :group 'plone-mode)



;;;; funs

(defun plone--find-parent-with-file (path filename)
  "Traverse PATH upwards until we find FILENAME in the dir.

If we find it return the path of that dir, othwise nil is
returned."
  (if (file-exists-p (concat path "/" filename))
      path
    (let ((parent-dir (file-name-directory (directory-file-name path))))
      ;; Make sure we do not go into infinite recursion
      (if (string-equal path parent-dir)
          nil
        (plone--find-parent-with-file parent-dir filename)))))


(defun plone--find-buildout-root (path)
  "Search PATH for a buildout root.

If a buildout root is found return the path, othwise return
nil."
  ;; find the most top one, not the first one
  (let* ((dir default-directory)
         (previous dir))
    (while (not (equalp dir nil))
      (setq dir (find-parent-with-file dir "bootstrap.py"))
      (if (not (equalp dir nil))
          (progn
            (setq previous dir)
            ;; get parent dir
            (setq dir (file-name-directory (directory-file-name dir))))))
    (message (concat "Found buildout at: " previous))
    previous))


(defun plone-run-zope-foreground ()
  "Run zope serer in foreground."
  (interactive)

  (let ((buildout-directory (plone--find-buildout-root default-directory))
        (instances (split-string plone-zope-instance-paths "\n")))

    (while instances
      (let ((path (concat buildout-directory (car instances))))
        (when (file-exists-p path)
          (pdb (concat path " fg"))
          (setq instances nil)))
      (setq instances (cdr instances)))))

;;;; keymap

(defvar plone-mode-map ()
  "Keymap for plone-mode.")

(if plone-mode-map ()
  (setq plone-mode-map (make-sparse-keymap))
  (define-prefix-command 'plone-mode 'plone-map)
  (define-key plone-mode-map (kbd "M-p") plone-map)

  (define-key plone-mode-map (kbd "M-p f") 'plone-run-zope-foreground))

;;;; mode

(define-minor-mode plone-mode
  "Toggle mrsd mode."
  :global t
  :keymap plone-mode-map
  :lighter " Plone")


(provide 'plone-mode)
