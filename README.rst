PyLonghair
===================

The wrapper of `Longhair <https://github.com/catid/longhair>` for Python.


Dependencies
--------------------

* Cython 0.22+

Build
--------------------

Run following command:

.. code-block:: bash

    python setup.py build_ext --inplace

Test
-----------------

.. code-block::

    python test_longhair.py

API
-----------

Two functions are provided to encode and to decode data using Cauchy Reed-solomon algorithm.

- fec_encode

- fec_decode



Credits
--------------
Longhair was written entirely by `Christopher A. Taylor <mrcatid@gmail.com>`_.
All credits go to him.