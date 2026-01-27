BankswitchHome::
; switches to bank # in a
; Only use this when in the home bank!
	ld [wBankswitchHomeTemp], a
	ldh a, [hLoadedROMBank]
	ld [wBankswitchHomeSavedROMBank], a
	ld a, [wBankswitchHomeTemp]
BankswitchCommon::
SetRomBank::
	ldh [hLoadedROMBank], a
	ld [MBC1RomBank], a
	ret

BankswitchBack::
; returns from BankswitchHome
	ld a, [wBankswitchHomeSavedROMBank]
	ldh [hLoadedROMBank], a
	ld [MBC1RomBank], a
	ret

Bankswitch::
; self-contained bankswitch, use this when not in the home bank
; switches to the bank in b
	; All instructions containing [hColorHackTmps] have been added to allow Bankswitch to
	; preserve 'a' for use in a function. 
	; Also preserve and return the product of the function if outputted in 'a'.
	ldh [hColorHackTmp2], a ; [hColorHackTmps]
	ldh a, [hLoadedROMBank]
	push af
	ld a, b
	ldh [hLoadedROMBank], a
	ld [MBC1RomBank], a
	ld bc, .Return
	push bc
	ldh a, [hColorHackTmp2] ; [hColorHackTmps]
	jp hl
.Return
	ldh [hColorHackTmp2], a ; [hColorHackTmps]
	pop bc
	ld a, b
	ldh [hLoadedROMBank], a
	ld [MBC1RomBank], a
	ldh a, [hColorHackTmp2] ; [hColorHackTmps]
	ret


;; Code moved from home/header
_LoadMapVramAndColors:
	ldh a, [hLoadedROMBank]
	push af
	ld a, BANK(LoadMapVramAndColors)
	ld [MBC1RomBank], a
	call LoadMapVramAndColors
	pop af
	ld [MBC1RomBank], a
	ret
