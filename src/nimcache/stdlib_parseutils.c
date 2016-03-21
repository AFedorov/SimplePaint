/* Generated by Nim Compiler v0.13.1 */
/*   (c) 2015 Andreas Rumpf */
/* The generated code is subject to the original license. */
/* Compiled for: Linux, amd64, gcc */
/* Command for C compiler:
   gcc -c  -w -g3 -O0  -I/home/fedorov_ag/Nim/lib -o /home/fedorov_ag/projects/SimplePaint/src/nimcache/stdlib_parseutils.o /home/fedorov_ag/projects/SimplePaint/src/nimcache/stdlib_parseutils.c */
#define NIM_INTBITS 64

#include "nimbase.h"
typedef struct NimStringDesc NimStringDesc;
typedef struct TGenericSeq TGenericSeq;
typedef struct Overflowerror3640 Overflowerror3640;
typedef struct Arithmeticerror3636 Arithmeticerror3636;
typedef struct Exception Exception;
typedef struct TNimObject TNimObject;
typedef struct TNimType TNimType;
typedef struct TNimNode TNimNode;
typedef struct Cell47905 Cell47905;
typedef struct Cellseq47921 Cellseq47921;
typedef struct Gcheap50218 Gcheap50218;
typedef struct Gcstack50216 Gcstack50216;
typedef struct Cellset47917 Cellset47917;
typedef struct Pagedesc47913 Pagedesc47913;
typedef struct Memregion30088 Memregion30088;
typedef struct Smallchunk30040 Smallchunk30040;
typedef struct Llchunk30082 Llchunk30082;
typedef struct Bigchunk30042 Bigchunk30042;
typedef struct Intset30014 Intset30014;
typedef struct Trunk30010 Trunk30010;
typedef struct Avlnode30086 Avlnode30086;
typedef struct Gcstat50214 Gcstat50214;
typedef struct Basechunk30038 Basechunk30038;
typedef struct Freecell30030 Freecell30030;
struct  TGenericSeq  {NI len;
NI reserved;
};
struct  NimStringDesc  {  TGenericSeq Sup;NIM_CHAR data[SEQ_DECL_SIZE];
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
struct  TNimObject  {TNimType* m_type;};
struct  Exception  {  TNimObject Sup;Exception* parent;
NCSTRING name;
NimStringDesc* message;
NimStringDesc* trace;
};
struct  Arithmeticerror3636  {  Exception Sup;};
struct  Overflowerror3640  {  Arithmeticerror3636 Sup;};
struct  TNimNode  {NU8 kind;
NI offset;
TNimType* typ;
NCSTRING name;
NI len;
TNimNode** sons;
};
struct  Cell47905  {NI refcount;
TNimType* typ;
};
struct  Cellseq47921  {NI len;
NI cap;
Cell47905** d;
};
struct  Cellset47917  {NI counter;
NI max;
Pagedesc47913* head;
Pagedesc47913** data;
};
typedef Smallchunk30040* TY30103[512];
typedef Trunk30010* Trunkbuckets30012[256];
struct  Intset30014  {Trunkbuckets30012 data;
};
struct  Memregion30088  {NI minlargeobj;
NI maxlargeobj;
TY30103 freesmallchunks;
Llchunk30082* llmem;
NI currmem;
NI maxmem;
NI freemem;
NI lastsize;
Bigchunk30042* freechunkslist;
Intset30014 chunkstarts;
Avlnode30086* root;
Avlnode30086* deleted;
Avlnode30086* last;
Avlnode30086* freeavlnodes;
};
struct  Gcstat50214  {NI stackscans;
NI cyclecollections;
NI maxthreshold;
NI maxstacksize;
NI maxstackcells;
NI cycletablesize;
NI64 maxpause;
};
struct  Gcheap50218  {Gcstack50216* stack;
void* stackbottom;
NI cyclethreshold;
Cellseq47921 zct;
Cellseq47921 decstack;
Cellset47917 cycleroots;
Cellseq47921 tempstack;
NI recgclock;
Memregion30088 region;
Gcstat50214 stat;
};
struct  Gcstack50216  {Gcstack50216* prev;
Gcstack50216* next;
void* starts;
void* pos;
NI maxstacksize;
};
typedef NI TY30019[8];
struct  Pagedesc47913  {Pagedesc47913* next;
NI key;
TY30019 bits;
};
struct  Basechunk30038  {NI prevsize;
NI size;
NIM_BOOL used;
};
struct  Smallchunk30040  {  Basechunk30038 Sup;Smallchunk30040* next;
Smallchunk30040* prev;
Freecell30030* freelist;
NI free;
NI acc;
NF data;
};
struct  Llchunk30082  {NI size;
NI acc;
Llchunk30082* next;
};
struct  Bigchunk30042  {  Basechunk30038 Sup;Bigchunk30042* next;
Bigchunk30042* prev;
NI align;
NF data;
};
struct  Trunk30010  {Trunk30010* next;
NI key;
TY30019 bits;
};
typedef Avlnode30086* TY30093[2];
struct  Avlnode30086  {TY30093 link;
NI key;
NI upperbound;
NI level;
};
struct  Freecell30030  {Freecell30030* next;
NI zerofield;
};

#line 213 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
N_NIMCALL(NI, npuParseBiggestInt)(NimStringDesc* s, NI64* number, NI start);
#line 195 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
N_NIMCALL(NI, rawparseint_98927)(NimStringDesc* s, NI64* b, NI start);
#line 18 "/home/fedorov_ag/Nim/lib/system/chcks.nim"
N_NOINLINE(void, raiseIndexError)(void);
#line 319 "/home/fedorov_ag/Nim/lib/system/arithm.nim"
static N_INLINE(NI, addInt)(NI a, NI b);
#line 13 "/home/fedorov_ag/Nim/lib/system/arithm.nim"
N_NOINLINE(void, raiseOverflow)(void);
#line 106 "/home/fedorov_ag/Nim/lib/system/arithm.nim"
N_NIMCALL(NI64, mulInt64)(NI64 a, NI64 b);
#line 326 "/home/fedorov_ag/Nim/lib/system/arithm.nim"
static N_INLINE(NI, subInt)(NI a, NI b);
#line 80 "/home/fedorov_ag/Nim/lib/system/arithm.nim"
static N_INLINE(NI64, subInt64)(NI64 a, NI64 b);
#line 303 "/home/fedorov_ag/Nim/lib/system/excpt.nim"
static N_INLINE(void, nimFrame)(TFrame* s);
#line 298 "/home/fedorov_ag/Nim/lib/system/excpt.nim"
N_NOINLINE(void, stackoverflow_22201)(void);
#line 49 "/home/fedorov_ag/Nim/lib/system/excpt.nim"
static N_INLINE(void, popFrame)(void);
#line 471 "/home/fedorov_ag/Nim/lib/system/gc.nim"
N_NIMCALL(void*, newObj)(TNimType* typ, NI size);
#line 99 "/home/fedorov_ag/Nim/lib/system/sysstr.nim"
N_NIMCALL(NimStringDesc*, copyStringRC1)(NimStringDesc* src);
#line 244 "/home/fedorov_ag/Nim/lib/system/gc.nim"
static N_INLINE(void, nimGCunrefNoCycle)(void* p);
#line 129 "/home/fedorov_ag/Nim/lib/system/gc.nim"
static N_INLINE(Cell47905*, usrtocell_51840)(void* usr);
#line 208 "/home/fedorov_ag/Nim/lib/system/gc.nim"
static N_INLINE(void, rtladdzct_53401)(Cell47905* c);
#line 120 "/home/fedorov_ag/Nim/lib/system/gc.nim"
N_NOINLINE(void, addzct_51817)(Cellseq47921* s, Cell47905* c);
#line 263 "/home/fedorov_ag/Nim/lib/system/excpt.nim"
N_NIMCALL(void, raiseException)(Exception* e, NCSTRING ename);
#line 319 "/home/fedorov_ag/Nim/lib/system/sysstr.nim"
N_NIMCALL(NI, nimParseBiggestFloat)(NimStringDesc* s, NF* number, NI start);
#line 237 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
N_NIMCALL(NI, nimParseBiggestFloat)(NimStringDesc* s, NF* number, NI start);STRING_LITERAL(TMP347, "overflow", 8);
extern TFrame* frameptr_19436;
extern TNimType NTI24269; /* ref OverflowError */
extern TNimType NTI3640; /* OverflowError */
extern Gcheap50218 gch_50259;


#line 319 "/home/fedorov_ag/Nim/lib/system/arithm.nim"
static N_INLINE(NI, addInt)(NI a, NI b) {
	NI result;
{	result = 0;
#line 320 "/home/fedorov_ag/Nim/lib/system/arithm.nim"

#line 320 "/home/fedorov_ag/Nim/lib/system/arithm.nim"
	result = (NI)((NU64)(a) + (NU64)(b));
#line 321 "/home/fedorov_ag/Nim/lib/system/arithm.nim"
	{		NIM_BOOL LOC3;
#line 321 "/home/fedorov_ag/Nim/lib/system/arithm.nim"
		LOC3 = 0;
#line 353 "/home/fedorov_ag/Nim/lib/system.nim"

#line 321 "/home/fedorov_ag/Nim/lib/system/arithm.nim"
		LOC3 = (((NI) 0) <= (NI)(result ^ a));		if (LOC3) goto LA4;

#line 353 "/home/fedorov_ag/Nim/lib/system.nim"

#line 321 "/home/fedorov_ag/Nim/lib/system/arithm.nim"
		LOC3 = (((NI) 0) <= (NI)(result ^ b));		LA4: ;
		if (!LOC3) goto LA5;

#line 322 "/home/fedorov_ag/Nim/lib/system/arithm.nim"
		goto BeforeRet;
	}
	LA5: ;

#line 323 "/home/fedorov_ag/Nim/lib/system/arithm.nim"
	raiseOverflow();
	}BeforeRet: ;
	return result;}


#line 326 "/home/fedorov_ag/Nim/lib/system/arithm.nim"
static N_INLINE(NI, subInt)(NI a, NI b) {
	NI result;
{	result = 0;
#line 327 "/home/fedorov_ag/Nim/lib/system/arithm.nim"

#line 327 "/home/fedorov_ag/Nim/lib/system/arithm.nim"
	result = (NI)((NU64)(a) - (NU64)(b));
#line 328 "/home/fedorov_ag/Nim/lib/system/arithm.nim"
	{		NIM_BOOL LOC3;
#line 328 "/home/fedorov_ag/Nim/lib/system/arithm.nim"
		LOC3 = 0;
#line 353 "/home/fedorov_ag/Nim/lib/system.nim"

#line 328 "/home/fedorov_ag/Nim/lib/system/arithm.nim"
		LOC3 = (((NI) 0) <= (NI)(result ^ a));		if (LOC3) goto LA4;

#line 353 "/home/fedorov_ag/Nim/lib/system.nim"

#line 328 "/home/fedorov_ag/Nim/lib/system/arithm.nim"

#line 328 "/home/fedorov_ag/Nim/lib/system/arithm.nim"
		LOC3 = (((NI) 0) <= (NI)(result ^ (NI)((NU64) ~(b))));		LA4: ;
		if (!LOC3) goto LA5;

#line 329 "/home/fedorov_ag/Nim/lib/system/arithm.nim"
		goto BeforeRet;
	}
	LA5: ;

#line 330 "/home/fedorov_ag/Nim/lib/system/arithm.nim"
	raiseOverflow();
	}BeforeRet: ;
	return result;}


#line 80 "/home/fedorov_ag/Nim/lib/system/arithm.nim"
static N_INLINE(NI64, subInt64)(NI64 a, NI64 b) {
	NI64 result;
{	result = 0;
#line 81 "/home/fedorov_ag/Nim/lib/system/arithm.nim"

#line 81 "/home/fedorov_ag/Nim/lib/system/arithm.nim"
	result = (NI64)((NU64)(a) - (NU64)(b));
#line 82 "/home/fedorov_ag/Nim/lib/system/arithm.nim"
	{		NIM_BOOL LOC3;
#line 82 "/home/fedorov_ag/Nim/lib/system/arithm.nim"
		LOC3 = 0;
#line 353 "/home/fedorov_ag/Nim/lib/system.nim"

#line 82 "/home/fedorov_ag/Nim/lib/system/arithm.nim"
		LOC3 = (IL64(0) <= (NI64)(result ^ a));		if (LOC3) goto LA4;

#line 353 "/home/fedorov_ag/Nim/lib/system.nim"

#line 82 "/home/fedorov_ag/Nim/lib/system/arithm.nim"

#line 82 "/home/fedorov_ag/Nim/lib/system/arithm.nim"
		LOC3 = (IL64(0) <= (NI64)(result ^ (NI64)((NU64) ~(b))));		LA4: ;
		if (!LOC3) goto LA5;

#line 83 "/home/fedorov_ag/Nim/lib/system/arithm.nim"
		goto BeforeRet;
	}
	LA5: ;

#line 84 "/home/fedorov_ag/Nim/lib/system/arithm.nim"
	raiseOverflow();
	}BeforeRet: ;
	return result;}


#line 303 "/home/fedorov_ag/Nim/lib/system/excpt.nim"
static N_INLINE(void, nimFrame)(TFrame* s) {
	NI LOC1;
#line 304 "/home/fedorov_ag/Nim/lib/system/excpt.nim"
	LOC1 = 0;
#line 304 "/home/fedorov_ag/Nim/lib/system/excpt.nim"
	{
#line 304 "/home/fedorov_ag/Nim/lib/system/excpt.nim"
		if (!(frameptr_19436 == NIM_NIL)) goto LA4;
		LOC1 = ((NI) 0);	}
	goto LA2;
	LA4: ;
	{
#line 304 "/home/fedorov_ag/Nim/lib/system/excpt.nim"
		LOC1 = ((NI) ((NI16)((*frameptr_19436).calldepth + ((NI16) 1))));	}
	LA2: ;
	(*s).calldepth = ((NI16) (LOC1));
#line 305 "/home/fedorov_ag/Nim/lib/system/excpt.nim"
	(*s).prev = frameptr_19436;
#line 306 "/home/fedorov_ag/Nim/lib/system/excpt.nim"
	frameptr_19436 = s;
#line 307 "/home/fedorov_ag/Nim/lib/system/excpt.nim"
	{
#line 307 "/home/fedorov_ag/Nim/lib/system/excpt.nim"
		if (!((*s).calldepth == ((NI16) 2000))) goto LA9;

#line 307 "/home/fedorov_ag/Nim/lib/system/excpt.nim"
		stackoverflow_22201();
	}
	LA9: ;
}


#line 49 "/home/fedorov_ag/Nim/lib/system/excpt.nim"
static N_INLINE(void, popFrame)(void) {

#line 50 "/home/fedorov_ag/Nim/lib/system/excpt.nim"
	frameptr_19436 = (*frameptr_19436).prev;}


#line 195 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
N_NIMCALL(NI, rawparseint_98927)(NimStringDesc* s, NI64* b, NI start) {
	NI result;
	NI64 sign;
	NI i;
	nimfr("rawParseInt", "parseutils.nim")
	result = 0;
#line 197 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
	nimln(197, "parseutils.nim");	sign = IL64(-1);
#line 198 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
	nimln(198, "parseutils.nim");	i = start;
#line 199 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
	nimln(199, "parseutils.nim");	{		NI TMP338;
#line 199 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
		if ((NU)(i) > (NU)(s->Sup.len)) raiseIndexError();		if (!((NU8)(s->data[i]) == (NU8)(43))) goto LA3;

#line 199 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
		TMP338 = addInt(i, ((NI) 1));		i = (NI)(TMP338);	}
	goto LA1;
	LA3: ;
	{		NI TMP339;
#line 200 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
		nimln(200, "parseutils.nim");		if ((NU)(i) > (NU)(s->Sup.len)) raiseIndexError();		if (!((NU8)(s->data[i]) == (NU8)(45))) goto LA6;

#line 201 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
		nimln(201, "parseutils.nim");		TMP339 = addInt(i, ((NI) 1));		i = (NI)(TMP339);
#line 202 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
		nimln(202, "parseutils.nim");		sign = IL64(1);	}
	goto LA1;
	LA6: ;
	LA1: ;

#line 203 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
	nimln(203, "parseutils.nim");	{		NI64 TMP345;		NI TMP346;
#line 1098 "/home/fedorov_ag/Nim/lib/system.nim"
		nimln(1098, "system.nim");		if ((NU)(i) > (NU)(s->Sup.len)) raiseIndexError();		if (!(((NU8)(s->data[i])) >= ((NU8)(48)) && ((NU8)(s->data[i])) <= ((NU8)(57)))) goto LA10;

#line 204 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
		nimln(204, "parseutils.nim");		(*b) = IL64(0);		{
#line 205 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
			nimln(205, "parseutils.nim");			while (1) {				NI64 TMP340;				NI TMP341;				NI64 TMP342;				NI TMP343;
#line 1098 "/home/fedorov_ag/Nim/lib/system.nim"
				nimln(1098, "system.nim");				if ((NU)(i) > (NU)(s->Sup.len)) raiseIndexError();				if (!(((NU8)(s->data[i])) >= ((NU8)(48)) && ((NU8)(s->data[i])) <= ((NU8)(57)))) goto LA13;

#line 206 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
				nimln(206, "parseutils.nim");
#line 206 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"

#line 206 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
				TMP340 = mulInt64((*b), IL64(10));
#line 206 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"

#line 206 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
				if ((NU)(i) > (NU)(s->Sup.len)) raiseIndexError();				TMP341 = subInt(((NI) (((NU8)(s->data[i])))), ((NI) 48));				TMP342 = subInt64((NI64)(TMP340), ((NI64) ((NI)(TMP341))));				(*b) = (NI64)(TMP342);
#line 207 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
				nimln(207, "parseutils.nim");				TMP343 = addInt(i, ((NI) 1));				i = (NI)(TMP343);				{
#line 208 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
					nimln(208, "parseutils.nim");					while (1) {						NI TMP344;
#line 208 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
						if ((NU)(i) > (NU)(s->Sup.len)) raiseIndexError();						if (!((NU8)(s->data[i]) == (NU8)(95))) goto LA15;

#line 208 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
						TMP344 = addInt(i, ((NI) 1));						i = (NI)(TMP344);					} LA15: ;				}
			} LA13: ;		}

#line 209 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
		nimln(209, "parseutils.nim");
#line 209 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
		TMP345 = mulInt64((*b), sign);		(*b) = (NI64)(TMP345);
#line 210 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
		nimln(210, "parseutils.nim");
#line 210 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
		TMP346 = subInt(i, start);		result = (NI)(TMP346);	}
	LA10: ;
	popFrame();	return result;}


#line 213 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
N_NIMCALL(NI, npuParseBiggestInt)(NimStringDesc* s, NI64* number, NI start) {
	NI result;
	NI64 res;
	nimfr("parseBiggestInt", "parseutils.nim")
	result = 0;	res = 0;
#line 221 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
	nimln(221, "parseutils.nim");	result = rawparseint_98927(s, (&res), start);
#line 222 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
	nimln(222, "parseutils.nim");	(*number) = res;	popFrame();	return result;}


#line 129 "/home/fedorov_ag/Nim/lib/system/gc.nim"
static N_INLINE(Cell47905*, usrtocell_51840)(void* usr) {
	Cell47905* result;
	nimfr("usrToCell", "gc.nim")
	result = 0;
#line 131 "/home/fedorov_ag/Nim/lib/system/gc.nim"
	nimln(131, "gc.nim");
#line 131 "/home/fedorov_ag/Nim/lib/system/gc.nim"

#line 131 "/home/fedorov_ag/Nim/lib/system/gc.nim"
	result = ((Cell47905*) ((NI)((NU64)(((NI) (usr))) - (NU64)(((NI)sizeof(Cell47905))))));	popFrame();	return result;}


#line 208 "/home/fedorov_ag/Nim/lib/system/gc.nim"
static N_INLINE(void, rtladdzct_53401)(Cell47905* c) {
	nimfr("rtlAddZCT", "gc.nim")

#line 212 "/home/fedorov_ag/Nim/lib/system/gc.nim"
	nimln(212, "gc.nim");	addzct_51817((&gch_50259.zct), c);
	popFrame();}


#line 244 "/home/fedorov_ag/Nim/lib/system/gc.nim"
static N_INLINE(void, nimGCunrefNoCycle)(void* p) {
	Cell47905* c;
	nimfr("nimGCunrefNoCycle", "gc.nim")

#line 246 "/home/fedorov_ag/Nim/lib/system/gc.nim"
	nimln(246, "gc.nim");	c = usrtocell_51840(p);
#line 248 "/home/fedorov_ag/Nim/lib/system/gc.nim"
	nimln(248, "gc.nim");	{
#line 180 "/home/fedorov_ag/Nim/lib/system/gc.nim"
		nimln(180, "gc.nim");		(*c).refcount -= ((NI) 8);
#line 181 "/home/fedorov_ag/Nim/lib/system/gc.nim"
		nimln(181, "gc.nim");		if (!((NU64)((*c).refcount) < (NU64)(((NI) 8)))) goto LA3;

#line 249 "/home/fedorov_ag/Nim/lib/system/gc.nim"
		nimln(249, "gc.nim");		rtladdzct_53401(c);
	}
	LA3: ;
	popFrame();}


#line 224 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
N_NIMCALL(NI, npuParseInt)(NimStringDesc* s, NI* number, NI start) {
	NI result;
	NI64 res;
	nimfr("parseInt", "parseutils.nim")
	result = 0;	res = 0;
#line 230 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
	nimln(230, "parseutils.nim");	result = npuParseBiggestInt(s, (&res), start);
#line 231 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
	nimln(231, "parseutils.nim");	{		NIM_BOOL LOC3;		NIM_BOOL LOC5;		Overflowerror3640* e_99041;
		NimStringDesc* LOC9;
#line 231 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
		LOC3 = 0;		LOC3 = NIM_FALSE;		if (!(LOC3)) goto LA4;

#line 232 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
		nimln(232, "parseutils.nim");		LOC5 = 0;
#line 232 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
		LOC5 = (res < (IL64(-9223372036854775807) - IL64(1)));		if (LOC5) goto LA6;

#line 357 "/home/fedorov_ag/Nim/lib/system.nim"
		nimln(357, "system.nim");		LOC5 = (IL64(9223372036854775807) < res);		LA6: ;
		LOC3 = LOC5;		LA4: ;
		if (!LOC3) goto LA7;
		e_99041 = 0;
#line 2510 "/home/fedorov_ag/Nim/lib/system.nim"
		nimln(2510, "system.nim");		e_99041 = (Overflowerror3640*) newObj((&NTI24269), sizeof(Overflowerror3640));		(*e_99041).Sup.Sup.Sup.m_type = (&NTI3640);
#line 2511 "/home/fedorov_ag/Nim/lib/system.nim"
		nimln(2511, "system.nim");		LOC9 = 0;		LOC9 = (*e_99041).Sup.Sup.message; (*e_99041).Sup.Sup.message = copyStringRC1(((NimStringDesc*) &TMP347));		if (LOC9) nimGCunrefNoCycle(LOC9);
#line 233 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
		nimln(233, "parseutils.nim");		raiseException((Exception*)e_99041, "OverflowError");	}
	goto LA1;
	LA7: ;
	{
#line 349 "/home/fedorov_ag/Nim/lib/system.nim"
		nimln(349, "system.nim");
#line 349 "/home/fedorov_ag/Nim/lib/system.nim"
		if (!!((result == ((NI) 0)))) goto LA11;

#line 235 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
		nimln(235, "parseutils.nim");		(*number) = ((NI) (res));	}
	goto LA1;
	LA11: ;
	LA1: ;
	popFrame();	return result;}


#line 243 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
N_NIMCALL(NI, npuParseFloat)(NimStringDesc* s, NF* number, NI start) {
	NI result;
	NF bf;
	nimfr("parseFloat", "parseutils.nim")
	result = 0;	bf = 0;
#line 249 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
	nimln(249, "parseutils.nim");
#line 249 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
	result = nimParseBiggestFloat(s, (&bf), start);
#line 250 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
	nimln(250, "parseutils.nim");	{
#line 349 "/home/fedorov_ag/Nim/lib/system.nim"
		nimln(349, "system.nim");
#line 349 "/home/fedorov_ag/Nim/lib/system.nim"
		if (!!((result == ((NI) 0)))) goto LA3;

#line 251 "/home/fedorov_ag/Nim/lib/pure/parseutils.nim"
		nimln(251, "parseutils.nim");		(*number) = bf;	}
	LA3: ;
	popFrame();	return result;}
NIM_EXTERNC N_NOINLINE(void, stdlib_parseutilsInit000)(void) {
	nimfr("parseutils", "parseutils.nim")
	popFrame();}

NIM_EXTERNC N_NOINLINE(void, stdlib_parseutilsDatInit000)(void) {
}

