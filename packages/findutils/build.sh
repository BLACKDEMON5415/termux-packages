TERMUX_PKG_HOMEPAGE=https://www.gnu.org/software/findutils/
TERMUX_PKG_DESCRIPTION="Utilities to find files meeting specified criteria and perform various actions on the files which are found"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_VERSION=4.7.0
TERMUX_PKG_REVISION=2
TERMUX_PKG_SRCURL=https://mirrors.kernel.org/gnu/findutils/findutils-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=c5fefbdf9858f7e4feb86f036e1247a54c79fc2d8e4b7064d5aaa1f47dfa789a
TERMUX_PKG_DEPENDS="libandroid-support"
TERMUX_PKG_ESSENTIAL=true

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
gl_cv_func_fflush_stdin=yes
SORT_SUPPORTS_Z=yes
SORT=$TERMUX_PREFIX/bin/sort
"

# Remove locale and updatedb which in Termux is provided by mlocate:
TERMUX_PKG_RM_AFTER_INSTALL="
bin/locate
bin/updatedb
share/man/man1/locate.1
share/man/man1/updatedb.1
share/man/man5/locatedb.5
"

termux_step_pre_configure() {
	# This is needed for find to implement support for the
	# -fstype parameter by parsing /proc/self/mountinfo:
	CPPFLAGS+=" -DMOUNTED_GETMNTENT1=1"
}
