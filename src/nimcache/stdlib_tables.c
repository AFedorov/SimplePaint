/* Generated by Nim Compiler v0.13.0 */
/*   (c) 2015 Andreas Rumpf */
/* The generated code is subject to the original license. */
/* Compiled for: Windows, amd64, gcc */
/* Command for C compiler:
   gcc.exe -c  -w -g3 -O0  -IC:\Nim\lib -o y:\nimcode\simplepaint\src\nimcache\stdlib_tables.o y:\nimcode\simplepaint\src\nimcache\stdlib_tables.c */
#define NIM_INTBITS 64

#include "nimbase.h"
typedef struct NimStringDesc NimStringDesc;
typedef struct TGenericSeq TGenericSeq;
typedef struct Table206320 Table206320;
typedef struct Keyvaluepairseq206323 Keyvaluepairseq206323;
typedef struct Keyvaluepair206326 Keyvaluepair206326;
typedef struct TNimType TNimType;
typedef struct TNimNode TNimNode;
struct  TGenericSeq  {NI len;
NI reserved;
};
struct  NimStringDesc  {  TGenericSeq Sup;NIM_CHAR data[SEQ_DECL_SIZE];
};
struct  Table206320  {Keyvaluepairseq206323* data;
NI counter;
};
struct Keyvaluepair206326 {
NI Field0;
NI64 Field1;
void* Field2;
};
typedef N_NIMCALL_PTR(void, TY3489) (void* p, NI op);
typedef N_NIMCALL_PTR(void*, TY3494) (void* p);
struct  TNimType  {NI size;
NU8 kind;
NU8 flags;
TNimType* base;
TNimNode* node;
void* finalizer;
TY3489 marker;
TY3494 deepcopy;
};
struct  TNimNode  {NU8 kind;
NI offset;
TNimType* typ;
NCSTRING name;
NI len;
TNimNode** sons;
};
struct Keyvaluepairseq206323 {  TGenericSeq Sup;  Keyvaluepair206326 data[SEQ_DECL_SIZE];};
#line 14 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
static N_INLINE(NIM_BOOL, isempty_202259)(NI hcode);
#line 303 "c:\\nim\\lib\\system\\excpt.nim"
static N_INLINE(void, nimFrame)(TFrame* s);
#line 298 "c:\\nim\\lib\\system\\excpt.nim"
N_NOINLINE(void, stackoverflow_22201)(void);
#line 49 "c:\\nim\\lib\\system\\excpt.nim"
static N_INLINE(void, popFrame)(void);
#line 17 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
static N_INLINE(NIM_BOOL, isfilled_202263)(NI hcode);
#line 23 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
static N_INLINE(NIM_BOOL, mustrehash_202268)(NI length, NI counter);
#line 3329 "c:\\nim\\lib\\system.nim"
N_NIMCALL(void, failedassertimpl_90316)(NimStringDesc* msg);
#line 372 "c:\\nim\\lib\\system\\arithm.nim"
N_NIMCALL(NI, mulInt)(NI a, NI b);
#line 326 "c:\\nim\\lib\\system\\arithm.nim"
static N_INLINE(NI, subInt)(NI a, NI b);
#line 13 "c:\\nim\\lib\\system\\arithm.nim"
N_NOINLINE(void, raiseOverflow)(void);
#line 27 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
static N_INLINE(NI, nexttry_202401)(NI h, NI maxhash);
#line 319 "c:\\nim\\lib\\system\\arithm.nim"
static N_INLINE(NI, addInt)(NI a, NI b);
#line 88 "c:\\nim\\lib\\pure\\collections\\tables.nim"
static N_INLINE(NI, rightsize_202532)(NI count);
#line 94 "c:\\nim\\lib\\pure\\math.nim"
N_NIMCALL(NI, nextpoweroftwo_195627)(NI x);
#line 338 "c:\\nim\\lib\\system\\arithm.nim"
static N_INLINE(NI, divInt)(NI a, NI b);
#line 17 "c:\\nim\\lib\\system\\arithm.nim"
N_NOINLINE(void, raiseDivByZero)(void);
#line 68 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
static N_INLINE(NI, rawget_206636)(Table206320 t, NI64 key, NI* hc);
#line 111 "c:\\nim\\lib\\pure\\hashes.nim"
static N_INLINE(NI, hash_160805)(NI64 x);
#line 18 "c:\\nim\\lib\\system\\chcks.nim"
N_NOINLINE(void, raiseIndexError)(void);
#line 186 "c:\\nim\\lib\\pure\\collections\\tables.nim"
N_NIMCALL(void, enlarge_206708)(Table206320* t);
#line 30 "c:\\nim\\lib\\system\\chcks.nim"
static N_INLINE(NI, chckRange)(NI i, NI a, NI b);
#line 12 "c:\\nim\\lib\\system\\chcks.nim"
N_NOINLINE(void, raiseRangeError)(NI64 val);N_NIMCALL(void, TMP1063)(void* p, NI op);

