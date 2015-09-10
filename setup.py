# -*- coding: utf-8 -*-

from setuptools import setup, find_packages, Extension
from Cython.Build import cythonize


extensions = [
    Extension("pylonghair",
              ["pylonghair.pyx",
               "_longhair.c",
               "native/cauchy_256.cpp",
               "native/MemSwap.cpp",
               "native/MemXOR.cpp",
               ],
              language="c++"),
]


setup(
    name="pylonghair",
    version='0.1.0',
    description="Erasure code for Python",
    # package_dir={'': ''},
    packages=find_packages(exclude=['**/tests/*']),
    include_package_data=True,

    zip_safe=False,

    ext_modules=cythonize(extensions),

    author="Sam Kuo",
    url="https://samkuo.me",

)