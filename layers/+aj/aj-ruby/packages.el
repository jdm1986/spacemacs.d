;;; packages.el --- aj-ruby layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Aaron Jensen <aaronjensen@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;;; Code:

(defconst aj-ruby-packages
  '(ruby-mode
    ruby-test-mode))

(defun aj-ruby/post-init-ruby-mode ()
  (add-hook 'ruby-mode-hook #'aj-ruby/rubocop-set-flycheck-executable))

(defun aj-ruby/post-init-ruby-test-mode ()
  ;; Disable screenshot inlining, which slows emacs down and doesn't work
  (setenv "RAILS_SYSTEM_TESTING_SCREENSHOT" "simple")

  (with-eval-after-load 'compile
    (add-to-list 'compilation-error-regexp-alist 'screenshot-link)
    (add-to-list 'compilation-error-regexp-alist-alist
                 '(screenshot-link "\\[Screenshot\\]: \\(.*\\)$" 1 2)))
  (with-eval-after-load 'ruby-test-mode
    (advice-add 'ruby-test-run-at-point :before (lambda (&rest r) (save-buffer)))
    (advice-add 'ruby-test-run :before (lambda (&rest r) (save-buffer))))
  (setq ruby-test-rspec-options '()))
;;; packages.el ends here
