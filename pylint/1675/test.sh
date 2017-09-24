#!/bin/bash

set -x

uninstall () {
	rm -f $VIRTUAL_ENV/lib/python2.7/site-package/Package-{A,B}*.egg-link # remove egg-links
	sed -i -e '/pylint\/pkga/d' -e '/pylint\/pkgb-ns/d' /home/mlfzhang/.virtualenv/m3d/lib/python2.7/site-packages/easy-install.pth
}

uninstall

pylint --rcfile=pylintrc --errors-only pkga/pkga # fails with ImportError, expected

# install editable
{
	( cd pkga ; python setup.py develop )
	( cd pkgb-ns; python setup.py develop )
} > /dev/null

pylint --rcfile=pylintrc --errors-only pkga/pkga # fail
( cd pkga; pylint --errors-only pkga ) # OK if we do not use the astng_transform
# also does not fail if
# pkgb is not namespaced.
# the import in pkga.a uses wildcard, e.g. from pkgb import *

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