#line 473 "c:\\nim\\lib\\system\\gc.nim"
N_NIMCALL(void*, newSeq)(TNimType* typ, NI len);
#line 273 "c:\\nim\\lib\\system\\gc.nim"
N_NIMCALL(void, unsureAsgnRef)(void** dest, void* src);
#line 62 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
static N_INLINE(NI, rawgetknownhc_206761)(Table206320 t, NI64 key, NI hc);
#line 71 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
N_NIMCALL(void, rawinsert_206777)(Table206320* t, Keyvaluepairseq206323** data, NI64 key, void* val, NI hc, NI h);STRING_LITERAL(TMP1022, "\015\012  counter < length ", 21);
extern TFrame* frameptr_19436;
TNimType NTI206326; /* KeyValuePair */
extern TNimType NTI160002; /* Hash */
extern TNimType NTI7088; /* BiggestInt */
extern TNimType NTI142; /* pointer */
TNimType NTI206323; /* KeyValuePairSeq */


#line 303 "c:\\nim\\lib\\system\\excpt.nim"
static N_INLINE(void, nimFrame)(TFrame* s) {
	NI LOC1;
#line 304 "c:\\nim\\lib\\system\\excpt.nim"
	LOC1 = 0;
#line 304 "c:\\nim\\lib\\system\\excpt.nim"
	{
#line 304 "c:\\nim\\lib\\system\\excpt.nim"
		if (!(frameptr_19436 == NIM_NIL)) goto LA4;
		LOC1 = ((NI) 0);	}
	goto LA2;
	LA4: ;
	{
#line 304 "c:\\nim\\lib\\system\\excpt.nim"
		LOC1 = ((NI) ((NI16)((*frameptr_19436).calldepth + ((NI16) 1))));	}
	LA2: ;
	(*s).calldepth = ((NI16) (LOC1));
#line 305 "c:\\nim\\lib\\system\\excpt.nim"
	(*s).prev = frameptr_19436;
#line 306 "c:\\nim\\lib\\system\\excpt.nim"
	frameptr_19436 = s;
#line 307 "c:\\nim\\lib\\system\\excpt.nim"
	{
#line 307 "c:\\nim\\lib\\system\\excpt.nim"
		if (!((*s).calldepth == ((NI16) 2000))) goto LA9;

#line 307 "c:\\nim\\lib\\system\\excpt.nim"
		stackoverflow_22201();
	}
	LA9: ;
}


#line 49 "c:\\nim\\lib\\system\\excpt.nim"
static N_INLINE(void, popFrame)(void) {

#line 50 "c:\\nim\\lib\\system\\excpt.nim"
	frameptr_19436 = (*frameptr_19436).prev;}


#line 14 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
static N_INLINE(NIM_BOOL, isempty_202259)(NI hcode) {
	NIM_BOOL result;
	nimfr("isEmpty", "tableimpl.nim")
	result = 0;
#line 15 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
	nimln(15, "tableimpl.nim");
#line 15 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
	result = (hcode == ((NI) 0));	popFrame();	return result;}


