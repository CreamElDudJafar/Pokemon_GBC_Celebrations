TextBoxBorder::
; Draw a c×b text box at hl.

	; top row
	push hl
	ld a, "┌"
	ld [hli], a
	inc a ; "─"
	call .PlaceChars
	inc a ; "┐"
	ld [hl], a
	pop hl

	ld de, SCREEN_WIDTH
	add hl, de

	; middle rows
.next
	push hl
	ld a, "│"
	ld [hli], a
	ld a, " "
	call .PlaceChars
	ld [hl], "│"
	pop hl

	ld de, SCREEN_WIDTH
	add hl, de
	dec b
	jr nz, .next

	; bottom row
	ld a, "└"
	ld [hli], a
	ld a, "─"
	call .PlaceChars
	ld [hl], "┘"
	ret

.PlaceChars::
; Place char a c times.
	ld d, c
.loop
	ld [hli], a
	dec d
	jr nz, .loop
	ret

PlaceString::
	push hl

PlaceNextChar::
	ld a, [de]
	cp "@"
	jr nz, .NotTerminator
	ld b, h
	ld c, l
	pop hl
	ret

.NotTerminator
	cp "<LF>"
	jr z, .line_feed
	cp "<NEXT>"
	jr nz, .NotNext
	ld bc, 2 * SCREEN_WIDTH
	ldh a, [hUILayoutFlags]
	bit 2, a
	jr z, .ok
.line_feed
	ld bc, SCREEN_WIDTH
.ok
	pop hl
	add hl, bc
	push hl
	jp NextChar

.NotNext
	cp "<LINE>"
	jr nz, .NotLine
	pop hl
	hlcoord 1, 16
	push hl
	jp NextChar

.NotLine

; Check against a dictionary
	dict "<NULL>",    NullChar
	dict "<BAGE>",    MultiButtonPageChar
	dict "<SCROLL>",  _ContTextNoPause
	dict "<_CONT>",   _ContText
	dict "<PARA>",    Paragraph
	dict "<PAGE>",    PageChar
	dict "<PLAYER>",  PrintPlayerName
	dict "<RIVAL>",   PrintRivalName
	dict "#",         PlacePOKe
	dict "<PC>",      PCChar
	dict "<ROCKET>",  RocketChar
	dict "<TMCHAR>",  TMChar
	dict "<TRAINER>", TrainerChar
	dict "<CONT>",    ContText
	dict "<……>",      SixDotsChar
	dict "<DONE>",    DoneText
	dict "<PROMPT>",  PromptText
	dict "<PKMN>",    PlacePKMN
	dict "<DEXEND>",  PlaceDexEnd
	dict "<TARGET>",  PlaceMoveTargetsName
	dict "<USER>",    PlaceMoveUsersName
	dict "<opponent>", OpponentChar
	dict "<user>",     UserChar

	ld [hli], a
	call PrintLetterDelay

NextChar::
	inc de
	jp PlaceNextChar

NullChar:: ; unused
	ld b, h
	ld c, l
	pop hl
	; A "<NULL>" character in a printed string
	; displays an error message with the current value
	; of hSpriteIndexOrTextID in decimal format.
	; This is a debugging leftover.
	ld de, TextIDErrorText
	dec de
	ret

;TextIDErrorText:: ; "[hSpriteIndexOrTextID] ERROR."
;	text_far _TextIDErrorText
;	text_end

MACRO print_name
	push de
	ld de, \1
	jr PlaceCommandCharacter
ENDM

PrintPlayerName:: print_name wPlayerName
PrintRivalName::  print_name wRivalName

TrainerChar:: print_name TrainerCharText
TMChar::      print_name TMCharText
PCChar::      print_name PCCharText
RocketChar::  print_name RocketCharText
PlacePOKe::   print_name PlacePOKeText
SixDotsChar:: print_name SixDotsCharText
PlacePKMN::   print_name PlacePKMNText
UserChar::    print_name UserText
OpponentChar:: print_name OpponentText

PlaceMoveTargetsName::
	ldh a, [hWhoseTurn]
	xor 1
	jr PlaceMoveUsersName.place

PlaceMoveUsersName::
	ldh a, [hWhoseTurn]

