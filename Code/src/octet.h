#ifndef OCTET_H
#define OCTET_H
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
/* portable representation of a big positive number */
typedef struct
{
int len;
int max;
char *val;
} octet;
/* Octet string handlers */
extern void OCTET_OUTPUT(octet *);
extern void OCTET_OUTPUT_STRING(octet *);
extern void OCTET_CLEAR(octet *);
extern int OCTET_COMPARE(octet *,octet *);
extern void OCTET_JOIN_STRING(char *,octet *);
extern void OCTET_JOIN_BYTES(char *,int,octet *);
extern void OCTET_JOIN_BYTE(int,int,octet *);
extern void OCTET_JOIN_OCTET(octet *,octet *);
extern void OCTET_XOR(octet *,octet *);
extern void OCTET_EMPTY(octet *);
extern void OCTET_PAD(int,octet *);
extern void OCTET_TO_BASE64(octet *,char *);
extern void OCTET_FROM_BASE64(char *,octet *);
extern void OCTET_COPY(octet *,octet *);
extern void OCTET_XOR_BYTE(int,octet *);
extern void OCTET_CHOP(octet *,int,octet *);
extern void OCTET_JOIN_LONG(long,int,octet *);
#endif
