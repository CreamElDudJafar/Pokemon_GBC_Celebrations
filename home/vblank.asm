VBlank::

	push af
	push bc
	push de
	push hl

	ldh a, [hLoadedROMBank]
	ld [wVBlankSavedROMBank], a

	ldh a, [hSCX]
	ldh [rSCX], a
	ldh a, [hSCY]
	ldh [rSCY], a

	ld a, [wDisableVBlankWYUpdate]
	and a
	jr nz, .ok
	ldh a, [hWY]
	ldh [rWY], a
.ok

	call AutoBgMapTransfer
	call VBlankCopyBgMap
	call RedrawRowOrColumn
	call VBlankCopy
	call VBlankCopyDouble
	;call UpdateMovingBgTiles
	call hDMARoutine
	ld a, BANK(GbcVBlankHook)
	call SetRomBank
	call GbcVBlankHook
	; HAX: don't update sprites here. They're updated elsewhere to prevent wobbliness.
	;ld a, BANK(PrepareOAMData)
	;ldh [hLoadedROMBank], a
	;ld [MBC1RomBank], a
	nop
	;call PrepareOAMData
	nop
	nop
	nop

	; VBlank-sensitive operations end.

	call Random

	ldh a, [hVBlankOccurred]
	and a
	jr z, .skipZeroing
	xor a
	ldh [hVBlankOccurred], a

.skipZeroing
	ldh a, [hFrameCounter]
	and a
	jr z, .skipDec
	dec a
	ldh [hFrameCounter], a

.skipDec
	farcall FadeOutAudio

	callbs Music_DoLowHealthAlarm
	callbs Audio1_UpdateMusic
	farcall TrackPlayTime ; keep track of time played

	ldh a, [hDisableJoypadPolling]
	and a
	call z, ReadJoypad

	call SerialFunction

	ld a, [wVBlankSavedROMBank]
	ldh [hLoadedROMBank], a
	ld [MBC1RomBank], a

	pop hl
	pop de
	pop bc
	pop af
	ret


DelayFrame::
; Wait for the next vblank interrupt.
; As a bonus, this saves battery.

DEF NOT_VBLANKED EQU 1

	call DelayFrameHook ; HAX
	nop
	;ld a, NOT_VBLANKED
	;ldh [hVBlankOccurred], a
.halt
	halt
	ldh a, [hVBlankOccurred]
	and a
	jr nz, .halt
	ret