#line 17 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
static N_INLINE(NIM_BOOL, isfilled_202263)(NI hcode) {
	NIM_BOOL result;
	nimfr("isFilled", "tableimpl.nim")
	result = 0;
#line 18 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
	nimln(18, "tableimpl.nim");
#line 349 "c:\\nim\\lib\\system.nim"
	nimln(349, "system.nim");
#line 349 "c:\\nim\\lib\\system.nim"
	result = !((hcode == ((NI) 0)));	popFrame();	return result;}


#line 326 "c:\\nim\\lib\\system\\arithm.nim"
static N_INLINE(NI, subInt)(NI a, NI b) {
	NI result;
{	result = 0;
#line 327 "c:\\nim\\lib\\system\\arithm.nim"

#line 327 "c:\\nim\\lib\\system\\arithm.nim"
	result = (NI)((NU64)(a) - (NU64)(b));
#line 328 "c:\\nim\\lib\\system\\arithm.nim"
	{		NIM_BOOL LOC3;
#line 328 "c:\\nim\\lib\\system\\arithm.nim"
		LOC3 = 0;
#line 353 "c:\\nim\\lib\\system.nim"

#line 328 "c:\\nim\\lib\\system\\arithm.nim"
		LOC3 = (((NI) 0) <= (NI)(result ^ a));		if (LOC3) goto LA4;

#line 353 "c:\\nim\\lib\\system.nim"

#line 328 "c:\\nim\\lib\\system\\arithm.nim"

#line 328 "c:\\nim\\lib\\system\\arithm.nim"
		LOC3 = (((NI) 0) <= (NI)(result ^ (NI)((NU64) ~(b))));		LA4: ;
		if (!LOC3) goto LA5;

#line 329 "c:\\nim\\lib\\system\\arithm.nim"
		goto BeforeRet;
	}
	LA5: ;

#line 330 "c:\\nim\\lib\\system\\arithm.nim"
	raiseOverflow();
	}BeforeRet: ;
	return result;}


#line 23 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
static N_INLINE(NIM_BOOL, mustrehash_202268)(NI length, NI counter) {
	NIM_BOOL result;
	NIM_BOOL LOC5;	NI TMP1023;	NI TMP1024;	NI TMP1025;	nimfr("mustRehash", "tableimpl.nim")
	result = 0;
#line 24 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
	nimln(24, "tableimpl.nim");	{
#line 24 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"

#line 24 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
		if (!!((counter < length))) goto LA3;

#line 24 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
		failedassertimpl_90316(((NimStringDesc*) &TMP1022));
	}
	LA3: ;

#line 25 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
	nimln(25, "tableimpl.nim");
#line 25 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
	LOC5 = 0;
#line 25 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"

#line 25 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
	TMP1023 = mulInt(length, ((NI) 2));
#line 25 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
	TMP1024 = mulInt(counter, ((NI) 3));	LOC5 = ((NI)(TMP1023) < (NI)(TMP1024));	if (LOC5) goto LA6;

#line 25 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"

#line 25 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
	TMP1025 = subInt(length, counter);	LOC5 = ((NI)(TMP1025) < ((NI) 4));	LA6: ;
	result = LOC5;	popFrame();	return result;}


#line 319 "c:\\nim\\lib\\system\\arithm.nim"
static N_INLINE(NI, addInt)(NI a, NI b) {
	NI result;
{	result = 0;
#line 320 "c:\\nim\\lib\\system\\arithm.nim"

#line 320 "c:\\nim\\lib\\system\\arithm.nim"
	result = (NI)((NU64)(a) + (NU64)(b));
#line 321 "c:\\nim\\lib\\system\\arithm.nim"
	{		NIM_BOOL LOC3;
#line 321 "c:\\nim\\lib\\system\\arithm.nim"
		LOC3 = 0;
#line 353 "c:\\nim\\lib\\system.nim"

#line 321 "c:\\nim\\lib\\system\\arithm.nim"
		LOC3 = (((NI) 0) <= (NI)(result ^ a));		if (LOC3) goto LA4;

#line 353 "c:\\nim\\lib\\system.nim"

#line 321 "c:\\nim\\lib\\system\\arithm.nim"
		LOC3 = (((NI) 0) <= (NI)(result ^ b));		LA4: ;
		if (!LOC3) goto LA5;

#line 322 "c:\\nim\\lib\\system\\arithm.nim"
		goto BeforeRet;
	}
	LA5: ;

#line 323 "c:\\nim\\lib\\system\\arithm.nim"
	raiseOverflow();
	}BeforeRet: ;
	return result;}


#line 27 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
static N_INLINE(NI, nexttry_202401)(NI h, NI maxhash) {
	NI result;
	NI TMP1026;	nimfr("nextTry", "tableimpl.nim")
	result = 0;
#line 28 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
	nimln(28, "tableimpl.nim");
#line 28 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"

#line 28 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
	TMP1026 = addInt(h, ((NI) 1));	result = (NI)((NI)(TMP1026) & maxhash);	popFrame();	return result;}


#line 338 "c:\\nim\\lib\\system\\arithm.nim"
static N_INLINE(NI, divInt)(NI a, NI b) {
	NI result;
{	result = 0;
#line 339 "c:\\nim\\lib\\system\\arithm.nim"
	{
#line 339 "c:\\nim\\lib\\system\\arithm.nim"
		if (!(b == ((NI) 0))) goto LA3;

#line 340 "c:\\nim\\lib\\system\\arithm.nim"
		raiseDivByZero();
	}
	LA3: ;

#line 341 "c:\\nim\\lib\\system\\arithm.nim"
	{		NIM_BOOL LOC7;
#line 341 "c:\\nim\\lib\\system\\arithm.nim"
		LOC7 = 0;
#line 341 "c:\\nim\\lib\\system\\arithm.nim"
		LOC7 = (a == ((NI) (IL64(-9223372036854775807) - IL64(1))));		if (!(LOC7)) goto LA8;

#line 341 "c:\\nim\\lib\\system\\arithm.nim"
		LOC7 = (b == ((NI) -1));		LA8: ;
		if (!LOC7) goto LA9;

#line 342 "c:\\nim\\lib\\system\\arithm.nim"
		raiseOverflow();
	}
	LA9: ;

#line 343 "c:\\nim\\lib\\system\\arithm.nim"

#line 343 "c:\\nim\\lib\\system\\arithm.nim"

#line 343 "c:\\nim\\lib\\system\\arithm.nim"
	result = (NI)(a / b);	goto BeforeRet;
	}BeforeRet: ;
	return result;}


#line 88 "c:\\nim\\lib\\pure\\collections\\tables.nim"
static N_INLINE(NI, rightsize_202532)(NI count) {
	NI result;
	NI TMP1027;	NI TMP1028;	NI TMP1029;	nimfr("rightSize", "tables.nim")
	result = 0;
#line 95 "c:\\nim\\lib\\pure\\collections\\tables.nim"
	nimln(95, "tables.nim");
#line 95 "c:\\nim\\lib\\pure\\collections\\tables.nim"

#line 95 "c:\\nim\\lib\\pure\\collections\\tables.nim"

#line 95 "c:\\nim\\lib\\pure\\collections\\tables.nim"
	TMP1027 = mulInt(((NI) (count)), ((NI) 3));	TMP1028 = divInt(((NI) ((NI)(TMP1027))), ((NI) 2));	TMP1029 = addInt(((NI) ((NI)(TMP1028))), ((NI) 4));	result = nextpoweroftwo_195627(((NI) ((NI)(TMP1029))));	popFrame();	return result;}


#line 111 "c:\\nim\\lib\\pure\\hashes.nim"
static N_INLINE(NI, hash_160805)(NI64 x) {
	NI result;
	nimfr("hash", "hashes.nim")
	result = 0;
#line 113 "c:\\nim\\lib\\pure\\hashes.nim"
	nimln(113, "hashes.nim");
#line 113 "c:\\nim\\lib\\pure\\hashes.nim"
	result = ((NI) (((NI32)(NU32)(NU64)(x))));	popFrame();	return result;}


