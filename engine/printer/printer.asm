PrintPokedexEntry:
	ld a, [wUpdateSpritesEnabled]
	push af
	xor a
	ld [wUpdateSpritesEnabled], a
	ldh [hCanceledPrinting], a
	call Printer_PlayPrinterMusic
	ldh a, [rIE]
	push af
	xor a
	ldh [rIF], a
	ld a, $9
	ldh [rIE], a
	xor a
	ldh [hAutoBGTransferEnabled], a
	call Printer_GetDexEntryRegisters
	call Printer_StartTransmission
	ld a, [wPrinterPokedexMonIsOwned]
	and a
	jr z, .not_caught
	ld a, 16
	jr .got_size

.not_caught
	ld a, 19
.got_size
	ld [wcae2], a
	call Printer_CopyTileMapToPrinterTileBuffer
	call ClearScreen
	callfar Pokedex_DrawInterface
	callfar Pokedex_PlacePokemonList
	ld a, $1
	ldh [hAutoBGTransferEnabled], a
	call .TryPrintPage
	jr c, .finish_printing
	ld a, [wPrinterPokedexMonIsOwned]
	and a
	jr z, .finish_printing
	xor a
	ld [wPrinterConnectionOpen], a
	ld [wPrinterOpcode], a
	ld c, $c
	rst _DelayFrames
	call SaveScreenTilesToBuffer1
	xor a
	ldh [hAutoBGTransferEnabled], a
	call Printer_PrepareDexEntryForPrinting
	ld a, $7
	call Printer_StartTransmission
	ld a, $3
	ld [wcae2], a
	call Printer_CopyTileMapToPrinterTileBuffer
	call LoadScreenTilesFromBuffer1
	ld a, $1
	ldh [hAutoBGTransferEnabled], a
	call .TryPrintPage
.finish_printing
	xor a
	ld [wPrinterConnectionOpen], a
	ld [wPrinterOpcode], a
	xor a
	ldh [rIF], a
	pop af
	ldh [rIE], a
	call ReloadMapAfterPrinter
	call Printer_PlayMapMusic
	pop af
	ld [wUpdateSpritesEnabled], a
	ret

.TryPrintPage:
	call Printer_ResetJoypadHRAM
.print_loop
	call JoypadLowSensitivity
	call Printer_StopIfPressB
	jr c, .pressed_b
	ld a, [wPrinterSendState]
	bit 7, a
	jr nz, .completed
	call PrinterTransmissionJumptable
	call GBPrinter_CheckForErrors
	call GBPrinter_UpdateStatusMessage
	rst _DelayFrame
	jr .print_loop

.completed
	and a
	ret

.pressed_b
	scf
	ret

Printer_GetDexEntryRegisters:
	callfar DrawDexEntryOnScreen
	ld a, l
	ld [wPrinterPokedexEntryTextPointer], a
	ld a, h
	ld [wPrinterPokedexEntryTextPointer + 1], a
	ld a, $0
	rla ; copy carry flag state to bit 0
	ld [wPrinterPokedexMonIsOwned], a
	and a
	jr z, .not_caught
	ld a, $5
	jr .got_num_rows

.not_caught
	ld a, $9
.got_num_rows
	ret

Printer_PrepareDexEntryForPrinting:
	call ClearScreen
	callfar Pokedex_PrepareDexEntryForPrinting
	ret

PrintDiploma::
	xor a
	ldh [hCanceledPrinting], a
	call Printer_PlayPrinterMusic
	call _DisplayDiplomaTop
	ldh a, [rIE]
	push af
	xor a
	ldh [rIF], a
	ld a, $9
	ldh [rIE], a
	call StartTransmission_Send9Rows
	ld a, $10
	ld [wcae2], a
	call Printer_CopyTileMapToPrinterTileBuffer
	call PrintDiplomaPage
	jr c, .quit
	xor a
	ld [wPrinterConnectionOpen], a
	ld [wPrinterOpcode], a
	ld c, $c
	rst _DelayFrames
	call SaveScreenTilesToBuffer1
	xor a
	ldh [hAutoBGTransferEnabled], a
	call DisplayDiplomaBottom
	call StartTransmission_Send9Rows
	ld a, $3
	ld [wcae2], a
	call Printer_CopyTileMapToPrinterTileBuffer
	call LoadScreenTilesFromBuffer1
	call PrintDiplomaPage
