;=============================================================================
; @file DosStub.asm
;
; It's the program that would be a replacement for the DOS stub.
; It shows the message 'This program cannot be run in DOS mode after 1am.'
; and jumps to the CrackMe.asm which contains pe32 code.	
;
; Copyright 2017 Hamidreza Ebtehaj.
; Use of this source code is governed by a BSD-style license that can
; be found in the LICENSE file.
;=============================================================================
OFFSET_START	equ 0x400
SEGMENT_INSERT	equ	(OFFSET_START - 0x50) >> 4

segment code
; Going to be a 16 bit application
bits 16

..start:
	;Setting up segment registers.
	mov	ax,	data 
	mov	ds,	ax 
	mov	ax,	stack 
	mov	ss,	ax 
	mov	sp,	stacktop

	;Writing 'cannot run in DOS' message.
	mov	dx,	String.NotDosApplication 
	mov	ah,	9 
	int	0x21

	; OK This works for a jump inside text section of pe file.
	mov ax, cs
	add	ax, SEGMENT_INSERT
	push ax
	push 0
	retf

segment data 
String.NotDosApplication:	db	'This program cannot be run in DOS mode after 1am.', 13, 10, '$'

segment stack stack 
	resb 0x100 
stacktop: