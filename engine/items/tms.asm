; tests if mon [wcf91] can learn move [wMoveNum]
CanLearnTM:
	ld a, [wcf91]
	ld [wd0b5], a
	call GetMonHeader
	ld hl, wMonHLearnset
	push hl
	ld a, [wMoveNum]
	ld b, a
	ld c, $0
	ld hl, TechnicalMachines
.findTMloop
	ld a, [hli]
	cp -1 ; reached terminator?
	jr z, .done
	cp b
	jr z, .TMfoundLoop
	inc c
	jr .findTMloop
.TMfoundLoop
	pop hl
	ld b, FLAG_TEST
	predef_jump FlagActionPredef
.done
	pop hl
	ld c, 0
	ret

; converts TM/HM number in [wd11e] into move number
; HMs start at 51
TMToMove:
	ld a, [wd11e]
	dec a
	ld hl, TechnicalMachines
	ld b, $0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wd11e], a
	ret

GetTMMoves:
;	ld de, wRelearnableMoves ; reusing from move relearner for tmhm move list
	ld de, wMoveBuffer	
	ld hl, TechnicalMachines
	xor a
	ld b, a
	inc b
.findTMloop
	ld a, [hli]
	cp -1
	jr z, .done
	ld [wMoveNum], a
	; check if can learn
	push de
	push bc
	push hl
	predef CanLearnTM
	ld a, c
	and a
	pop hl
	pop bc
	pop de
	jr z, .cantLearn
.canLearn
	ld a, b
	ld [de], a
	inc de
	ld a, [wMoveNum]
	ld [de], a
	inc de
.cantLearn
	inc b
	jr .findTMloop
.done
	ld a, 0 ; terminator
	ld [de], a
	ret

INCLUDE "data/moves/tmhm_moves.asm"