.quit
	xor a
	ld [wPrinterConnectionOpen], a
	ld [wPrinterOpcode], a
	call Printer_CopyTileMapFromPrinterTileBuffer
	xor a
	ldh [rIF], a
	pop af
	ldh [rIE], a
	call ReloadMapAfterPrinter
	call Printer_PlayMapMusic
	ret

PrintDiplomaPage:
	call Printer_ResetJoypadHRAM
.print_loop
	call JoypadLowSensitivity
	call Printer_StopIfPressB
	jr c, .pressed_b
	ld a, [wPrinterSendState]
	bit 7, a
	jr nz, .completed
	call PrinterTransmissionJumptable
	call GBPrinter_CheckForErrors
	call GBPrinter_UpdateStatusMessage
	rst _DelayFrame
	jr .print_loop

.completed
	and a
	ret

.pressed_b
	scf
	ret

PrintPCBox::
	ld a, [wBoxDataStart]
	and a
	jp z, .emptyBox
	ld a, [wUpdateSpritesEnabled]
	push af
	xor a
	ld [wUpdateSpritesEnabled], a
	ldh [hCanceledPrinting], a
	call Printer_PlayPrinterMusic
	ldh a, [rIE]
	push af
	xor a
	ldh [rIF], a
	ld a, $9
	ldh [rIE], a
	call SaveScreenTilesToBuffer1
	xor a
	ldh [hAutoBGTransferEnabled], a
	call PrintPCBox_DrawPage1
	call StartTransmission_Send9Rows
	ld a, $10
	ld [wcae2], a
	call Printer_CopyTileMapToPrinterTileBuffer
	call LoadScreenTilesFromBuffer1
	call PrintPCBoxPage
	jr c, .quit
	xor a
	ld [wPrinterConnectionOpen], a
	ld [wPrinterOpcode], a
	ld c, 12
	rst _DelayFrames
	xor a
	ldh [hAutoBGTransferEnabled], a
	call PrintPCBox_DrawPage2
	call StartTransmission_Send9Rows
	ld a, $0
	ld [wcae2], a
	call Printer_CopyTileMapToPrinterTileBuffer
	call LoadScreenTilesFromBuffer1
	call PrintPCBoxPage
	jr c, .quit
	xor a
	ld [wPrinterConnectionOpen], a
	ld [wPrinterOpcode], a
	ld c, 12
	rst _DelayFrames
	xor a
	ldh [hAutoBGTransferEnabled], a
	call PrintPCBox_DrawPage3
	call StartTransmission_Send9Rows
	ld a, $0
	ld [wcae2], a
	call Printer_CopyTileMapToPrinterTileBuffer
	call LoadScreenTilesFromBuffer1
	call PrintPCBoxPage
	jr c, .quit
	xor a
	ld [wPrinterConnectionOpen], a
	ld [wPrinterOpcode], a
	ld c, 12
	rst _DelayFrames
	xor a
	ldh [hAutoBGTransferEnabled], a
	call PrintPCBox_DrawPage4
	call StartTransmission_Send9Rows
	ld a, $3
	ld [wcae2], a
	call Printer_CopyTileMapToPrinterTileBuffer
	call LoadScreenTilesFromBuffer1
	call PrintPCBoxPage
.quit
	xor a
	ld [wPrinterConnectionOpen], a
	ld [wPrinterOpcode], a
	xor a
	ldh [rIF], a
	pop af
	ldh [rIE], a
	call ReloadMapAfterPrinter
	call Printer_PlayMapMusic
	pop af
	ld [wUpdateSpritesEnabled], a
	ret

.emptyBox:
	ld hl, NoPokemonText
	rst _PrintText
	ret

PrintPCBoxPage:
	call Printer_ResetJoypadHRAM
.print_loop
	call JoypadLowSensitivity
	call Printer_StopIfPressB
	jr c, .pressed_b
	ld a, [wPrinterSendState]
	bit 7, a
	jr nz, .completed
	call PrinterTransmissionJumptable
	call GBPrinter_CheckForErrors
	call GBPrinter_UpdateStatusMessage
	rst _DelayFrame
	jr .print_loop

