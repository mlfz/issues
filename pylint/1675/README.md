Reproduction:

```pytb
No config file found, using default configuration
No config file found, using default configuration
************* Module pkga.pylint_error
E:  2, 0: No name 'FOO' in module 'pkga.pkgb' (no-name-in-module)
^ ^ ^ ^ ^
pylint is incorrectly trying to import from module pkga.pkgb.
NOTE the same error does not appear for the next line in the same file, which uses `from pkgb import *` wildcard import.

No config file found, using default configuration
^ ^ ^ ^ ^
OK if we are not using the do-nothing plugin.

No config file found, using default configuration
^ ^ ^ ^ ^
OK also if pkgb is not namespaced.

/home/mlfzhang/Projects/pylint/pylint/1675/pkga/pkga/__init__.pyc
/home/mlfzhang/Projects/pylint/pylint/1675/pkgb-ns/pkgb/__init__.py
running develop
Removing /home/mlfzhang/.virtualenv/m3d/lib/python2.7/site-packages/Package-A.egg-link (link to .)
Removing Package-A 0.0.0 from easy-install.pth file
running develop
Removing /home/mlfzhang/.virtualenv/m3d/lib/python2.7/site-packages/Package-B.egg-link (link to .)
Removing Package-B 0.0.0 from easy-install.pth file
```
