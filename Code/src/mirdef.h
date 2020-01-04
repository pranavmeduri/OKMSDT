#define MIRACL 32
#define MR_LITTLE_ENDIAN /* This may need to be changed */
#define mr_utype int
/* the underlying type is usually int *
* but see mrmuldv.any */
#define mr_unsign32 unsigned int
/* 32 bit unsigned type */
#define MR_IBITS 32 /* bits in int */
#define MR_LBITS 32 /* bits in long */
#define MR_FLASH 52
#define mr_dltype __int64 /* ... or long long for Unix/Linux */
#define mr_unsign64 unsigned __int64
#define MAXBASE ((mr_small)1<<(MIRACL-1))