#line 68 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
static N_INLINE(NI, rawget_206636)(Table206320 t, NI64 key, NI* hc) {
	NI result;
	NI h;
	NI TMP1058;	nimfr("rawGet", "tableimpl.nim")
{	result = 0;
#line 43 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
	nimln(43, "tableimpl.nim");	(*hc) = hash_160805(key);
#line 44 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
	nimln(44, "tableimpl.nim");	{
#line 44 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
		if (!((*hc) == ((NI) 0))) goto LA3;

#line 45 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
		nimln(45, "tableimpl.nim");		(*hc) = ((NI) 314159265);	}
	LA3: ;

#line 31 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
	nimln(31, "tableimpl.nim");
#line 31 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"

#line 83 "c:\\nim\\lib\\pure\\collections\\tables.nim"
	nimln(83, "tables.nim");	h = (NI)((*hc) & (t.data ? (t.data->Sup.len-1) : -1));	{
#line 32 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
		nimln(32, "tableimpl.nim");		while (1) {			NIM_BOOL LOC7;
#line 32 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
			if ((NU)(h) >= (NU)(t.data->Sup.len)) raiseIndexError();			LOC7 = 0;			LOC7 = isfilled_202263(t.data->data[h].Field0);			if (!LOC7) goto LA6;

#line 37 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
			nimln(37, "tableimpl.nim");			{				NIM_BOOL LOC10;
#line 37 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
				LOC10 = 0;
#line 37 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
				if ((NU)(h) >= (NU)(t.data->Sup.len)) raiseIndexError();				LOC10 = (t.data->data[h].Field0 == (*hc));				if (!(LOC10)) goto LA11;

#line 37 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
				if ((NU)(h) >= (NU)(t.data->Sup.len)) raiseIndexError();				LOC10 = (t.data->data[h].Field1 == key);				LA11: ;
				if (!LOC10) goto LA12;

#line 38 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
				nimln(38, "tableimpl.nim");
#line 38 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
				result = h;				goto BeforeRet;
			}
			LA12: ;

#line 39 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
			nimln(39, "tableimpl.nim");
#line 83 "c:\\nim\\lib\\pure\\collections\\tables.nim"
			nimln(83, "tables.nim");			h = nexttry_202401(h, (t.data ? (t.data->Sup.len-1) : -1));		} LA6: ;	}

#line 40 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
	nimln(40, "tableimpl.nim");
#line 40 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
	TMP1058 = subInt(((NI) -1), h);	result = (NI)(TMP1058);	}BeforeRet: ;
	popFrame();	return result;}


#line 137 "c:\\nim\\lib\\pure\\collections\\tables.nim"
N_NIMCALL(void*, getordefault_206621)(Table206320 t, NI64 key) {
	void* result;
	NI hc_206632;
	NI index_206634;
	nimfr("getOrDefault", "tables.nim")
	result = 0;	hc_206632 = 0;
#line 117 "c:\\nim\\lib\\pure\\collections\\tables.nim"
	nimln(117, "tables.nim");	index_206634 = rawget_206636(t, key, (&hc_206632));
#line 118 "c:\\nim\\lib\\pure\\collections\\tables.nim"
	nimln(118, "tables.nim");	{
#line 353 "c:\\nim\\lib\\system.nim"
		nimln(353, "system.nim");		if (!(((NI) 0) <= index_206634)) goto LA3;

#line 118 "c:\\nim\\lib\\pure\\collections\\tables.nim"
		nimln(118, "tables.nim");		if ((NU)(index_206634) >= (NU)(t.data->Sup.len)) raiseIndexError();		result = t.data->data[index_206634].Field2;	}
	LA3: ;
	popFrame();	return result;}


