from setuptools import setup, find_packages

if __name__ == '__main__':
    setup(
        name = 'Package-B',
        namespace_packages = ['pkgb'],
        packages = find_packages()
        )

