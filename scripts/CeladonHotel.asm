CeladonHotel_Script:
	ld a, [wUnusedD5A3]	;this location gets cleared between area transistions.
	and a
	jr nz, .jump
	push hl
	callfar GetRandMonAny	;get random pkmn in wcf91
	pop hl
	ld a, [wcf91]
	ld [wUnusedD5A3], a
.jump
	jp EnableAutoTextBoxDrawing

CeladonHotel_TextPointers:
	def_text_pointers
	dw_const CeladonHotelGrannyText,    TEXT_CELADONHOTEL_GRANNY
	dw_const CeladonHotelBeautyText,    TEXT_CELADONHOTEL_BEAUTY
	dw_const CeladonHotelSuperNerdText, TEXT_CELADONHOTEL_SUPER_NERD
	dw_const CeladonHotelCoinGuyText,   TEXT_CELADONHOTEL_COIN_GUY

CeladonHotelCoinGuyText:
	text_asm
	ld hl, CeladonHotelCoinGuyText_Intro	
	ld a, [wUnusedD5A3]
	ld [wd11e], a
	call GetMonName
	rst _PrintText
	ld b, COIN_CASE
	call IsItemInBag
	jr z, .need_coincase
	
	ld a, [wPartyMon1Species]
	ld b, a
	ld a, [wUnusedD5A3]
	cp b
	ld hl, CeladonHotelCoinGuyText_PC
	jr nz, .endscript_print
	
	xor a
	ld [wcd6d], a
	callfar Mon1BCDScore

;load 100 coins by default
	xor a
	ld [hUnusedCoinsByte], a
	ld [hCoins + 1], a
	ld a, $01
	ld [hCoins], a
	
	;add normalized BCD DV score to current coin payout
	ld de, hCoins + 1
	ld hl, wcd6d + 2
	ld c, $2	;make the addition 2 bytes long
	predef AddBCDPredef	;add value in hl location to value in de location
	ld de, wPlayerCoins + 1
	ld hl, hCoins + 1
	ld c, $2	;make the addition 2 bytes long
	predef AddBCDPredef	;add value in hl location to value in de location
	ld hl, CeladonHotelCoinGuyText_Recieved
	rst _PrintText
	ld a, SFX_PURCHASE
	call PlaySoundWaitForCurrent
	call WaitForSoundToFinish
	xor a
	ld [wUnusedD5A3], a
	jr .endscript
.need_coincase
	ld hl, CeladonHotelCoinGuyText_Needcase	
.endscript_print
	rst _PrintText
.endscript
	rst TextScriptEnd
	
HastTooManyCoins:
	ld a, $94
	ld [hCoins], a
	ld a, $24
	ld [hCoins + 1], a
	jp HasEnoughCoins

CeladonHotelGrannyText:
	text_far _CeladonHotelGrannyText
	text_end

CeladonHotelBeautyText:
	text_far _CeladonHotelBeautyText
	text_end

CeladonHotelSuperNerdText:
	text_far _CeladonHotelSuperNerdText
	text_end

CeladonHotelCoinGuyText_Intro:
	text_far _CeladonHotelCoinGuyText_Intro
	text_end

CeladonHotelCoinGuyText_Needcase:
	text_far _CeladonHotelCoinGuyText_Needcase
	text_end

CeladonHotelCoinGuyText_Recieved:
	text_far _CeladonHotelCoinGuyText_Recieved
	text_end
	
CeladonHotelCoinGuyText_PC:
	text_far _CeladonHotelCoinGuyText_PC
	text_end