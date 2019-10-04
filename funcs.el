(defun tl-javascript/setup-tide-company ()
  "Setup tide auto-completion."
  (spacemacs|add-company-backends
    :backends company-tide
    :modes js-mode
    :variables company-minimum-prefix-length 2)
  (company-mode)
  )

(defun tl-javascript//locate-npm-executable (name)
  (let* ((node-module-path (concat "node_modules/.bin/" name))
         (dir (locate-dominating-file buffer-file-name node-module-path)))
    (if dir
        (concat dir node-module-path)
      (executable-find name))))

(defun tl-javascript/set-prettier-command ()
  (interactive)
  (when-let* ((executable (tl-javascript//locate-npm-executable "prettier")))
    (setq-local prettier-js-command executable)))

(defun tl-javascript/javascript-format ()
  "Call formatting tool specified in `javascript-fmt-tool'."
  (interactive)
  (cond
   ((eq javascript-fmt-tool 'prettier)
    (call-interactively 'prettier-js))
   (t (error (concat "%s isn't valid javascript-fmt-tool value."
                     " It should be 'web-beutify or 'prettier.")
             (symbol-name javascript-fmt-tool)))))
