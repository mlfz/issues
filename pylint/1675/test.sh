#!/bin/bash

#set -x

cleanup () {
	# clean up these packages
	( cd pkga ; python setup.py develop --uninstall )
	( cd pkgb-ns; python setup.py develop --uninstall )
}
trap cleanup EXIT

pylint --errors-only pkga/pkga pkgb-ns/pkgb || cat << EOF
^ ^ ^ ^ ^
Failed with ImportError. This is expected.

EOF

{
	# install editable
	( cd pkga ; python setup.py develop )
	( cd pkgb-ns; python setup.py develop )
} > /dev/null

pylint --load-plugins=pkga.astng_transform --errors-only pkga/pkga pkgb-ns/pkgb # FAIL

cat << EOF
^ ^ ^ ^ ^
pylint is incorrectly trying to import from module pkga.pkgb.
NOTE the same error does not appear for the next line in the same file, which uses \`from pkgb import *\` wildcard import.

EOF

pylint --errors-only pkga/pkga pkgb-ns/pkgb # OK

cat << EOF
^ ^ ^ ^ ^
OK if we are not using the do-nothing plugin.

EOF

sed -e '/\.declare_namespace/d' -i pkgb-ns/pkgb/__init__.py
pylint --rcfile=pylintrc --errors-only pkga/pkga pkgb-ns/pkgb # OK
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
