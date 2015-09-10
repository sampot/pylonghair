
from libc.stdlib cimport malloc, free
from cpython.buffer cimport PyBUF_SIMPLE
from cpython.buffer cimport Py_buffer
from cpython.buffer cimport PyObject_CheckBuffer
from cpython.buffer cimport PyObject_GetBuffer
from cpython.buffer cimport PyBuffer_Release


assert _cauchy_256_init(2) == 0

def fec_encode(int k, int m, int block_size, object data_blocks, object coding_blocks):
    cdef Py_buffer data_buf, parity_buf
    cdef unsigned char* data
    cdef unsigned char* parity
    cdef const unsigned char *data_ptrs[256]
    cdef int ii

    if not PyObject_CheckBuffer(data_blocks):
        raise TypeError(b'Buffer object expected.')

    try:
        PyObject_GetBuffer(data_blocks, &data_buf, PyBUF_SIMPLE)
        PyObject_GetBuffer(coding_blocks, &parity_buf, PyBUF_SIMPLE)
        data = <unsigned char*> data_buf.buf
        parity = <unsigned char*> parity_buf.buf

        for ii in range(k):
            data_ptrs[ii] = data + ii * block_size

        return cauchy_256_encode(k, m, data_ptrs, parity, block_size)
    finally:
        PyBuffer_Release(&data_buf)
        PyBuffer_Release(&parity_buf)


def fec_decode(int k, int m, int block_size, list blocks):
    cdef int i
    cdef int row
    cdef object buf
    cdef Block *_blocks = <Block *>malloc(k * sizeof(Block))
    cdef Py_buffer buf_objs[255]

    if not _blocks:
        raise MemoryError()

    try:
        for i in range(len(blocks)):
            row, buf = blocks[i]
            PyObject_GetBuffer(buf, &buf_objs[i], PyBUF_SIMPLE)
            _blocks[i].row = row
            _blocks[i].data = <unsigned char*> buf_objs[i].buf
        return cauchy_256_decode(k, m, _blocks, block_size)
    finally:
        free(_blocks)
        for ii in range(len(blocks)):
            PyBuffer_Release(&buf_objs[ii])