#line 30 "c:\\nim\\lib\\system\\chcks.nim"
static N_INLINE(NI, chckRange)(NI i, NI a, NI b) {
	NI result;
{	result = 0;
#line 31 "c:\\nim\\lib\\system\\chcks.nim"
	{		NIM_BOOL LOC3;
#line 31 "c:\\nim\\lib\\system\\chcks.nim"
		LOC3 = 0;
#line 353 "c:\\nim\\lib\\system.nim"
		LOC3 = (a <= i);		if (!(LOC3)) goto LA4;

#line 31 "c:\\nim\\lib\\system\\chcks.nim"
		LOC3 = (i <= b);		LA4: ;
		if (!LOC3) goto LA5;

#line 32 "c:\\nim\\lib\\system\\chcks.nim"

#line 32 "c:\\nim\\lib\\system\\chcks.nim"
		result = i;		goto BeforeRet;
	}
	goto LA1;
	LA5: ;
	{
#line 34 "c:\\nim\\lib\\system\\chcks.nim"
		raiseRangeError(((NI64) (i)));
	}
	LA1: ;
	}BeforeRet: ;
	return result;}
N_NIMCALL(void, TMP1063)(void* p, NI op) {
	Keyvaluepairseq206323* a;
	NI LOC1;	a = (Keyvaluepairseq206323*)p;
	LOC1 = 0;	for (LOC1 = 0; LOC1 < a->Sup.len; LOC1++) {
	}
}


#line 62 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
static N_INLINE(NI, rawgetknownhc_206761)(Table206320 t, NI64 key, NI hc) {
	NI result;
	NI h;
	NI TMP1064;	nimfr("rawGetKnownHC", "tableimpl.nim")
{	result = 0;
#line 31 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
	nimln(31, "tableimpl.nim");
#line 31 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"

#line 83 "c:\\nim\\lib\\pure\\collections\\tables.nim"
	nimln(83, "tables.nim");	h = (NI)(hc & (t.data ? (t.data->Sup.len-1) : -1));	{
#line 32 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
		nimln(32, "tableimpl.nim");		while (1) {			NIM_BOOL LOC3;
#line 32 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
			if ((NU)(h) >= (NU)(t.data->Sup.len)) raiseIndexError();			LOC3 = 0;			LOC3 = isfilled_202263(t.data->data[h].Field0);			if (!LOC3) goto LA2;

#line 37 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
			nimln(37, "tableimpl.nim");			{				NIM_BOOL LOC6;
#line 37 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
				LOC6 = 0;
#line 37 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
				if ((NU)(h) >= (NU)(t.data->Sup.len)) raiseIndexError();				LOC6 = (t.data->data[h].Field0 == hc);				if (!(LOC6)) goto LA7;

#line 37 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
				if ((NU)(h) >= (NU)(t.data->Sup.len)) raiseIndexError();				LOC6 = (t.data->data[h].Field1 == key);				LA7: ;
				if (!LOC6) goto LA8;

#line 38 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
				nimln(38, "tableimpl.nim");
#line 38 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
				result = h;				goto BeforeRet;
			}
			LA8: ;

#line 39 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
			nimln(39, "tableimpl.nim");
#line 83 "c:\\nim\\lib\\pure\\collections\\tables.nim"
			nimln(83, "tables.nim");			h = nexttry_202401(h, (t.data ? (t.data->Sup.len-1) : -1));		} LA2: ;	}

#line 40 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
	nimln(40, "tableimpl.nim");
#line 40 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
	TMP1064 = subInt(((NI) -1), h);	result = (NI)(TMP1064);	}BeforeRet: ;
	popFrame();	return result;}


#line 71 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
N_NIMCALL(void, rawinsert_206777)(Table206320* t, Keyvaluepairseq206323** data, NI64 key, void* val, NI hc, NI h) {
	nimfr("rawInsert", "tableimpl.nim")

#line 58 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
	nimln(58, "tableimpl.nim");	if ((NU)(h) >= (NU)((*data)->Sup.len)) raiseIndexError();	(*data)->data[h].Field1 = key;
#line 59 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
	nimln(59, "tableimpl.nim");	if ((NU)(h) >= (NU)((*data)->Sup.len)) raiseIndexError();	(*data)->data[h].Field2 = val;
#line 60 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
	nimln(60, "tableimpl.nim");	if ((NU)(h) >= (NU)((*data)->Sup.len)) raiseIndexError();	(*data)->data[h].Field0 = hc;	popFrame();}