.place:
	push de
	and a
	jr nz, .enemy

	ld de, wBattleMonNick
	jr PlaceCommandCharacter

.enemy
	ld de, EnemyText
	call PlaceString
	ld h, b
	ld l, c
	ld de, wEnemyMonNick
	; fallthrough

PlaceCommandCharacter::
	call PlaceString
	ld h, b
	ld l, c
	pop de
	inc de
	jp PlaceNextChar

TMCharText::      db "TM@"
TrainerCharText:: db "TRAINER@"
PCCharText::      db "PC@"
RocketCharText::  db "ROCKET@"
PlacePOKeText::   db "POKé@"
SixDotsCharText:: db "……@"
EnemyText::       db "Enemy @"
PlacePKMNText::   db "<PK><MN>@"
UserText::        db "user@"
OpponentText::    db "opponent@"

ContText::
	push de
	ld b, h
	ld c, l
	ld hl, ContCharText
	call TextCommandProcessor
	ld h, b
	ld l, c
	pop de
	inc de
	jp PlaceNextChar

ContCharText::
	text_far _ContCharText
	text_end

PlaceDexEnd::
	ld [hl], "."
	pop hl
	ret

PromptText::
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jp z, .ok
	ld a, "▼"
	ldcoord_a 18, 16
.ok
	call ProtectedDelay3
	call ManualTextScroll
	ld a, " "
	ldcoord_a 18, 16

DoneText::
	pop hl
	ld de, .stop
	dec de
	ret

.stop:
	text_end

TextScriptPromptButton::
	text_promptbutton
	text_end

Paragraph::
	push de
	ld a, "▼"
	ldcoord_a 18, 16
	call ProtectedDelay3
	call ManualTextScroll
	hlcoord 1, 13
	lb bc, 4, 18
	call ClearScreenArea
	ld c, 20
	rst _DelayFrames
	pop de
	hlcoord 1, 14
	jp NextChar

PageChar::
	push de
	ld a, "▼"
	ldcoord_a 18, 16
	call ProtectedDelay3
	call ManualTextScroll
	hlcoord 1, 10
	lb bc, 7, 18
	call ClearScreenArea
	ld c, 20
	rst _DelayFrames
	pop de
	pop hl
	hlcoord 1, 11
	push hl
	jp NextChar

;;;;;;;;; PureRGBnote: ADDED: new text command that allows multiple buttons to be watched while waiting on a text prompt 
MultiButtonPageChar::
	push de
	callfar TextCommandPromptMultiButton
	; d = what to do after this
	ld a, d
	and a
	jr nz, .exit
	pop de
	pop hl
	hlcoord 1, 11
	push hl
	jp NextChar
.exit
	pop de
	jp DoneText
;;;;;;;;;

_ContText::
	ld a, "▼"
	ldcoord_a 18, 16
	call ProtectedDelay3
	push de
	call ManualTextScroll
	pop de
	ld a, " "
	ldcoord_a 18, 16
_ContTextNoPause::
	push de
	call ScrollTextUpOneLine
	call ScrollTextUpOneLine
	hlcoord 1, 16
	pop de
	jp NextChar

; move both rows of text in the normal text box up one row
; always called twice in a row
; first time, copy the two rows of text to the "in between" rows that are usually emtpy
; second time, copy the bottom row of text into the top row of text
ScrollTextUpOneLine::
	hlcoord 0, 14 ; top row of text
	decoord 0, 13 ; empty line above text
	ld b, SCREEN_WIDTH * 3
.copyText
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .copyText
	hlcoord 1, 16
	ld a, " "
	ld b, SCREEN_WIDTH - 2
.clearText
	ld [hli], a
	dec b
	jr nz, .clearText

	ld b, 5
.WaitFrame
	rst _DelayFrame
	dec b
	jr nz, .WaitFrame

	ret

ProtectedDelay3::
	push bc
	call Delay3
	pop bc
	ret

TextCommandProcessor::
	ld a, [wLetterPrintingDelayFlags]
	push af
	set 1, a
	ld e, a
	ldh a, [hClearLetterPrintingDelayFlags]
	xor e
	ld [wLetterPrintingDelayFlags], a
	ld a, c
	ld [wTextDest], a
	ld a, b
	ld [wTextDest + 1], a