.completed
	and a
	ret

.pressed_b
	scf
	ret

NoPokemonText:
	text_far _NoPokemonText
	text_end

PrintFanClubPortrait::
	xor a
	ldh [hCanceledPrinting], a
	call Printer_PlayPrinterMusic
	call Printer_GetMonStats
	ldh a, [rIE]
	push af
	xor a
	ldh [rIF], a
	ld a, $9
	ldh [rIE], a
	call StartTransmission_Send9Rows
	ld a, $13
	ld [wcae2], a
	call Printer_CopyTileMapToPrinterTileBuffer
	call Printer_ResetJoypadHRAM
.print_loop
	call JoypadLowSensitivity
	call Printer_StopIfPressB
	jr c, .quit
	ld a, [wPrinterSendState]
	bit 7, a
	jr nz, .quit
	call PrinterTransmissionJumptable
	call GBPrinter_CheckForErrors
	call GBPrinter_UpdateStatusMessage
	rst _DelayFrame
	jr .print_loop

.quit
	xor a
	ld [wPrinterConnectionOpen], a
	ld [wPrinterOpcode], a
	call Printer_CopyTileMapFromPrinterTileBuffer
	xor a
	ldh [rIF], a
	pop af
	ldh [rIE], a
	call ReloadMapAfterPrinter
	call Printer_PlayMapMusic
	ret

PrinterDebug:
	push af
	push bc
	push de
	push hl
	call StopAllMusic
	ldh a, [rIE]
	push af
	xor a
	ldh [rIF], a
	ld a, $9
	ldh [rIE], a
	call StartTransmission_Send9Rows
	ld a, $13
	ld [wcae2], a
	ld a, $1
	ldh [hAutoBGTransferEnabled], a
	call Printer_CopyTileMapToPrinterTileBuffer
	call PrinterDebug_LoadGFX
.loop
	ld a, [wPrinterSendState]
	bit 7, a
	jr nz, .quit
	call PrinterDebug_DoFunction
	call PrinterDebug_ConvertStatusFlagsToTiles
	rst _DelayFrame
	jr .loop

.quit
	xor a
	ld [wPrinterConnectionOpen], a
	ld [wPrinterOpcode], a
	ld hl, wShadowOAMSprite32
	ld bc, 8 * 4
	xor a
	call FillMemory
	xor a
	ldh [rIF], a
	pop af
	ldh [rIE], a
	pop hl
	pop de
	pop bc
	pop af
	ret

Printer_StopIfPressB:
	ldh a, [hJoyHeld]
	and B_BUTTON
	jr nz, .quit
	and a
	ret

.quit
	ld a, [wPrinterSendState]
	cp $c
	jr nz, .already_done
.wait_current_task
	ld a, [wPrinterOpcode]
	and a
	jr nz, .wait_current_task
	ld a, $16
	ld [wPrinterOpcode], a
	ld a, $88
	ldh [rSB], a
	ld a, $1
	ldh [rSC], a
	ld a, $81
	ldh [rSC], a
.wait_send_cancel
	ld a, [wPrinterOpcode]
	and a
	jr nz, .wait_send_cancel
.already_done
	ld a, $1
	ldh [hCanceledPrinting], a
	scf
	ret

Printer_CopyTileMapToPrinterTileBuffer:
	hlcoord 0, 0
	decoord 0, 0, wPrinterTileBuffer
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	rst _CopyData
	ret

Printer_CopyTileMapFromPrinterTileBuffer:
	hlcoord 0, 0, wPrinterTileBuffer
	decoord 0, 0
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	rst _CopyData
	ret

Printer_ResetJoypadHRAM:
	xor a
	ldh [hJoyLast], a
	ldh [hJoyReleased], a
	ldh [hJoyPressed], a
	ldh [hJoyHeld], a
	ldh [hJoy5], a
	ldh [hJoy6], a
	ret

Printer_PlayPrinterMusic:
	call Printer_FadeOutMusicAndWait
	ld a, [wAudioROMBank]
	ld [wAudioSavedROMBank], a
	ld a, BANK(Music_GBPrinter)
	ld [wAudioROMBank], a
	ld a, MUSIC_GB_PRINTER
	ld [wNewSoundID], a
	rst _PlaySound
	ret