#line 186 "c:\\nim\\lib\\pure\\collections\\tables.nim"
N_NIMCALL(void, enlarge_206708)(Table206320* t) {
	Keyvaluepairseq206323* n;
	NI TMP1061;	Keyvaluepairseq206323* LOC1;	nimfr("enlarge", "tables.nim")
	n = 0;
#line 188 "c:\\nim\\lib\\pure\\collections\\tables.nim"
	nimln(188, "tables.nim");
#line 188 "c:\\nim\\lib\\pure\\collections\\tables.nim"

#line 188 "c:\\nim\\lib\\pure\\collections\\tables.nim"
	TMP1061 = mulInt(((*t).data ? (*t).data->Sup.len : 0), ((NI) 2));	n = (Keyvaluepairseq206323*) newSeq((&NTI206323), ((NI)chckRange((NI)(TMP1061), ((NI) 0), ((NI) IL64(9223372036854775807)))));
#line 189 "c:\\nim\\lib\\pure\\collections\\tables.nim"
	nimln(189, "tables.nim");	LOC1 = 0;	LOC1 = (*t).data;	unsureAsgnRef((void**) (&(*t).data), n);	n = LOC1;	{		NI i_206759;
		NI HEX3Atmp_206800;
		NI res_206803;
		i_206759 = 0;		HEX3Atmp_206800 = 0;
#line 190 "c:\\nim\\lib\\pure\\collections\\tables.nim"
		nimln(190, "tables.nim");
#line 190 "c:\\nim\\lib\\pure\\collections\\tables.nim"
		HEX3Atmp_206800 = (n ? (n->Sup.len-1) : -1);
#line 1874 "c:\\nim\\lib\\system.nim"
		nimln(1874, "system.nim");		res_206803 = ((NI) 0);		{
#line 1875 "c:\\nim\\lib\\system.nim"
			nimln(1875, "system.nim");			while (1) {				NI TMP1066;
#line 1875 "c:\\nim\\lib\\system.nim"
				if (!(res_206803 <= HEX3Atmp_206800)) goto LA4;

#line 1876 "c:\\nim\\lib\\system.nim"
				nimln(1876, "system.nim");				i_206759 = res_206803;
#line 191 "c:\\nim\\lib\\pure\\collections\\tables.nim"
				nimln(191, "tables.nim");				{					NIM_BOOL LOC7;					NI j;
					NI LOC10;					NI TMP1065;
#line 191 "c:\\nim\\lib\\pure\\collections\\tables.nim"
					if ((NU)(i_206759) >= (NU)(n->Sup.len)) raiseIndexError();					LOC7 = 0;					LOC7 = isfilled_202263(n->data[i_206759].Field0);					if (!LOC7) goto LA8;

#line 192 "c:\\nim\\lib\\pure\\collections\\tables.nim"
					nimln(192, "tables.nim");
#line 192 "c:\\nim\\lib\\pure\\collections\\tables.nim"

#line 192 "c:\\nim\\lib\\pure\\collections\\tables.nim"
					if ((NU)(i_206759) >= (NU)(n->Sup.len)) raiseIndexError();					if ((NU)(i_206759) >= (NU)(n->Sup.len)) raiseIndexError();					LOC10 = 0;					LOC10 = rawgetknownhc_206761((*t), n->data[i_206759].Field1, n->data[i_206759].Field0);					TMP1065 = subInt(((NI) -1), LOC10);					j = (NI)(TMP1065);
#line 193 "c:\\nim\\lib\\pure\\collections\\tables.nim"
					nimln(193, "tables.nim");					if ((NU)(i_206759) >= (NU)(n->Sup.len)) raiseIndexError();					if ((NU)(i_206759) >= (NU)(n->Sup.len)) raiseIndexError();					if ((NU)(i_206759) >= (NU)(n->Sup.len)) raiseIndexError();					rawinsert_206777(t, (&(*t).data), n->data[i_206759].Field1, n->data[i_206759].Field2, n->data[i_206759].Field0, j);
				}
				LA8: ;

#line 1890 "c:\\nim\\lib\\system.nim"
				nimln(1890, "system.nim");				TMP1066 = addInt(res_206803, ((NI) 1));				res_206803 = (NI)(TMP1066);			} LA4: ;		}
	}
	popFrame();}


