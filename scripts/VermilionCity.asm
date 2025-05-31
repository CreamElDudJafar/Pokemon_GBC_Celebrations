VermilionCity_Script:
	call EnableAutoTextBoxDrawing
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	push hl
	call nz, VermilionCityLeftSSAnneCallbackScript
	pop hl
	bit 5, [hl]
	res 5, [hl]
	call nz, .setFirstLockTrashCanIndex
	ld hl, VermilionCity_ScriptPointers
	ld a, [wVermilionCityCurScript]
	jp CallFunctionInTable

.setFirstLockTrashCanIndex
	call Random
	ldh a, [hRandomSub]
	and $e
	ld [wFirstLockTrashCanIndex], a
	ret

VermilionCityLeftSSAnneCallbackScript:
	CheckEventHL EVENT_SS_ANNE_LEFT
	ret z
	CheckEventReuseHL EVENT_WALKED_PAST_GUARD_AFTER_SS_ANNE_LEFT
	SetEventReuseHL EVENT_WALKED_PAST_GUARD_AFTER_SS_ANNE_LEFT
	ret nz
	ld a, SCRIPT_VERMILIONCITY_PLAYER_EXIT_SHIP
	ld [wVermilionCityCurScript], a
	ret

VermilionCity_ScriptPointers:
	def_script_pointers
	dw_const VermilionCityDefaultScript,             SCRIPT_VERMILIONCITY_DEFAULT
	dw_const VermilionCityPlayerMovingUp1Script,     SCRIPT_VERMILIONCITY_PLAYER_MOVING_UP1
	dw_const VermilionCityPlayerExitShipScript,      SCRIPT_VERMILIONCITY_PLAYER_EXIT_SHIP
	dw_const VermilionCityPlayerMovingUp2Script,     SCRIPT_VERMILIONCITY_PLAYER_MOVING_UP2
	dw_const VermilionCityPlayerAllowedToPassScript, SCRIPT_VERMILIONCITY_PLAYER_ALLOWED_TO_PASS

VermilionCityDefaultScript:
	ld a, [wObtainedBadges]
    	bit BIT_MARSHBADGE, a
    	ret nz
	ld a, [wSpritePlayerStateData1FacingDirection]
	and a ; cp SPRITE_FACING_DOWN
	ret nz
	ld hl, SSAnneTicketCheckCoords
	call ArePlayerCoordsInArray
	ret nc
	xor a
	ldh [hJoyHeld], a
	ld [wSavedCoordIndex], a ; unnecessary
	ld a, TEXT_VERMILIONCITY_SAILOR1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	CheckEvent EVENT_SS_ANNE_LEFT
	jr nz, .ship_departed
	ld b, S_S_TICKET
	predef GetQuantityOfItemInBag
	ld a, b
	and a
	ret nz
.ship_departed
	ld a, D_UP
	ld [wSimulatedJoypadStatesEnd], a
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
	ld a, SCRIPT_VERMILIONCITY_PLAYER_MOVING_UP1
	ld [wVermilionCityCurScript], a
	ret

SSAnneTicketCheckCoords:
	dbmapcoord 18, 30
	db -1 ; end

VermilionCityPlayerAllowedToPassScript:
	ld hl, SSAnneTicketCheckCoords
	call ArePlayerCoordsInArray
	ret c
	ld a, SCRIPT_VERMILIONCITY_DEFAULT
	ld [wVermilionCityCurScript], a
	ret

VermilionCityPlayerExitShipScript:
	ld a, A_BUTTON | B_BUTTON | SELECT | START | D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	ld a, D_UP
	ld [wSimulatedJoypadStatesEnd], a
	ld [wSimulatedJoypadStatesEnd + 1], a
	ld a, 2
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
	ld a, SCRIPT_VERMILIONCITY_PLAYER_MOVING_UP2
	ld [wVermilionCityCurScript], a
	ret

