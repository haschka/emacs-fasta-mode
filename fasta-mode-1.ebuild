# Distributed under the terms of the GNU General Public License v3

EAPI=8

NEED_EMACS=27.1

inherit elisp git-r3 

DESCRIPTION="The pdb2fasta Tool, extracting fasta sequences for proteins in PDB FILES"
HOMEPAGE="https://github.com/haschka/emacs-fasta-mode"
EGIT_REPO_URI="https://github.com/haschka/emacs-fasta-mode.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

BDEPEND="
	>=app-editors/emacs-${NEED_EMACS}
"
RDEPEND="
	${BDEPEND}
"

SITEFILE="50${PN}-gentoo.el"

src_compile() {
        elisp_src_compile
	elisp-make-autoload-file
}

src_install() {
        elisp-install fasta-mode.el fasta-mode.elc
        elisp-site-file-install "${SITEFILE}"
}