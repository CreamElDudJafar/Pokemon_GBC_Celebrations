DoInGameTradeDialogue:
; trigger the trade offer/action specified by wWhichTrade
	call SaveScreenTilesToBuffer2
	ld hl, TradeMons
	ld a, [wWhichTrade]
	ld b, a
	swap a
	sub b
	sub b
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hli]
	ld [wInGameTradeGiveMonSpecies], a
	ld a, [hli]
	ld [wInGameTradeReceiveMonSpecies], a
	ld a, [hli]
	push af
	ld de, wInGameTradeMonNick
	ld bc, NAME_LENGTH
	rst _CopyData
	pop af
	ld l, a
	ld h, 0
	ld de, InGameTradeTextPointers
	add hl, hl
	add hl, de
	ld a, [hli]
	ld [wInGameTradeTextPointerTablePointer], a
	ld a, [hl]
	ld [wInGameTradeTextPointerTablePointer + 1], a
	ld a, [wInGameTradeGiveMonSpecies]
	ld de, wInGameTradeGiveMonName
	call InGameTrade_GetMonName
	ld a, [wInGameTradeReceiveMonSpecies]
	ld de, wInGameTradeReceiveMonName
	call InGameTrade_GetMonName
	ld hl, wCompletedInGameTradeFlags
	ld a, [wWhichTrade]
	ld c, a
	ld b, FLAG_TEST
	predef FlagActionPredef
	ld a, c
	and a
	ld a, $4
	ld [wInGameTradeTextPointerTableIndex], a
	jr nz, .printText
; if the trade hasn't been done yet
	xor a
	ld [wInGameTradeTextPointerTableIndex], a
	call .printText
	ld a, $1
	ld [wInGameTradeTextPointerTableIndex], a
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .printText
	call InGameTrade_DoTrade
	jr c, .printText
	ld a, [wInGameTradeGiveMonSpecies]
	cp NO_MON
	jr z, .printText
	ld hl, TradedForText
	rst _PrintText
.printText
	ld hl, wInGameTradeTextPointerTableIndex
	ld a, [hld] ; wInGameTradeTextPointerTableIndex
	ld e, a
	ld d, 0
	ld a, [hld] ; wInGameTradeTextPointerTablePointer + 1
	ld l, [hl] ; wInGameTradeTextPointerTablePointer
	ld h, a
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp PrintText

; copies name of species a to hl
InGameTrade_GetMonName:
	push de
	ld [wd11e], a
	call GetMonName
	ld hl, wcd6d
	pop de
	ld bc, NAME_LENGTH
	jp CopyData

INCLUDE "data/events/trades.asm"

InGameTrade_DoTrade:
	xor a ; NORMAL_PARTY_MENU
	ld [wPartyMenuTypeOrMessageID], a
	dec a
	ld [wUpdateSpritesEnabled], a
	call DisplayPartyMenu
	push af
	call InGameTrade_RestoreScreen
	pop af
	ld a, $1
	jp c, .tradeFailed ; jump if the player didn't select a pokemon
	ld a, [wInGameTradeGiveMonSpecies]
	cp NO_MON
	jr z, .skip_mon_check
	ld b, a
	ld a, [wcf91]
	cp b
	ld a, $2
	jp nz, .tradeFailed ; jump if the selected mon's species is not the required one
.skip_mon_check
	ld a, [wWhichPokemon]
	ld hl, wPartyMon1Level
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	ld a, [hl]
	ld [wCurEnemyLVL], a
	ld a, [wInGameTradeGiveMonSpecies]
	cp NO_MON
	jr z, .skip_flag_set
	ld hl, wCompletedInGameTradeFlags
	ld a, [wWhichTrade]
	ld c, a
	ld b, FLAG_SET
	predef FlagActionPredef
.skip_flag_set
	ld hl, ConnectCableText
	rst _PrintText
	ld a, [wWhichPokemon]
	push af
	ld a, [wCurEnemyLVL]
	push af
	call LoadHpBarAndStatusTilePatterns
	ld a, [wInGameTradeGiveMonSpecies]
	cp NO_MON
	jr nz, .normal_in_game_trade_data
	call TradeSelf_PrepareTradeData
	jr .self_trade_data
.normal_in_game_trade_data
	call InGameTrade_PrepareTradeData
.self_trade_data
	predef InternalClockTradeAnim
	pop af
	ld [wCurEnemyLVL], a
	pop af
	ld [wWhichPokemon], a
	ld a, [wInGameTradeReceiveMonSpecies]
	ld [wcf91], a
	xor a
	push af
	ld a, [wInGameTradeGiveMonSpecies]
	cp NO_MON
	jr z, .skip_swap_mons
	pop af
	ld [wRemoveMonFromBox], a
	call RemovePokemon
	ld a, %10000000 ; prevent the player from naming the mon
	ld [wMonDataLocation], a
	call AddPartyMon
	call InGameTrade_CopyDataToReceivedMon
	ld a, [wPartyCount]
	dec a
	ld [wWhichPokemon], a
.skip_swap_mons
	callfar EvolveTradeMon
	call ClearScreen
	call InGameTrade_RestoreScreen
	farcall RedrawMapView
	and a
	ld a, $3
	jr .tradeSucceeded
.tradeFailed
	scf
.tradeSucceeded
	ld [wInGameTradeTextPointerTableIndex], a
	ret

