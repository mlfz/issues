#!/bin/bash

#set -x
dev_install () {
	{
		# install editable
		( cd pkga ; python setup.py develop )
		( cd pkgb-ns; python setup.py develop )
	} > /dev/null
}
dev_uninstall () {
	# uninstall editable
	( cd pkga ; python setup.py develop --uninstall )
	( cd pkgb-ns; python setup.py develop --uninstall )
}

dev_uninstall

pylint --rcfile=pylintrc --errors-only pkga/pkga # fails with ImportError, expected

cat << EOF
^ ^ ^ ^ ^
Failed with ImportError. This is expected.

EOF

dev_install

pylint --rcfile=pylintrc --errors-only pkga/pkga # fail

cat << EOF
^ ^ ^ ^ ^
pylint is incorrectly trying to import from module pkga.pkgb.
NOTE the same error does not appear for pkga.pylint_ok, which uses from pkgb import * wildcard import.

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
dev_uninstall