NextTextCommand::
	ld a, [hli]
	cp TX_END
	jr nz, .TextCommand
.NoNextTextCommand:
	pop af
	ld [wLetterPrintingDelayFlags], a
	ret

.TextCommand:
	push hl
	cp TX_FAR
	jp z, TextCommand_FAR
	cp TX_SOUND_POKEDEX_RATING
	jp nc, TextCommand_SOUND
	ld hl, TextCommandJumpTable
	push bc
	add a
	ld b, 0
	ld c, a
	add hl, bc
	pop bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

TextCommand_BOX::
; draw a box (height, width)
	pop hl
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	push hl
	ld h, d
	ld l, e
	call TextBoxBorder
	pop hl
	jr NextTextCommand

TextCommand_START_storeFlags:
	ld a, [wLetterPrintingDelayFlags]
	push af
	jr TextCommand_START_noPop

TextCommand_START::
; write text until "@"
	pop hl
TextCommand_START_noPop::
	ld d, h
	ld e, l
	ld h, b
	ld l, c
	call PlaceString
	ld h, d
	ld l, e
	inc hl
	jr NextTextCommand

TextCommand_RAM::
; write text from a ram address (little endian)
	pop hl
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	push hl
	ld h, b
	ld l, c
	call PlaceString
	pop hl
	jr NextTextCommand

TextCommand_BCD::
; write bcd from address, typically ram
	pop hl
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	push hl
	ld h, b
	ld l, c
	ld c, a
	call PrintBCDNumber
	ld b, h
	ld c, l
	pop hl
	jr NextTextCommand

; PureRGBnote: ADDED: jump to a different address in the same text bank so we can reuse text
TextCommand_JUMP::
	pop hl
	hl_deref
	push hl
	jr TextCommand_START

; PureRGBnote: ADDED: call different text in the same bank then come back
TextCommand_CALL::
	pop hl
	push hl
	hl_deref
	ResetEvent FLAG_INTERRUPTED_TEXT
	call TextCommand_START_storeFlags
	ld b, h
	ld c, l
	pop hl
	CheckEvent FLAG_INTERRUPTED_TEXT
	jp nz, NextTextCommand.NoNextTextCommand
	; inc hl twice to increment past the text_call address
	inc hl
	inc hl
	jp TextCommand_START_noPop ; assumes after returning from call we will

TextCommand_MOVE::
; move to a new tile
	pop hl
	ld a, [hli]
	ld [wTextDest], a
	ld c, a
	ld a, [hli]
	ld [wTextDest + 1], a
	ld b, a
	jp NextTextCommand

TextCommand_LOW::
; write text at (1,16)
	pop hl
	bccoord 1, 16 ; second line of dialogue text box
	jp NextTextCommand

TextCommand_PROMPT_BUTTON::
; wait for button press; show arrow
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jp z, TextCommand_WAIT_BUTTON
	ld a, "▼"
	ldcoord_a 18, 16 ; place down arrow in lower right corner of dialogue text box
	push bc
	call ManualTextScroll ; blink arrow and wait for A or B to be pressed
	pop bc
	ld a, " "
	ldcoord_a 18, 16 ; overwrite down arrow with blank space
	pop hl
	jp NextTextCommand

TextCommand_SCROLL::
; pushes text up two lines and sets the BC cursor to the border tile
; below the first character column of the text box.
	ld a, " "
	ldcoord_a 18, 16 ; place blank space in lower right corner of dialogue text box
	call ScrollTextUpOneLine
	call ScrollTextUpOneLine
	pop hl
	bccoord 1, 16 ; second line of dialogue text box
	jp NextTextCommand

TextCommand_START_ASM::
; run assembly code
	pop hl
	ld de, NextTextCommand
	push de
	jp hl

TextCommand_NUM::
; print a number
	pop hl
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	push hl
	ld h, b
	ld l, c
	ld b, a
	and $0f
	ld c, a
	ld a, b
	and $f0
	swap a
	set BIT_LEFT_ALIGN, a
	ld b, a
	call PrintNumber
	ld b, h
	ld c, l
	pop hl
	jp NextTextCommand

