" Vim syntax file
" Language: JOVIAL J73
" Version: 1.1
" Maintainer: Paul McGinnis <paulmcg@aol.com>
" Last Change: 2011/05/30
" Remark: Based on MIL-STD-1589C for JOVIAL J73 language

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case ignore

syn keyword jovialTodo TODO FIXME XXX contained

" JOVIAL beads - first digit is number of bits, [0-9A-V] is the bit value
" representing 0-31 (for 5 bits on the bead)
syn match jovialBitConstant "[1-5]B'[0-9A-V]'"

syn match jovialNumber "\<\d\+\>"

syn match jovialFloat "\d\+E[-+]\=\d\+"
syn match jovialFloat "\d\+\.\d*\(E[-+]\=\d\+\)\="
syn match jovialFloat "\.\d\+\(E[-+]\=\d\+\)\="

syn region jovialComment start=/"/ end=/"/ contains=jovialTodo
syn region jovialComment start=/%/ end=/%/ contains=jovialTodo

" JOVIAL variable names. This rule is to prevent conflicts with strings.
" Handle special case where ' character can be part of a JOVIAL variable name.
syn match jovialIdentifier "[A-Z\$][A-Z0-9'\$]\+"

syn region jovialString start="\s*'" skip=/''/ end=/'/ oneline

" JOVIAL compiler directives -- see Section 9 in MIL-STD-1589C
syn region jovialPreProc start="\s*![A-Z]\+" end=/;/

syn keyword jovialOperator AND OR NOT XOR EQV MOD

" See Section 2.1 in MIL-STD-1589C for data types
syn keyword jovialType ITEM B C P V
syn match jovialType "\<S\(,R\|,T\|,Z\)\=\>"
syn match jovialType "\<U\(,R\|,T\|,Z\)\=\>"
syn match jovialType "\<F\(,R\|,T\|,Z\)\=\>"
syn match jovialType "\<A\(,R\|,T\|,Z\)\=\>"

syn keyword jovialStorageClass STATIC CONSTANT PARALLEL BLOCK N M D W

syn keyword jovialStructure TABLE STATUS

syn keyword jovialConstant NULL

syn keyword jovialBoolean FALSE TRUE

syn keyword jovialTypedef TYPE

syn keyword jovialStatement ABORT BEGIN BY BYREF BYRES BYVAL CASE COMPOOL
syn keyword jovialStatement DEF DEFAULT DEFINE ELSE END EXIT FALLTHRU FOR
syn keyword jovialStatement GOTO IF INLINE INSTANCE LABEL LIKE OVERLAY POS
syn keyword jovialStatement PROC PROGRAM REC REF RENT REP RETURN START STOP
syn keyword jovialStatement TERM THEN WHILE

" implementation specific constants and functions, see section 1.4 in MIL-STD-1589C
syn keyword jovialConstant BITSINBYTE BITSINWORD LOCSINWORD
syn keyword jovialConstant BYTESINWORD BITSINPOINTER INTPRECISION
syn keyword jovialConstant FLOATPRECISION FIXEDPRECISION FLOATRADIX
syn keyword jovialConstant MAXFLOATPRECISION MAXFIXEDPRECISION
syn keyword jovialConstant MAXINTSIZE MAXBYTES MAXBITS
syn keyword jovialConstant MAXTABLESIZE MAXSTOP MINSTOP MAXSIGDIGITS
syn keyword jovialFunction BYTEPOS MAXINT MININT
syn keyword jovialFunction IMPLFLOATPRECISION IMPLFIXEDPRECISION IMPLINTSIZE
syn keyword jovialFunction MINSIZE MINFRACTION MINSCALE MINRELPRECISION
syn keyword jovialFunction MAXFLOAT MINFLOAT FLOATRELPRECISION
syn keyword jovialFunction FLOATUNDERFLOW MAXFIXED MINFIXED

" JOVIAL built-in functions
syn keyword jovialFunction LOC NEXT BIT BYTE SHIFTL SHIFTR ABS SGN BITSIZE
syn keyword jovialFunction BYTESIZE WORDSIZE LBOUND UBOUND NWDSEN FIRST
syn keyword jovialFunction LAST NENT

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_jovial_syn_inits")
    if version < 508
        let did_jovial_syn_inits = 1
        command -nargs=+ JovialHiLink hi link <args>
    else
        command -nargs=+ JovialHiLink hi def link <args>
    endif

    JovialHiLink jovialBitConstant Number
    JovialHiLink jovialBoolean Boolean
    JovialHiLink jovialComment Comment
    JovialHiLink jovialConstant Constant
    JovialHiLink jovialFloat Float
    JovialHiLink jovialFunction Function
" No color highlighting for JOVIAL identifiers. See above,
" this is to prevent confusion with JOVIAL strings
"    JovialHiLink jovialIdentifier Identifier
    JovialHiLink jovialNumber Number
    JovialHiLink jovialOperator Operator
    JovialHiLink jovialPreProc PreProc
    JovialHiLink jovialStatement Statement
    JovialHiLink jovialStorageClass StorageClass
    JovialHiLink jovialString String
    JovialHiLink jovialStructure Structure
    JovialHiLink jovialTodo Todo
    JovialHiLink jovialType Type
    JovialHiLink jovialTypedef Typedef

    delcommand JovialHiLink
endif

let b:current_syntax = "jovial"

" vim: ts=8 sw=4
