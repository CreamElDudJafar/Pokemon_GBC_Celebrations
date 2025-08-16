;adding GB_PRINTER

OpenPrinterPC:
	ld hl, wd730
	set 6, [hl]		;set instant text
	xor a
	ld [wParentMenuItem], a
	ld a, [wListScrollOffset]
	push af
	ld a, [wParentMenuItem]
	ld [wCurrentMenuItem], a
;size of menu text box
	hlcoord 0, 0
	ld b, 12
	ld c, 15
	call TextBoxBorder
	hlcoord 2, 2
	ld de, PrinterPCMenuText
	call PlaceString
	ld hl, wTopMenuItemY
	ld a, 2
	ld [hli], a ; wTopMenuItemY
	dec a
	ld [hli], a ; wTopMenuItemX
	inc hl
	inc hl
	ld a, 1	;number of non-cancel menu items
	ld [hli], a ; wMaxMenuItem
	ld a, A_BUTTON | B_BUTTON
	ld [hli], a ; wMenuWatchedKeys
	xor a
	ld [hli], a ; wLastMenuItem
	ld [hli], a ; wPartyAndBillsPCSavedMenuItem
	ld hl, wListScrollOffset
	ld [hli], a ; wListScrollOffset
	ld [hl], a ; wMenuWatchMovingOutOfBounds
	ld [wPlayerMonNumber], a

;now do menu controls
	ld a, 1
	ld [hAutoBGTransferEnabled], a
	call Delay3
	call HandleMenuInput
	bit 1, a
	jp nz, ExitPrinterPC ; b button
	call PlaceUnfilledArrowMenuCursor
	ld a, [wCurrentMenuItem]
	ld [wParentMenuItem], a
	and a
	jr z, PCPrintSettings
	cp $1
;fall through for exiting
ExitPrinterPC:
	pop af
	ld [wListScrollOffset], a
	ld hl, wd730
	res 6, [hl]
	ret
LoopPrinterPC:
	pop af
	ld [wListScrollOffset], a
	ld hl, wd730
	res 6, [hl]
	jp OpenPrinterPC

PrinterPCMenuText:
	db   "PRINT SETTINGS"
	next "CANCEL@"
	
;This is a menu for setting how dark to make the prints	
PCPrintSettings:
	xor a
	ld [wParentMenuItem], a
	ld [wCurrentMenuItem], a
	ld a, [wListScrollOffset]
	push af

	;size of menu text box
	hlcoord 0, 0
	ld b, 12
	ld c, 15
	call TextBoxBorder
	hlcoord 2, 2
	ld de, PrinterPCSettingsText
	call PlaceString

	ld hl, wTopMenuItemY
	ld a, 2
	ld [hli], a ; wTopMenuItemY
	dec a
	ld [hli], a ; wTopMenuItemX
	inc hl
	inc hl

	ld a, 5	;number of non-cancel menu items
	ld [hli], a ; wMaxMenuItem

	ld a, A_BUTTON | B_BUTTON
	ld [hli], a ; wMenuWatchedKeys
	xor a
	ld [hli], a ; wLastMenuItem
	ld [hli], a ; wPartyAndBillsPCSavedMenuItem
	ld hl, wListScrollOffset
	ld [hli], a ; wListScrollOffset
	ld [hl], a ; wMenuWatchMovingOutOfBounds
	ld [wPlayerMonNumber], a

;now handle the text box giving the current setting
	hlcoord 9, 14
	ld b, 2
	ld c, 9
	call TextBoxBorder
	call PCPrinterCurrentSettingDisplay

;now do menu controls
	call HandleMenuInput
	bit 1, a
	jr nz, .exitPrinterSettings ; b button
	call PlaceUnfilledArrowMenuCursor

	ld a, [wCurrentMenuItem]
	ld [wParentMenuItem], a
	and a
	jr z, .lightest
	cp $1
	jr z, .lighter
	cp $2
	jr z, .normal
	cp $3
	jr z, .darker
	cp $4
	jr z, .darkest
	jr .exitPrinterSettings
.affirmSettings
	call PCPrinterCurrentSettingDisplay
	ld a, SFX_ENTER_PC
	call PlaySound
	call WaitForSoundToFinish
.exitPrinterSettings
	pop af
	ld [wListScrollOffset], a
	jp LoopPrinterPC
.lightest
	ld a, $00
	ld [wPrinterSettings], a
	jr .affirmSettings
.lighter
	ld a, $20
	ld [wPrinterSettings], a
	jr .affirmSettings
.normal
	ld a, $40
	ld [wPrinterSettings], a
	jr .affirmSettings
.darker
	ld a, $60
	ld [wPrinterSettings], a
	jr .affirmSettings
.darkest
	ld a, $7F
	ld [wPrinterSettings], a
	jr .affirmSettings

PrinterPCSettingsText:
	db   "LIGHTEST"
	next "LIGHTER"
	next "NORMAL"
	next "DARKER"
	next "DARKEST"
	next "BACK"
	db "@"
PrinterPCSettingsTextSingle00:
	db "LIGHTEST@"
PrinterPCSettingsTextSingle20:
	db "LIGHTER @"
PrinterPCSettingsTextSingle40:
	db "NORMAL  @"
PrinterPCSettingsTextSingle60:
	db "DARKER  @"
PrinterPCSettingsTextSingle7F:
	db "DARKEST @"

PCPrinterCurrentSettingDisplay:
	ld a, [wPrinterSettings]
	ld de, PrinterPCSettingsTextSingle00
	and a
	jr z, .next
	ld de, PrinterPCSettingsTextSingle20
	cp $20
	jr z, .next
	ld de, PrinterPCSettingsTextSingle40
	cp $40
	jr z, .next
	ld de, PrinterPCSettingsTextSingle60
	cp $60
	jr z, .next
	ld de, PrinterPCSettingsTextSingle7F
.next
	hlcoord 10, 16
	call PlaceString
	ret