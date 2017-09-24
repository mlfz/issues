#!/bin/bash

#set -x

uninstall () {
	rm -f $VIRTUAL_ENV/lib/python2.7/site-package/Package-{A,B}*.egg-link # remove egg-links
	sed -i -e '/\/pylint\//d' /home/mlfzhang/.virtualenv/m3d/lib/python2.7/site-packages/easy-install.pth
}

uninstall

pylint --rcfile=pylintrc --errors-only pkga/pkga # fails with ImportError, expected

printf ">> Failed with ImportError. This is expected.\n\n\n"

# install editable
{
	( cd pkga ; python setup.py develop )
	( cd pkgb-ns; python setup.py develop )
} > /dev/null

pylint --rcfile=pylintrc --errors-only pkga/pkga # fail

cat << EOF
^ ^ ^ ^ ^
pylint is incorrectly trying to import from module pkga.pkg.
NOTE the same error does not appear for pkga.b, which uses from pkgb import * wildcard import.

EOF

( cd pkga; pylint --errors-only pkga ) # OK if we do not use the astng_transform

cat << EOF
^ ^ ^ ^ ^
OK if we are not using the do-nothing plugin.

EOF

sed -e '/\.declare_namespace/d' -i pkgb-ns/pkgb/__init__.py
pylint --rcfile=pylintrc --errors-only pkga/pkga # OK
cat << EOF
^ ^ ^ ^ ^
OK also if pkgb is not namespaced.

EOF
git co -- pkgb-ns/pkgb/__init__.py

# imports are OK
python << EOF

import pkga
print pkga.__file__

import pkgb
print pkgb.__file__

from pkgb import FOO # OK

EOF

# clean up
uninstall
