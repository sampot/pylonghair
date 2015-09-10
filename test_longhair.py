# -*- coding: utf-8 -*-
from __future__ import (absolute_import, division, unicode_literals)

import os
import unittest
from pylonghair import fec_encode, fec_decode


class TestLonghair(unittest.TestCase):
    data = os.urandom(1000000)

    def test_fec_encode(self):
        block_size = 8192
        k = 10
        m = 4
        data = os.urandom(k * block_size)
        parity = bytearray(m * block_size)
        assert fec_encode(k, m, block_size, data, parity) == 0

    def test_fec_decode_without_erasure(self):
        block_size = 8192
        k = 10
        m = 4
        data = os.urandom(k * block_size)
        parity = bytearray(m * block_size)
        assert fec_encode(k, m, block_size, data, parity) == 0

        blocks = []
        for row in range(k):
            offset = row * block_size
            block_data = data[offset:offset + block_size]
            blocks.append((row, block_data))
        assert fec_decode(k, m, block_size, blocks) == 0

    def test_fec_decode_without_sufficient_blocks(self):
        block_size = 8192
        k = 10
        m = 4
        data = os.urandom(k * block_size)
        parity = bytearray(m * block_size)
        assert parity == b'\x00' * (m * block_size)
        # print("original data:%r" % data[9 * block_size:9 * block_size + block_size])
        assert fec_encode(k, m, block_size, data, parity) == 0
        # print("parity data:%r" % parity[:block_size])

        blocks = []
        for row in range(k-1):
            offset = row * block_size
            block_data = data[offset:offset + block_size]
            blocks.append((row, block_data))

        blocks.append((k, bytearray(parity[:block_size])))
        assert fec_decode(k, m, block_size, blocks) == 0
        offset = (k-1) * block_size
        assert blocks[(k-1)][1] == data[offset:offset + block_size]
        # print('%r' % blocks[(k-1)][1])

if __name__ == '__main__':
    unittest.main()