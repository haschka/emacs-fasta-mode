(define-derived-mode fasta-mode fundamental-mode "Fasta"
  "Major mode for editing FASTA files."
  (progn
    (add-hook 'post-command-hook 'position-in-fasta-file)
    (add-hook 'after-change-functions 'position-in-fasta-file)))
    

(provide 'fasta-mode)

(defun position-in-fasta-file ()
  (when (eq major-mode 'fasta-mode)
    (let ((count 0)
	  (orig (point))
	  (begin_char (string-to-char "0"))
	  (local_position nil)
	  (seq_name nil)
	  (line_start_pos nil)
	  (line_end_pos nil))
      (save-excursion
	(while (eq nil (char-equal begin_char (string-to-char ">")))
	  (setq count (+ count (- orig (point))))
	  (setq orig (point))
	  (move-beginning-of-line 1)
	  (if (eq nil (char-after))
	      (setq begin_char (string-to-char "0"))
	    (setq begin_char (char-after)))
	  (if (eq nil (eq 1 (point)))
	      (progn 
		(setq orig (- orig 1))
		(backward-char 1))))
					; fix last line
	(setq count (+ count 1))
	(if (eq nil (eq 1 (point)))
	    (forward-char 1))
	(setq line_start_pos (point))
	(setq line_end_pos (line-end-position))
	(if (< 12 (- line_end_pos line_start_pos))
	    (setq seq_name
		  (concat (buffer-substring-no-properties (+ (point) 1)
							  (+ (point) 11))
			  "..."))
	  (setq seq_name (buffer-substring-no-properties (+ line_start_pos 1)
							 line_end_pos))))
	
      (setq local-position
	    (list "SeqPos: " (number-to-string count) " " seq_name))
      
      (setq mode-line-format
	    '("%e" mode-line-front-space
	      mode-line-mule-info
	      mode-line-client
	      mode-line-modified
	      mode-line-remote
	      mode-line-frame-identification
	      mode-line-buffer-identification
	      local-position
	      (vc-mode vc-mode)
	      mode-line-modes
	      mode-line-misc-info
	      mode-line-end-spaces))
      
      (force-mode-line-update))))
	  
(provide 'position-in-fasta-file)