Printer_PlayMapMusic:
	call Printer_FadeOutMusicAndWait
	call PlayDefaultMusic
	ret

Printer_FadeOutMusicAndWait:
	ld a, $4
	ld [wAudioFadeOutControl], a
	call StopAllMusic
.wait_music_stop
	ld a, [wAudioFadeOutControl]
	and a
	jr nz, .wait_music_stop
	ret

GBPrinter_CheckForErrors:
	ld a, [wPrinterHandshake]
	cp $81
	jr z, .check_other_errors
	ld a, [wPrinterStatusFlags]
	cp $ff
	jr z, .error2
	xor a
	jr .load_status

.check_other_errors
	ld a, [wPrinterStatusFlags]
	and %11100000
	ret z
	bit 7, a
	jr nz, .error1
	bit 6, a
	jr nz, .error4
	; error 3
	ld a, PRINTER_ERROR_3
	jr .load_status

.error4
	ld a, PRINTER_ERROR_4
	jr .load_status

.error1
	ld a, PRINTER_ERROR_1
	jr .load_status

.error2
	ld a, PRINTER_ERROR_2
.load_status
	ld [wPrinterStatusIndicator], a
	ret

GBPrinter_UpdateStatusMessage:
	ld a, [wPrinterStatusIndicator]
	and a
	ret z
	push af
	xor a
	ldh [hAutoBGTransferEnabled], a
	hlcoord 0, 5
	lb bc, 10, 18
	call TextBoxBorder
	pop af
	ld e, a
	ld d, $0
	ld hl, .PrinterStatusMessages
	add hl, de
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 1, 7
	call PlaceString
	hlcoord 2, 15
	ld de, .PressBToCancel
	call PlaceString
	ld a, $1
	ldh [hAutoBGTransferEnabled], a
	xor a
	ld [wPrinterStatusIndicator], a
	ret

.PressBToCancel:
	db "Press B to Cancel@"

.PrinterStatusMessages:
	dw .Blank
	dw .CheckingLink
	dw .Transmitting
	dw .Printing
	dw .Error1
	dw .Error2
	dw .Error3
	dw .Error4
	dw .WrongDevice

.Blank:
	db   "@"
.CheckingLink:
	db   ""
	next " CHECKING LINK...@"
.Transmitting:
	db   ""
	next "  TRANSMITTING...@"
.Printing:
	db   ""
	next "    PRINTING...@"
.Error1:
	db   " Printer Error 1"
	next ""
	next "Check the Game Boy"
	next "Printer Manual.@"
.Error2:
	db   " Printer Error 2"
	next ""
	next "Check the Game Boy"
	next "Printer Manual.@"
.Error3:
	db   " Printer Error 3"
	next ""
	next "Check the Game Boy"
	next "Printer Manual.@"
.Error4:
	db   " Printer Error 4"
	next ""
	next "Check the Game Boy"
	next "Printer Manual.@"
.WrongDevice:
	db   "This is not the"
	next "Game Boy Printer!@"

Diploma_Surfing_CopyBox:
.y
	push bc
	push hl
.x
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .x
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .y
	ret

PrintPCBox_DrawPage1:
	xor a
	ld [wBoxNumString], a
	call ClearScreen
	call PrintPCBox_PlaceHorizontalLines
	hlcoord 0, 0
	ld bc, 11 * SCREEN_WIDTH
	ld a, " "
	call FillMemory
	call PrintPCBox_DrawLeftAndRightBorders
	call PrintPCBox_DrawTopBorder
	hlcoord 4, 4
	ld de, .PokemonListString
	call PlaceString
	hlcoord 7, 6
	ld de, .BoxString
	call PlaceString
	hlcoord 11, 6
	ld a, [wCurrentBoxNum]
	and $7f
	cp 9
	jr c, .less_than_9
	sub 9
	ld [hl], "1"
	inc hl
	add "0"
	jr .placed_box_number

.less_than_9
	add "1"
.placed_box_number
	ld [hl], a
	hlcoord 4, 9
	ld de, wBoxSpecies
	ld c, $3
	call PrintPCBox_PlaceBoxMonInfo
	ret

