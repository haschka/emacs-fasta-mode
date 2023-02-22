        (add-to-list 'load-path "@SITELISP@")
        (add-to-list 'auto-mode-alist '("\.fasta\'" . fasta-mode))
        (autoload 'fasta-mode "Fasta" "Major mode for editing FASTA files." t)
