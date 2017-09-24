#!/bin/bash

#set -x

uninstall () {
	rm -f $VIRTUAL_ENV/lib/python2.7/site-package/Package-{A,B}*.egg-link # remove egg-links
	sed -i -e '/\/pylint\//d' /home/mlfzhang/.virtualenv/m3d/lib/python2.7/site-packages/easy-install.pth
}

uninstall

pylint --rcfile=pylintrc --errors-only pkga/pkga # fails with ImportError, expected

echo "Failed with ImportError. This is expected.\n\n\n"

# install editable
{
	( cd pkga ; python setup.py develop )
	( cd pkgb-ns; python setup.py develop )
} > /dev/null

pylint --rcfile=pylintrc --errors-only pkga/pkga # fail
echo "Not sure why pylint is trying parse module pkga.pkgb\n\n\n"

( cd pkga; pylint --errors-only pkga ) # OK if we do not use the astng_transform

cat << EOF
It does not do this when not using the plug in.
Or when pkgb is not namespaced
Or when the import in pkga/a.py uses from pkgb import *, see pkga/b.py
EOF

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
