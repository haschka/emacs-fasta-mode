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
	  (line_count_for_exit 0)
	  (seq_name nil)
	  (line_start_pos nil)
	  (line_end_pos nil))
      (if (< 1 (point))
	  (progn
	    (save-excursion
	      (while (and
		      (and (eq nil (char-equal begin_char (string-to-char ">")))
			   (< 1 (point)))
		      (> 10000 line_count_for_exit)) 
		(setq count (+ count (- orig (point))))
		(setq orig (point))
		(move-beginning-of-line 1)
		(setq line_count_for_exit (+ line_count_for_exit 1))
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
	      (setq seq_name (buffer-substring-no-properties
			      (+ line_start_pos 1)
			      line_end_pos))))
	    (if (eq line_count_for_exit 10000)
		(setq local-position
		      (list "...try M-x fasta-manual-position"))
	      (setq local-position
		    (list "SeqPos: " (number-to-string count) " " seq_name))))
	
	(setq local-position
	      (list "SeqPos: unk ")))
      
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

(defun fasta-manual-position ()
  (interactive)
  (when (eq major-mode 'fasta-mode)
    (let ((count 0)
	  (orig (point))
	  (begin_char (string-to-char "0"))
	  (local_position nil)
	  (seq_name nil)
	  (line_start_pos nil)
	  (line_end_pos nil))
      (if (< 1 (point))
	  (progn
	    (save-excursion
	      (while (and (eq nil (char-equal begin_char (string-to-char ">")))
			  (< 1 (point)))
		
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
	    
	    (setq seq_name (buffer-substring-no-properties
			    (+ line_start_pos 1)
			    line_end_pos)))
	    (message "Sequence: %s Position: %d" seq_name count))
	(message "No position for here")))))
      
(provide 'fasta-manual-position)



