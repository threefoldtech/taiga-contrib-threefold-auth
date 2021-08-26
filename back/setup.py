#!/usr/bin/env python
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#



import versiontools_support
from setuptools import setup, find_packages

setup(
    name = 'taiga-contrib-threefold-auth-official',
    version = ":versiontools:taiga_contrib_threefold_auth:",
    description = "The Taiga plugin for threefold authentication",
    long_description = "",
    keywords = 'taiga, threefold, auth, plugin',
    author = 'Sameh Abouelsaad',
    author_email = 'samehabouelsaad@gmail.com',
    url = 'https://github.com/kaleidos-ventures/taiga-contrib-gitlab-auth',
    license = 'MPL 2.0',
    include_package_data = True,
    packages = find_packages(),
    install_requires=[
        'pynacl == 1.4.0',
    ],
    setup_requires = [
        'versiontools >= 1.9',
    ],
    classifiers = [
        "Programming Language :: Python",
        'Development Status :: 4 - Beta',
        'Framework :: Django',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: Mozilla Public License 2.0 (MPL 2.0)',
        'Operating System :: OS Independent',
        'Programming Language :: Python',
        'Topic :: Internet :: WWW/HTTP',
    ]
)
