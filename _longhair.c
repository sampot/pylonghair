/*
 * functions for wrapping C/C++ codes.
 */
#include "_longhair.h"
#include "native/cauchy_256.h"


int _fec_encode(int k, int m, int block_size, unsigned char* data, unsigned char* parity)
{
    const unsigned char *data_ptrs[256];
    int ii;
	for (ii = 0; ii < k; ++ii) {
		data_ptrs[ii] = data + ii * block_size;
	}

    return cauchy_256_encode(k, m, data_ptrs, parity, block_size);
}

