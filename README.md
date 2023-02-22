# emacs-fasta-mode
A mode for fasta files

Allows you to find the current sequence-position and sequence-name from a fasta file in 
the modeline of emacs, which shall be super helpful for editing a fasta file with emacs. 

Maybe once later I will add a go to sequence + position command. 

### How to use this

Open `fasta-mode.el` in emacs and run `M-x eval-buffer`. You can now
open a fasta file and run `M-x fasta-mode` and should get the 
sequence position at the current cursor position as well as the 
current sequence name written out in your mode-line

You can probably add this in all kinds of ways to your emacs installation, 
using your `.emacs` file or in other ways. 

Gentoo users can make use the supplied `fasta-mode-1.ebuild` to install this
on their system.


