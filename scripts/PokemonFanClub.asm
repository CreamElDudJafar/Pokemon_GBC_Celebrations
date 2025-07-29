PokemonFanClub_Script:
	jp EnableAutoTextBoxDrawing


PokemonFanClub_TextPointers:
	def_text_pointers
	dw_const PokemonFanClubPikachuFanText,   TEXT_POKEMONFANCLUB_PIKACHU_FAN
	dw_const PokemonFanClubSeelFanText,      TEXT_POKEMONFANCLUB_SEEL_FAN
	dw_const PokemonFanClubPikachuText,      TEXT_POKEMONFANCLUB_PIKACHU
	dw_const PokemonFanClubSeelText,         TEXT_POKEMONFANCLUB_SEEL
	dw_const PokemonFanClubChairmanText,     TEXT_POKEMONFANCLUB_CHAIRMAN
	dw_const PokemonFanClubReceptionistText, TEXT_POKEMONFANCLUB_RECEPTIONIST

PokemonFanClubPikachuFanText:
	text_asm
	CheckEventHL EVENT_LEFT_FANCLUB_AFTER_BIKE_VOUCHER
	jr z, .asm_59aaf
	ld hl, .yellowtext
	rst _PrintText
	jr .done

.asm_59aaf
	CheckEventReuseHL EVENT_PIKACHU_FAN_BOAST
	jr nz, .mineisbetter
	SetEventReuseHL EVENT_SEEL_FAN_BOAST
	ld hl, .normaltext
	rst _PrintText
	jr .done
.mineisbetter
	ResetEventReuseHL EVENT_PIKACHU_FAN_BOAST
	ld hl, .bettertext
	rst _PrintText
.done
	rst TextScriptEnd

.normaltext
	text_far _PokemonFanClubPikachuFanNormalText
	text_end

.bettertext
	text_far _PokemonFanClubPikachuFanBetterText
	text_end

.yellowtext
	text_far _PokemonFanClubPikachuFanText
	text_end

PokemonFanClubSeelFanText:
	text_asm
	CheckEventHL EVENT_LEFT_FANCLUB_AFTER_BIKE_VOUCHER
	jr z, .asm_59ae7
	ld hl, .yellowtext
	rst _PrintText
	jr .done

.asm_59ae7
	CheckEventReuseHL EVENT_SEEL_FAN_BOAST
	jr nz, .mineisbetter
	SetEventReuseHL EVENT_PIKACHU_FAN_BOAST
	ld hl, .normaltext
	rst _PrintText
	jr .done
.mineisbetter
	ResetEventReuseHL EVENT_SEEL_FAN_BOAST
	ld hl, .bettertext
	rst _PrintText
.done
	rst TextScriptEnd

.normaltext
	text_far _PokemonFanClubSeelFanNormalText
	text_end

.bettertext
	text_far _PokemonFanClubSeelFanBetterText
	text_end

.yellowtext
	text_far _PokemonFanClubSeelFanText
	text_end

PokemonFanClubPikachuText:
	text_asm
	ld hl, .Text
	rst _PrintText
	ld a, PIKACHU
	call PlayCry
	call WaitForSoundToFinish
	rst TextScriptEnd

.Text
	text_far _PokemonFanClubPikachuText
	text_end

PokemonFanClubSeelText:
	text_asm
	ld hl, .Text
	rst _PrintText
	ld a, SEEL
	call PlayCry
	call WaitForSoundToFinish
	rst TextScriptEnd

.Text:
	text_far _PokemonFanClubSeelText
	text_end

PokemonFanClubChairmanText:
	text_asm
	CheckEventHL EVENT_LEFT_FANCLUB_AFTER_BIKE_VOUCHER
	jr z, .check_bike_voucher
	ld hl, Text_59c1f
	rst _PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .select_mon_to_print
	ld hl, Text_59c24
	jr .gbpals_print_text

.check_bike_voucher
	CheckEvent EVENT_GOT_BIKE_VOUCHER
	jr nz, .nothingleft
	ld hl, .IntroText
	rst _PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .nothanks

	; tell the story
	ld hl, .StoryText
	rst _PrintText
	lb bc, BIKE_VOUCHER, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, .BikeVoucherText
	rst _PrintText
	SetEvent EVENT_GOT_BIKE_VOUCHER
	rst TextScriptEnd
.bag_full
	ld hl, .BagFullText
	jr .gbpals_print_text
.nothanks
	ld hl, .NoStoryText
	jr .gbpals_print_text
.nothingleft
	ld hl, .FinalText
.gbpals_print_text
	push hl
	call LoadGBPal
	pop hl
	rst _PrintText
	rst TextScriptEnd

.select_mon_to_print
	call GBPalWhiteOutWithDelay3
	call LoadCurrentMapView
	call SaveScreenTilesToBuffer2
	ld a, $ff
	ld [wUpdateSpritesEnabled], a
	ld a, $00
	ld [wTempTilesetNumTiles], a
	call DisplayPartyMenu
	jp nc, .print
	call GBPalWhiteOutWithDelay3
	call RestoreScreenTilesAndReloadTilePatterns
	ld hl, Text_59c24
	jr .gbpals_print_text

.print
	xor a
	ld [wUpdateSpritesEnabled], a
	ld hl, wd730
	set 6, [hl]
	callfar PrintFanClubPortrait
	ld hl, wd730
	res 6, [hl]
	call GBPalWhiteOutWithDelay3
	call ReloadTilesetTilePatterns
	call RestoreScreenTilesAndReloadTilePatterns
	call LoadScreenTilesFromBuffer2
	call Delay3
	call GBPalNormal
	ld hl, Text_59c2e
	ldh a, [hOaksAideResult]
	and a
	jr nz, .gbpals_print_text
	ld hl, Text_59c29
	jr .gbpals_print_text

.IntroText:
	text_far _PokemonFanClubChairmanIntroText
	text_end

.StoryText:
	text_far _PokemonFanClubChairmanStoryText
	text_end

.BikeVoucherText:
	text_far _PokemonFanClubReceivedBikeVoucherText
	sound_get_key_item
	text_far _PokemonFanClubExplainBikeVoucherText
	text_end

.NoStoryText:
	text_far _PokemonFanClubNoStoryText
	text_end

.FinalText:
	text_far _PokemonFanClubChairFinalText
	text_end

.BagFullText:
	text_far _PokemonFanClubBagFullText
	text_end

Text_59c1f:
	text_far FanClubChairPrintText1
	text_end

Text_59c24:
	text_far FanClubChairPrintText2
	text_end

Text_59c29:
	text_far FanClubChairPrintText3
	text_end

Text_59c2e:
	text_far FanClubChairPrintText4
	text_end

PokemonFanClubReceptionistText:
	text_far _PokemonFanClubReceptionistText
	text_end