VermilionCityPlayerMovingUp2Script:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ldh [hJoyHeld], a
	ld a, SCRIPT_VERMILIONCITY_DEFAULT
	ld [wVermilionCityCurScript], a
	ret

VermilionCityPlayerMovingUp1Script:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	ld c, 10
	rst _DelayFrames
	ld a, SCRIPT_VERMILIONCITY_DEFAULT
	ld [wVermilionCityCurScript], a
	ret

VermilionCity_TextPointers:
	def_text_pointers
	dw_const VermilionCityBeautyText,             TEXT_VERMILIONCITY_BEAUTY
	dw_const VermilionCityGambler1Text,           TEXT_VERMILIONCITY_GAMBLER1
	dw_const VermilionCitySailor1Text,            TEXT_VERMILIONCITY_SAILOR1
	dw_const VermilionCityGambler2Text,           TEXT_VERMILIONCITY_GAMBLER2
	dw_const VermilionCityMachopText,             TEXT_VERMILIONCITY_MACHOP
	dw_const VermilionCitySailor2Text,            TEXT_VERMILIONCITY_SAILOR2
	dw_const VermilionCityOfficerJennyText,       TEXT_VERMILIONCITY_OFFICER_JENNY
	dw_const VermilionCitySignText,               TEXT_VERMILIONCITY_SIGN
	dw_const VermilionCityNoticeSignText,         TEXT_VERMILIONCITY_NOTICE_SIGN
	dw_const MartSignText,                        TEXT_VERMILIONCITY_MART_SIGN
	dw_const PokeCenterSignText,                  TEXT_VERMILIONCITY_POKECENTER_SIGN
	dw_const VermilionCityPokemonFanClubSignText, TEXT_VERMILIONCITY_POKEMON_FAN_CLUB_SIGN
	dw_const VermilionCityGymSignText,            TEXT_VERMILIONCITY_GYM_SIGN
	dw_const VermilionCityHarborSignText,         TEXT_VERMILIONCITY_HARBOR_SIGN

VermilionCityBeautyText:
	text_far _VermilionCityBeautyText
	text_end

VermilionCityGambler1Text:
	text_asm
	CheckEvent EVENT_SS_ANNE_LEFT
	jr nz, .ship_departed
	ld hl, .DidYouSeeText
	rst _PrintText
	jr .text_script_end
.ship_departed
	ld hl, .SSAnneDepartedText
	rst _PrintText
.text_script_end
	rst TextScriptEnd

.DidYouSeeText:
	text_far _VermilionCityGambler1DidYouSeeText
	text_end

.SSAnneDepartedText:
	text_far _VermilionCityGambler1SSAnneDepartedText
	text_end

VermilionCitySailor1Text:
	text_asm
	ld a, [wObtainedBadges]
	bit BIT_MARSHBADGE, a ; Changed after marshbadge to have ship return	
	jr nz, .default
	CheckEvent EVENT_SS_ANNE_LEFT
	jr nz, .ship_departed
.default
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_RIGHT
	jr z, .greet_player
	ld hl, .inFrontOfOrBehindGuardCoords
	call ArePlayerCoordsInArray
	jr nc, .greet_player_and_check_ticket
.greet_player
	ld hl, .WelcomeToSSAnneText
	rst _PrintText
	jr .end
.greet_player_and_check_ticket
	ld hl, .DoYouHaveATicketText
	rst _PrintText
	ld b, S_S_TICKET
	predef GetQuantityOfItemInBag
	ld a, b
	and a
	jr nz, .player_has_ticket
	ld hl, .YouNeedATicketText
	rst _PrintText
	jr .end
.player_has_ticket
	ld hl, .FlashedTicketText
	rst _PrintText
	ld a, SCRIPT_VERMILIONCITY_PLAYER_ALLOWED_TO_PASS
	ld [wVermilionCityCurScript], a
	jr .end
.ship_departed
	ld hl, .ShipSetSailText
	rst _PrintText
