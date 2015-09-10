cdef extern from "native/cauchy_256.h":
    struct _Block:
        unsigned char *data
        unsigned char row
    ctypedef _Block Block

    extern int _cauchy_256_init(int expected_version)
    extern int cauchy_256_encode(int k, int m, const unsigned char *data_ptrs[], void *recovery_blocks, int block_bytes)
    extern int cauchy_256_decode(int k, int m, Block *blocks, int block_bytes)

cdef extern from "_longhair.h":
    extern int _fec_encode(int k, int m, int block_size, unsigned char* data, unsigned char* parity)


