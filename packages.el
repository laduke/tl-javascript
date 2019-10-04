(defconst tl-javascript-packages
  '(
    add-node-modules-path
    eslintd-fix
    json-mode
    flycheck
    company
    tide
    js
    ))

(defun tl-javascript/init-js ()
  (progn
    (add-to-list 'auto-mode-alist '("\\.js\\'" . js-mode))
    (add-to-list 'auto-mode-alist '("\\.jsx\\'" . js-mode))
    (add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))

    (setq js-indent-level 2))

  (spacemacs/set-leader-keys-for-major-mode 'js-mode
    "=" 'tl-javascript/javascript-format)
  )


(defun tl-javascript/init-json-mode ()
  (use-package json-mode :ensure t :defer t)
  )

(defun tl-javascript/pre-init-add-node-modules-path ()
  (add-hook 'js-mode-hook #'add-node-modules-path)
  )

(defun tl-javascript/post-init-flycheck ()
  (spacemacs/enable-flycheck 'js-mode))


(defun tl-javascript/init-tide ()
  (use-package tide
    :ensure t
    :defer
    :after (flycheck)
    :hook ((js-mode . tide-setup)
           (js-mode . tide-hl-identifier-mode)))
  )

(defun tl-javascript/post-init-company ()
  (spacemacs/add-to-hooks #'tl-javascript/setup-tide-company '(js-mode-local-vars-hook)))


(defun tl-javascript/init-eslintd-fix ()
  (use-package eslintd-fix
    :defer t
    :commands eslintd-fix-mode
    :init
    (add-hook 'js-mode-hook #'eslintd-fix-mode t)))


(defun tl-javascript//enable-prettier ()
  "Enable prettier if there is a config and we're not in node_modules"
  (when (and (locate-dominating-file buffer-file-name "prettier.config.js")
             (not (string-match "\/node_modules\/" buffer-file-name)))
    (tl-javascript/set-prettier-command)
    (prettier-js-mode)))
