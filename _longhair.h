#ifndef __HELPERS_H__
#define __HELPERS_H__

#ifdef __cplusplus
extern "C" {
#endif

int _fec_encode(int k, int m, int block_size, unsigned char* data, unsigned char* parity);

#ifdef __cplusplus
}
#endif


#endif /* __HELPERS_H__ */
