'''Fix for pylint's hashlib import check; from http://www.logilab.org/blogentry/78354'''
from __future__ import print_function

from astroid import MANAGER, scoped_nodes

def module_transform(module):
    '''DOES NOTHING'''
    pass

def register(linter): # pylint: disable=unused-argument
    """called when loaded by pylint --load-plugins, register our tranformation
    function here
    """
    MANAGER.register_transform(scoped_nodes.Module, module_transform)