#line 204 "c:\\nim\\lib\\pure\\collections\\tables.nim"
N_NIMCALL(void, HEX5BHEX5DHEX3D_206672)(Table206320* t, NI64 key, void* val) {
	NI hc;
	NI index;
	nimfr("[]=", "tables.nim")
	hc = 0;
#line 92 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
	nimln(92, "tableimpl.nim");	index = rawget_206636((*t), key, (&hc));
#line 93 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
	nimln(93, "tableimpl.nim");	{
#line 353 "c:\\nim\\lib\\system.nim"
		nimln(353, "system.nim");		if (!(((NI) 0) <= index)) goto LA3;

#line 93 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
		nimln(93, "tableimpl.nim");		if ((NU)(index) >= (NU)((*t).data->Sup.len)) raiseIndexError();		(*t).data->data[index].Field2 = val;	}
	goto LA1;
	LA3: ;
	{		NI TMP1067;		NI TMP1068;
#line 83 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
		nimln(83, "tableimpl.nim");		{			NIM_BOOL LOC8;
#line 83 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"

#line 84 "c:\\nim\\lib\\pure\\collections\\tables.nim"
			nimln(84, "tables.nim");			LOC8 = 0;			LOC8 = mustrehash_202268(((*t).data ? (*t).data->Sup.len : 0), (*t).counter);			if (!LOC8) goto LA9;

#line 84 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
			nimln(84, "tableimpl.nim");			enlarge_206708(t);

#line 85 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
			nimln(85, "tableimpl.nim");			index = rawgetknownhc_206761((*t), key, hc);		}
		LA9: ;

#line 86 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
		nimln(86, "tableimpl.nim");
#line 86 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
		TMP1067 = subInt(((NI) -1), index);		index = (NI)(TMP1067);
#line 87 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
		nimln(87, "tableimpl.nim");		rawinsert_206777(t, (&(*t).data), key, val, hc, index);

#line 88 "c:\\nim\\lib\\pure\\collections\\tableimpl.nim"
		nimln(88, "tableimpl.nim");		TMP1068 = addInt((*t).counter, ((NI) 1));		(*t).counter = (NI)(TMP1068);	}
	LA1: ;
	popFrame();}
NIM_EXTERNC N_NOINLINE(void, stdlib_tablesInit000)(void) {
	nimfr("tables", "tables.nim")
	popFrame();}

NIM_EXTERNC N_NOINLINE(void, stdlib_tablesDatInit000)(void) {
static TNimNode* TMP1062[3];
static TNimNode TMP1020[4];NTI206326.size = sizeof(Keyvaluepair206326);
NTI206326.kind = 18;
NTI206326.base = 0;
NTI206326.flags = 3;
TMP1062[0] = &TMP1020[1];
TMP1020[1].kind = 1;
TMP1020[1].offset = offsetof(Keyvaluepair206326, Field0);
TMP1020[1].typ = (&NTI160002);
TMP1020[1].name = "Field0";
TMP1062[1] = &TMP1020[2];
TMP1020[2].kind = 1;
TMP1020[2].offset = offsetof(Keyvaluepair206326, Field1);
TMP1020[2].typ = (&NTI7088);
TMP1020[2].name = "Field1";
TMP1062[2] = &TMP1020[3];
TMP1020[3].kind = 1;
TMP1020[3].offset = offsetof(Keyvaluepair206326, Field2);
TMP1020[3].typ = (&NTI142);
TMP1020[3].name = "Field2";
TMP1020[0].len = 3; TMP1020[0].kind = 2; TMP1020[0].sons = &TMP1062[0];
NTI206326.node = &TMP1020[0];
NTI206323.size = sizeof(Keyvaluepairseq206323*);
NTI206323.kind = 24;
NTI206323.base = (&NTI206326);
NTI206323.flags = 2;
NTI206323.marker = TMP1063;
}
