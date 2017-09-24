Reproduction:

```pytb
running develop
running develop
Traceback (most recent call last):
  File "/home/mlfzhang/.virtualenv/m3d/bin/pylint", line 11, in <module>
    load_entry_point('pylint', 'console_scripts', 'pylint')()
  File "/home/mlfzhang/.virtualenv/m3d/local/lib/python2.7/site-packages/pylint/__init__.py", line 13, in run_pylint
    Run(sys.argv[1:])
  File "/home/mlfzhang/.virtualenv/m3d/local/lib/python2.7/site-packages/pylint/lint.py", line 1222, in __init__
    linter.load_plugin_modules(self._plugins)
  File "/home/mlfzhang/.virtualenv/m3d/local/lib/python2.7/site-packages/pylint/lint.py", line 468, in load_plugin_modules
    module = modutils.load_module_from_name(modname)
  File "/home/mlfzhang/.virtualenv/m3d/local/lib/python2.7/site-packages/astroid/modutils.py", line 190, in load_module_from_name
    return load_module_from_modpath(dotted_name.split('.'), path, use_sys)
  File "/home/mlfzhang/.virtualenv/m3d/local/lib/python2.7/site-packages/astroid/modutils.py", line 232, in load_module_from_modpath
    mp_file, mp_filename, mp_desc = imp.find_module(part, path)
ImportError: No module named pkga
^ ^ ^ ^ ^
Failed with ImportError. This is expected.

No config file found, using default configuration
************* Module pkga.pylint_error
E:  1, 0: No name 'FOO' in module 'pkga.pkgb' (no-name-in-module)
^ ^ ^ ^ ^
pylint is incorrectly trying to import from module pkga.pkgb.
NOTE the same error does not appear for pkga.pylint_ok, which uses from pkgb import * wildcard import.

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
