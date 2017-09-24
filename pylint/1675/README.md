Reproduction:

```
Traceback (most recent call last):
  File "/home/mlfzhang/.virtualenv/m3d/bin/pylint", line 11, in <module>
    load_entry_point('pylint', 'console_scripts', 'pylint')()
  File "/home/mlfzhang/.virtualenv/m3d/local/lib/python2.7/site-packages/pylint/__init__.py", line 13, in run_pylint
    Run(sys.argv[1:])
  File "/home/mlfzhang/.virtualenv/m3d/local/lib/python2.7/site-packages/pylint/lint.py", line 1265, in __init__
    linter.load_plugin_modules(plugins)
  File "/home/mlfzhang/.virtualenv/m3d/local/lib/python2.7/site-packages/pylint/lint.py", line 468, in load_plugin_modules
    module = modutils.load_module_from_name(modname)
  File "/home/mlfzhang/.virtualenv/m3d/local/lib/python2.7/site-packages/astroid/modutils.py", line 190, in load_module_from_name
    return load_module_from_modpath(dotted_name.split('.'), path, use_sys)
  File "/home/mlfzhang/.virtualenv/m3d/local/lib/python2.7/site-packages/astroid/modutils.py", line 232, in load_module_from_modpath
    mp_file, mp_filename, mp_desc = imp.find_module(part, path)
ImportError: No module named pkga
Failed with ImportError. This is expected.\n\n\n
************* Module pkga.a
E:  1, 0: No name 'FOO' in module 'pkga.pkgb' (no-name-in-module)
Not sure why pylint is trying parse module pkga.pkgb\n\n\n
No config file found, using default configuration
It does not do this when not using the plug in.
Or when pkgb is not namespaced
Or when the import in pkga/a.py uses from pkgb import *, see pkga/b.py
/home/mlfzhang/Projects/pylint/pylint/1675/pkga/pkga/__init__.pyc
/home/mlfzhang/Projects/pylint/pylint/1675/pkgb-ns/pkgb/__init__.pyc
```


