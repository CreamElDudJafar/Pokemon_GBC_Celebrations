;ExclamationText:: ; unused
;	text_far _ExclamationText
;	text_end

;GroundRoseText:: ; unused
;	text_far _GroundRoseText
;	text_end

BoulderText::
	text_far _BoulderText
	text_asm
	ld a, [wObtainedBadges]
	bit 3, a ; RAINBOW BADGE
	jr z, .done 
	ld d, STRENGTH
	callfar HasPartyMove
	ld a, [wWhichTrade]
	and a 
	jr nz, .done 
	ld a, [wWhichPokemon]
	push af 
	call ManualTextScroll
	pop af 
	ld [wWhichPokemon], a 
	call GetPartyMonName2 
	ld a, [wWhichPokemon]
	ld hl, wPartySpecies
	ld c, a
	ld a, l
	add a, c
	ld l, a
	jr nc, .noCarry
	inc h
.noCarry
	ld a, [hl]
	ld [wcf91], a
	predef PrintStrengthTxt
.done 
    rst TextScriptEnd 

;MartSignText::
;	text_far _MartSignText
;	text_end

PickUpItemText::
	text_asm
	predef PickUpItem
	rst TextScriptEnd
