from setuptools import setup, find_packages
import io

import httpshare


setup(
    name='httpshare',

    version='%(major)d.%(minor)d.%(patch)d' % httpshare.version_info._asdict(),

    description='Q&D file transfer utility using an ephemeral HTTP service',
    long_description=io.open('README.rst', encoding='utf-8').read(),

    # The project's main homepage.
    url='https://github.com/bbjubjub2494/httpshare/tree/pypi',

    # Author details
    author='Julie Bettens',
    author_email='julie@bettens.info',

    # Choose your license
    license='zlib',

    classifiers=[
        'Environment :: Console',
        'Intended Audience :: End Users/Desktop',
        'Topic :: Software Development :: Build Tools',

        'License :: OSI Approved :: zlib/libpng License',

        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3.3',
        'Programming Language :: Python :: 3.4',
        'Programming Language :: Python :: 3.5',
        'Programming Language :: Python :: 3.6',

        'Topic :: Communications :: File Sharing',
        'Topic :: Utilities',
    ],

    keywords='filetransfer',

    packages=['httpshare'],

    package_data={
        'httpshare': ['*.stpl', 'LICENSE.txt'],
    },
    zip_safe=True,  # by design

    install_requires=[
        'bottle==0.12.13',
        'docopt==0.6.2',
        'qrcode==5.3',
    ],
)