TextCommand_PAUSE::
; wait for button press or 30 frames
	push bc
	call Joypad
	ldh a, [hJoyHeld]
	and A_BUTTON | B_BUTTON
	jr nz, .done
	ld c, 30 ; half a second
	rst _DelayFrames
.done
	pop bc
	pop hl
	jp NextTextCommand

TextCommand_SOUND::
; play a sound effect from TextCommandSounds
	pop hl
	push bc
	dec hl
	ld a, [hli]
	ld b, a ; b = text command number that got us here
	push hl
	ld hl, TextCommandSounds
.loop
	ld a, [hli]
	cp b
	jr z, .play
	inc hl
	jr .loop

.play
	ld a, [hl]
	rst _PlaySound
	call WaitForSoundToFinish
	pop hl
	pop bc
	jp NextTextCommand

TextCommandSounds::
	db TX_SOUND_GET_ITEM_1,           SFX_GET_ITEM_1 ; actually plays SFX_LEVEL_UP when the battle music engine is loaded
	db TX_SOUND_CAUGHT_MON,           SFX_CAUGHT_MON
	db TX_SOUND_POKEDEX_RATING,       SFX_POKEDEX_RATING ; unused
	db TX_SOUND_GET_ITEM_1_DUPLICATE, SFX_GET_ITEM_1 ; unused
	db TX_SOUND_GET_ITEM_2,           SFX_GET_ITEM_2
	db TX_SOUND_GET_KEY_ITEM,         SFX_GET_KEY_ITEM
	db TX_SOUND_DEX_PAGE_ADDED,       SFX_DEX_PAGE_ADDED

TextCommand_DOTS::
; wait for button press or 30 frames while printing "…"s
	pop hl
	ld a, [hli]
	ld d, a
	push hl
	ld h, b
	ld l, c

.loop
	ld a, "…"
	ld [hli], a
	push de
	call Joypad
	pop de
	ldh a, [hJoyHeld] ; joypad state
	and A_BUTTON | B_BUTTON
	jr nz, .next ; if so, skip the delay
	ld c, 10
	rst _DelayFrames
.next
	dec d
	jr nz, .loop

	ld b, h
	ld c, l
	pop hl
	jp NextTextCommand

TextCommand_WAIT_BUTTON::
; wait for button press; don't show arrow
	push bc
	call ManualTextScroll
	pop bc
	pop hl
	jp NextTextCommand

TextCommand_FAR::
; write text from a different bank (little endian)
	pop hl
	ldh a, [hLoadedROMBank]
	push af

	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]

	ldh [hLoadedROMBank], a
	ld [MBC1RomBank], a

	push hl
	ld l, e
	ld h, d
	call TextCommandProcessor
	pop hl

	pop af
	ldh [hLoadedROMBank], a
	ld [MBC1RomBank], a
	jp NextTextCommand

TextCommandJumpTable::
; entries correspond to TX_* constants (see macros/scripts/text.asm)
	dw TextCommand_START         ; TX_START
	dw TextCommand_RAM           ; TX_RAM
	dw TextCommand_BCD           ; TX_BCD
	dw TextCommand_MOVE          ; TX_MOVE
	dw TextCommand_BOX           ; TX_BOX
	dw TextCommand_LOW           ; TX_LOW
	dw TextCommand_PROMPT_BUTTON ; TX_PROMPT_BUTTON
IF DEF(_DEBUG)
	dw _ContTextNoPause          ; TX_SCROLL
ELSE
	dw TextCommand_SCROLL        ; TX_SCROLL
ENDC
	dw TextCommand_START_ASM     ; TX_START_ASM
	dw TextCommand_NUM           ; TX_NUM
	dw TextCommand_PAUSE         ; TX_PAUSE
	dw TextCommand_SOUND         ; TX_SOUND_GET_ITEM_1 (also handles other TX_SOUND_* commands)
	dw TextCommand_DOTS          ; TX_DOTS
	dw TextCommand_WAIT_BUTTON   ; TX_WAIT_BUTTON
	dw TextCommand_JUMP          ; TX_JUMP
	dw TextCommand_CALL          ; TX_CALL
	; greater TX_* constants are handled directly by NextTextCommand
