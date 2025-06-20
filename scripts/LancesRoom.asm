LancesRoom_Script:
	call LanceShowOrHideEntranceBlocks
	call EnableAutoTextBoxDrawing
	ld hl, LancesRoomTrainerHeaders
	ld de, LancesRoom_ScriptPointers
	ld a, [wLancesRoomCurScript]
	call ExecuteCurMapScriptInTable
	ld [wLancesRoomCurScript], a
	ret

LanceShowOrHideEntranceBlocks:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
	CheckEvent EVENT_LANCES_ROOM_LOCK_DOOR
	jr nz, .closeEntrance
	; open entrance
	ld a, $31
	ld b, $32
	jp .setEntranceBlocks
.closeEntrance
	ld a, $72
	ld b, $73
.setEntranceBlocks
; Replaces the tile blocks so the player can't leave.
	push bc
	ld [wNewTileBlockID], a
	lb bc, 6, 2
	call .SetEntranceBlock
	pop bc
	ld a, b
	ld [wNewTileBlockID], a
	lb bc, 6, 3
.SetEntranceBlock:
	predef_jump ReplaceTileBlock

ResetLanceScript:
	xor a ; SCRIPT_LANCESROOM_DEFAULT
	ld [wLancesRoomCurScript], a
	ret

LancesRoom_ScriptPointers:
	def_script_pointers
	dw_const LancesRoomDefaultScript,               SCRIPT_LANCESROOM_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_LANCESROOM_LANCE_START_BATTLE
	dw_const LancesRoomLanceEndBattleScript,        SCRIPT_LANCESROOM_LANCE_END_BATTLE
	dw_const LancesRoomPlayerIsMovingScript,        SCRIPT_LANCESROOM_PLAYER_IS_MOVING
	dw_const DoRet,                                 SCRIPT_LANCESROOM_NOOP

LancesRoomDefaultScript:
	CheckEvent EVENT_BEAT_LANCE
	ret nz
	ld hl, LanceTriggerMovementCoords
	call ArePlayerCoordsInArray
	jp nc, CheckFightingMapTrainers
	xor a
	ldh [hJoyHeld], a
	ld a, [wCoordIndex]
	cp $3  ; Is player standing next to Lance's sprite?
	jr nc, .notStandingNextToLance
	ld a, [wGameStage] ; Check if player has beat game
	and a
	jr nz, .Rematch
	ld a, TEXT_LANCESROOM_LANCE
.continue
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID
.notStandingNextToLance
	cp $5  ; Is player standing on the entrance staircase?
	jr z, WalkToLance
	CheckAndSetEvent EVENT_LANCES_ROOM_LOCK_DOOR
	ret nz
	ld hl, wCurrentMapScriptFlags
	set 5, [hl]
	ld a, SFX_GO_INSIDE
	rst _PlaySound
	jp LanceShowOrHideEntranceBlocks
.Rematch
	ld a, TEXT_LANCESROOM_LANCE_REMATCH
	jr .continue

LanceTriggerMovementCoords:
	dbmapcoord  5,  1
	dbmapcoord  6,  2
	dbmapcoord  5, 11
	dbmapcoord  6, 11
	dbmapcoord 24, 16
	db -1 ; end

LancesRoomLanceEndBattleScript:
	call EndTrainerBattle
	ld a, [wIsInBattle]
	cp $ff
	jp z, ResetLanceScript
	ld a, [wGameStage] ; Check if player has beat game
	and a
	jr nz, .Rematch
	ld a, TEXT_LANCESROOM_LANCE
.continue
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID
.Rematch
	ld a, TEXT_LANCESROOM_LANCE_REMATCH
	jr .continue

WalkToLance:
; Moves the player down the hallway to Lance's room.
	ld a, A_BUTTON | B_BUTTON | SELECT | START | D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	ld hl, wSimulatedJoypadStatesEnd
	ld de, WalkToLance_RLEList
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
	ld a, SCRIPT_LANCESROOM_PLAYER_IS_MOVING
	ld [wLancesRoomCurScript], a
	ld [wCurMapScript], a
	ret

WalkToLance_RLEList:
	db D_UP, 12
	db D_LEFT, 12
	db D_DOWN, 7
	db D_LEFT, 6
	db -1 ; end

LancesRoomPlayerIsMovingScript:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	xor a ; SCRIPT_LANCESROOM_DEFAULT
	ld [wJoyIgnore], a
	ld [wLancesRoomCurScript], a
	ld [wCurMapScript], a
	ret

LancesRoom_TextPointers:
	def_text_pointers
	dw_const LancesRoomLanceText, TEXT_LANCESROOM_LANCE
	dw_const LancesRoomLanceRematchText, TEXT_LANCESROOM_LANCE_REMATCH

LancesRoomTrainerHeaders:
	def_trainers
LancesRoomTrainerHeader0:
	trainer EVENT_BEAT_LANCES_ROOM_TRAINER_0, 0, LancesRoomLanceBeforeBattleText, LancesRoomLanceEndBattleText, LancesRoomLanceAfterBattleText
LancesRoomTrainerHeader1:
	trainer EVENT_BEAT_LANCES_ROOM_TRAINER_1, 0, LancesRoomLanceRematchBeforeBattleText, LancesRoomLanceRematchEndBattleText, LancesRoomLanceRematchAfterBattleText
	db -1 ; end

LancesRoomLanceText:
	text_asm
	ld hl, LancesRoomTrainerHeader0
	call TalkToTrainer
	rst TextScriptEnd

LancesRoomLanceRematchText:
	text_asm
	ld hl, LancesRoomTrainerHeader1
	call TalkToTrainer
	rst TextScriptEnd

LancesRoomLanceBeforeBattleText:
	text_far _LancesRoomLanceBeforeBattleText
	text_end

LancesRoomLanceEndBattleText:
	text_far _LancesRoomLanceEndBattleText
	text_end

LancesRoomLanceAfterBattleText:
	text_far _LancesRoomLanceAfterBattleText
	text_asm
	SetEvent EVENT_BEAT_LANCE
	rst TextScriptEnd

LancesRoomLanceRematchBeforeBattleText:
	text_far _LancesRoomLanceRematchBeforeBattleText
	text_end

LancesRoomLanceRematchEndBattleText:
	text_far _LancesRoomLanceRematchEndBattleText
	text_end

LancesRoomLanceRematchAfterBattleText:
	text_far _LancesRoomLanceRematchAfterBattleText
	text_asm
	SetEvent EVENT_BEAT_LANCE
	rst TextScriptEnd