.end
	rst TextScriptEnd

.inFrontOfOrBehindGuardCoords
	dbmapcoord 19, 29 ; in front of guard
	dbmapcoord 19, 31 ; behind guard
	db -1 ; end

.WelcomeToSSAnneText:
	text_far _VermilionCitySailor1WelcomeToSSAnneText
	text_end

.DoYouHaveATicketText:
	text_far _VermilionCitySailor1DoYouHaveATicketText
	text_end

.FlashedTicketText:
	text_far _VermilionCitySailor1FlashedTicketText
	text_end

.YouNeedATicketText:
	text_far _VermilionCitySailor1YouNeedATicketText
	text_end

.ShipSetSailText:
	text_far _VermilionCitySailor1ShipSetSailText
	text_end
	
VermilionCityGambler2Text:
	text_far _VermilionCityGambler2Text
	text_end

VermilionCityMachopText:
	text_far _VermilionCityMachopText
	text_asm
	ld a, MACHOP
	call PlayCry
	call WaitForSoundToFinish
	ld hl, .StompingTheLandFlatText
	ret

.StompingTheLandFlatText:
	text_far _VermilionCityMachopStompingTheLandFlatText
	text_end

VermilionCitySailor2Text:
	text_asm
	ld a, [wObtainedBadges]
	bit BIT_MARSHBADGE, a ; after marshbadge ships returns
	jr z, .default
	ld hl, .ShipBackText
	ret
.default
	ld hl, .Text
	ret

.Text:
	text_far _VermilionCitySailor2Text
	text_end

.ShipBackText:
	text_far _VermillionCityText15
	text_end

VermilionCitySignText:
	text_far _VermilionCitySignText
	text_end

VermilionCityNoticeSignText:
	text_far _VermilionCityNoticeSignText
	text_end

VermilionCityPokemonFanClubSignText:
	text_far _VermilionCityPokemonFanClubSignText
	text_end

VermilionCityGymSignText:
	text_far _VermilionCityGymSignText
	text_end

VermilionCityHarborSignText:
	text_far _VermilionCityHarborSignText
	text_end


VermilionCityOfficerJennyText:
	text_asm
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	CheckEvent EVENT_GOT_SQUIRTLE_FROM_OFFICER_JENNY
	jr nz, .asm_1cfbf
	ld hl, OfficerJennyText_1cfc8
	rst _PrintText
	ld a, [wObtainedBadges]
	bit 2, a ;  ; THUNDER BADGE
	jr z,  .asm_1cfb3
	ld hl, OfficerJennyText_1cfce
	rst _PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .asm_1cfb6
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld a, SQUIRTLE
	ld [wd11e], a
	ld [wcf91], a
	call GetMonName
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	lb bc, SQUIRTLE, 10
	call GivePokemon
	jr nc, .asm_1cfb3
	ld a, [wAddedToParty]
	and a
	call z, WaitForTextScrollButtonPress
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, OfficerJennyText_1cfd3
	rst _PrintText
	SetEvent EVENT_GOT_SQUIRTLE_FROM_OFFICER_JENNY
.asm_1cfb3
	rst TextScriptEnd

.asm_1cfb6
	ld hl, OfficerJennyText_1cfdf
	rst _PrintText
	rst TextScriptEnd

.asm_1cfbf
	ld hl, OfficerJennyText_1cfd9
	call PrintText
	rst TextScriptEnd

OfficerJennyText_1cfc8:
	text_far _OfficerJennyText1
	text_waitbutton
	text_end

OfficerJennyText_1cfce:
	text_far _OfficerJennyText2
	text_end

OfficerJennyText_1cfd3:
	text_far _OfficerJennyText3
	text_waitbutton
	text_end

OfficerJennyText_1cfd9:
	text_far _OfficerJennyText4
	text_waitbutton
	text_end

OfficerJennyText_1cfdf:
	text_far _OfficerJennyText5
	text_waitbutton
	text_end