InGameTrade_RestoreScreen:
	call GBPalWhiteOutWithDelay3
	call RestoreScreenTilesAndReloadTilePatterns
	call ReloadTilesetTilePatterns
	call LoadScreenTilesFromBuffer2
	call Delay3
	call LoadGBPal
	ld c, 10
	rst _DelayFrames
	farjp LoadWildData
	
TradeSelf_PrepareTradeData:
	ld a, [wWhichPokemon]
	ld hl, wPartySpecies
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wTradedPlayerMonSpecies], a
	ld [wInGameTradeReceiveMonSpecies], a
	ld hl, wTradedPlayerMonSpecies
	jr InGameTrade_PrepareTradeData.loaded_self_trade_instead

InGameTrade_PrepareTradeData:
	ld hl, wTradedPlayerMonSpecies
	ld a, [wInGameTradeGiveMonSpecies]
.loaded_self_trade_instead
	ld [hli], a ; wTradedPlayerMonSpecies
	ld a, [wInGameTradeReceiveMonSpecies]
	ld [hl], a ; wTradedEnemyMonSpecies
	ld hl, wPartyMonOT
	ld bc, NAME_LENGTH
	ld a, [wWhichPokemon]
	call AddNTimes
	ld de, wTradedPlayerMonOT
	ld bc, NAME_LENGTH
	call InGameTrade_CopyData
	ld hl, InGameTrade_TrainerString
	ld de, wTradedEnemyMonOT
	call InGameTrade_CopyData
	ld de, wLinkEnemyTrainerName
	call InGameTrade_CopyData
	ld hl, wPartyMon1OTID
	ld bc, wPartyMon2 - wPartyMon1
	ld a, [wWhichPokemon]
	call AddNTimes
	ld de, wTradedPlayerMonOTID
	ld bc, $2
	call InGameTrade_CopyData
	call Random
	ld hl, hRandomAdd
	ld de, wTradedEnemyMonOTID
	jp CopyData

InGameTrade_CopyData:
	push hl
	push bc
	rst _CopyData
	pop bc
	pop hl
	ret

InGameTrade_CopyDataToReceivedMon:
	ld hl, wPartyMonNicks
	ld bc, NAME_LENGTH
	call InGameTrade_GetReceivedMonPointer
	ld hl, wInGameTradeMonNick
	ld bc, NAME_LENGTH
	rst _CopyData
	ld hl, wPartyMonOT
	ld bc, NAME_LENGTH
	call InGameTrade_GetReceivedMonPointer
	ld hl, InGameTrade_TrainerString
	ld bc, NAME_LENGTH
	rst _CopyData
	ld hl, wPartyMon1OTID
	ld bc, wPartyMon2 - wPartyMon1
	call InGameTrade_GetReceivedMonPointer
	ld hl, wTradedEnemyMonOTID
	ld bc, $2
	jp CopyData

; the received mon's index is (partyCount - 1),
; so this adds bc to hl (partyCount - 1) times and moves the result to de
InGameTrade_GetReceivedMonPointer:
	ld a, [wPartyCount]
	dec a
	call AddNTimes
	ld e, l
	ld d, h
	ret

InGameTrade_TrainerString:
	db "<TRAINER>@@@@@@@@@@"

InGameTradeTextPointers:
; entries correspond to TRADE_DIALOGSET_* constants
	dw TradeTextPointers1
	dw TradeTextPointers2
	dw TradeTextPointers3
	dw TradeTextPointers4

TradeTextPointers1:
	dw WannaTrade1Text
	dw NoTrade1Text
	dw WrongMon1Text
	dw Thanks1Text
	dw AfterTrade1Text

TradeTextPointers2:
	dw WannaTrade2Text
	dw NoTrade2Text
	dw WrongMon2Text
	dw Thanks2Text
	dw AfterTrade2Text

TradeTextPointers3:
	dw WannaTrade3Text
	dw NoTrade3Text
	dw WrongMon3Text
	dw Thanks3Text
	dw AfterTrade3Text
	
TradeTextPointers4:
	dw WannaTrade4Text
	dw NoTrade4Text
	dw WrongMon1Text
	dw Thanks4Text
	dw AfterTrade1Text

ConnectCableText:
	text_far _ConnectCableText
	text_end

TradedForText:
	text_far _TradedForText
	sound_get_key_item
	text_pause
	text_end

WannaTrade1Text:
	text_far _WannaTrade1Text
	text_end

NoTrade1Text:
	text_far _NoTrade1Text
	text_end

WrongMon1Text:
	text_far _WrongMon1Text
	text_end

Thanks1Text:
	text_far _Thanks1Text
	text_end

AfterTrade1Text:
	text_far _AfterTrade1Text
	text_end

WannaTrade2Text:
	text_far _WannaTrade2Text
	text_end

NoTrade2Text:
	text_far _NoTrade2Text
	text_end

WrongMon2Text:
	text_far _WrongMon2Text
	text_end

Thanks2Text:
	text_far _Thanks2Text
	text_end

AfterTrade2Text:
	text_far _AfterTrade2Text
	text_end

WannaTrade3Text:
	text_far _WannaTrade3Text
	text_end

NoTrade3Text:
	text_far _NoTrade3Text
	text_end

WrongMon3Text:
	text_far _WrongMon3Text
	text_end

Thanks3Text:
	text_far _Thanks3Text
	text_end

AfterTrade3Text:
	text_far _AfterTrade3Text
	text_end
	
WannaTrade4Text:
	text_far _WannaTrade4Text
	text_end
	
NoTrade4Text:
	text_far _NoTrade4Text
	text_end
	
Thanks4Text:
	text_far _Thanks4Text
	text_end