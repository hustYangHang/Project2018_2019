/*
 * =====================================================================================
 *       Filename:  read_timestamp.c
 *
 *    Description:  read timestamp for matlab 
 *        Version:  1.0
 *
 *         Author:  Shengkai Zhang
 *         Email :  <shengkai.zhang@gmail.com>
 *   Organization:  Wei's group @ Huazhong University of Science and Technology
 *
 *   Copyright (c)  Wei's group @ Huazhong University of Science and Technology
 * =====================================================================================
 */
#include "mex.h"
#include <stdint.h>

#define BITS_PER_BYTE 8
#define BITS_PER_SYMBOL      10

bool is_big_endian(){
    unsigned int a = 0x1;
    unsigned char b = *(unsigned char *)&a;
    if ( b == 0)
    {
        return true;
    }
    return false;
}

void mexFunction(int nlhs, mxArray *plhs[],
            int nrhs, const mxArray *prhs[])
{
    unsigned char *buf_addr;
    const mwSize size[]  = {1};
    mxArray *tstamp  = mxCreateNumericArray(1, size, mxUINT64_CLASS, mxREAL);
    uint64_t * ptr =(uint64_t *)mxGetPr(tstamp);
    int i;
    
    /*  check for proper number of arguments */
    if(nrhs!=1) {
        mexErrMsgIdAndTxt("MIMOToolbox:read_csi_new:nrhs","Four input required.");
    }
    if(nlhs!=1) {
        mexErrMsgIdAndTxt("MIMOToolbox:read_csi_new:nlhs","One output required.");
    }
    /*  make sure the input argument is a char array */
    if (!mxIsClass(prhs[0], "uint8")) {
        mexErrMsgIdAndTxt("MIMOToolbox:read_csi_new:notBytes","Input must be a char array");
    }
  
    buf_addr = mxGetData(prhs[0]);
    
    if (is_big_endian()){
//        printf("Big endian\n");
        *ptr  =   
            ((uint64_t) buf_addr[0] << 56) | ((uint64_t) buf_addr[1] << 48) | 
            ((uint64_t) buf_addr[2] << 40) | ((uint64_t) buf_addr[3] << 32) | 
            ((uint64_t) buf_addr[4] << 24) | ((uint64_t) buf_addr[5] << 16) | 
            ((uint64_t) buf_addr[6] << 8)  | ((uint64_t) buf_addr[7]);
//        printf("ptr value %d\n", *ptr);
    }else{
//        printf("Little endian\n");
        *ptr  =   
            ((uint64_t) buf_addr[7] << 56) | ((uint64_t) buf_addr[6] << 48) | 
            ((uint64_t) buf_addr[5] << 40) | ((uint64_t) buf_addr[4] << 32) | 
            ((uint64_t) buf_addr[3] << 24) | ((uint64_t) buf_addr[2] << 16) | 
            ((uint64_t) buf_addr[1] << 8) | ((uint64_t) buf_addr[0]);
//        printf("ptr value %d\n", *ptr);
    }
    plhs[0] = tstamp;
}