.PokemonListString: db "POKéMON LIST@"
.BoxString: db "BOX@"

PrintPCBox_DrawPage2:
	call ClearScreen
	call PrintPCBox_PlaceHorizontalLines
	call PrintPCBox_DrawLeftAndRightBorders
	ld a, [wBoxDataStart]
	cp 4
	ret c
	hlcoord 4, 0
	ld de, wBoxSpecies + 3
	ld c, 6
	call PrintPCBox_PlaceBoxMonInfo
	ret

PrintPCBox_DrawPage3:
	call ClearScreen
	call PrintPCBox_PlaceHorizontalLines
	call PrintPCBox_DrawLeftAndRightBorders
	ld a, [wBoxDataStart]
	cp 10
	ret c
	hlcoord 4, 0
	ld de, wBoxSpecies + 9
	ld c, 6
	call PrintPCBox_PlaceBoxMonInfo
	ret

PrintPCBox_DrawPage4:
	call ClearScreen
	call PrintPCBox_PlaceHorizontalLines
	call PrintPCBox_DrawLeftAndRightBorders
	hlcoord 0, 15
	call PrintPCBox_DrawBottomBorderAtHL
	hlcoord 0, 16
	ld bc, 2 * SCREEN_WIDTH
	ld a, " "
	call FillMemory
	ld a, [wBoxDataStart]
	cp 16
	ret c
	hlcoord 4, 0
	ld de, wBoxSpecies + 15
	ld c, 5
	call PrintPCBox_PlaceBoxMonInfo
	ret

PrintPCBox_PlaceBoxMonInfo:
.loop
	ld a, c
	and a
	jr z, .done
	dec c
	ld a, [de]
	cp $ff
	jr z, .done
	ld [wd11e], a
	push bc
	push hl
	push de
	push hl
	ld bc, 12
	ld a, " "
	call FillMemory
	pop hl
	push hl
	ld de, SCREEN_WIDTH
	add hl, de
	ld bc, 12
	ld a, " "
	call FillMemory
	pop hl
	push hl
	call GetMonName
	pop hl
	call PlaceString
	push hl
	ld hl, wBoxMonNicks
	ld bc, NAME_LENGTH
	ld a, [wBoxNumString]
	call AddNTimes
	ld e, l
	ld d, h
	pop hl
	ld bc, SCREEN_WIDTH + 1
	add hl, bc
	ld [hl], " "
	inc hl
	call PlaceString
	ld hl, wBoxNumString
	inc [hl]
	pop de
	pop hl
	ld bc, 3 * SCREEN_WIDTH
	add hl, bc
	pop bc
	inc de
	jr .loop

.done
	ret

PrintPCBox_DrawTopBorder:
	hlcoord 0, 0
	ld a, $79
	ld [hli], a
	ld a, $7a
	ld c, SCREEN_WIDTH - 2
.loop
	ld [hli], a
	dec c
	jr nz, .loop
	ld a, $7b
	ld [hl], a
	ret

PrintPCBox_DrawLeftAndRightBorders:
	hlcoord 0, 0
	ld de, SCREEN_WIDTH - 1
	ld c, SCREEN_HEIGHT
.loop
	ld a, $7c
	ld [hl], a
	add hl, de
	ld a, $7c
	ld [hli], a
	dec c
	jr nz, .loop
	ret

PrintPCBox_DrawBottomBorder:
	hlcoord 0, 17
PrintPCBox_DrawBottomBorderAtHL:
	ld a, $7d
	ld [hli], a
	ld a, $7a
	ld c, SCREEN_WIDTH - 2
.loop
	ld [hli], a
	dec c
	jr nz, .loop
	ld a, $7e
	ld [hl], a
	ret

PrintPCBox_PlaceHorizontalLines:
	hlcoord 4, 0
	ld c, 6
	call .PlaceHorizontalLine
	hlcoord 6, 1
	ld c, 6
.PlaceHorizontalLine:
.loop
	push bc
	push hl
	ld de, .HorizontalLineString
	call PlaceString
	pop hl
	ld bc, 3 * SCREEN_WIDTH
	add hl, bc
	pop bc
	dec c
	jr nz, .loop
	ret

.HorizontalLineString:
	db "----------@"
