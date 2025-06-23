VermilionCityPrintOfficerJennyText::
	CheckEvent EVENT_GOT_SQUIRTLE_FROM_OFFICER_JENNY
	jr nz, .asm_f1a69
	ld a, [wBeatGymFlags]
	bit 2, a ; THUNDERBADGE
	jr nz, .asm_f1a24
	ld hl, OfficerJennyText1
	rst _PrintText
	ret

.asm_f1a24
	ld hl, OfficerJennyText2
	rst _PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .asm_f1a62
	ld a, SQUIRTLE
	ld [wd11e], a
	ld [wcf91], a
	call GetMonName
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	lb bc, SQUIRTLE, 15
	call GivePokemon
	ret nc
	ld a, [wAddedToParty]
	and a
	call z, WaitForTextScrollButtonPress
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, OfficerJennyText3
	rst _PrintText
	SetEvent EVENT_GOT_SQUIRTLE_FROM_OFFICER_JENNY
	ret

.asm_f1a62
	ld hl, OfficerJennyText4
	rst _PrintText
	ret

.asm_f1a69
	; jenny post game fight
	ld a, [wGameStage] ; Check if player has beat the game
	and a
	jr z, .squirtleText
	; CheckEvent EVENT_BEAT_JENNY ; uncomment if you don't want the ability to rematch
	; jr nz, .squirtleText

	ld hl, JennyPreBattleText
	rst _PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .refused

	ld hl, JennyAcceptedText
	call PrintText
	call Delay3
	ld a, OPP_JENNY
	ld [wCurOpponent], a
	ld a, 1
	ld [wTrainerNo], a
	ld a, SCRIPT_VERMILIONCITY_JENNY_POST_BATTLE
	ld [wVermilionCityCurScript], a
	ld [wCurMapScript], a
	jr .done
.refused
	ld hl, JennyRefusedText
	rst _PrintText
	jr .done
.squirtleText
	ld hl, OfficerJennyText5
	rst _PrintText
.done
	ret

JennyPreBattleText:
	text_far _JennyBattleText
	text_end

JennyRefusedText:
	text_far _JennyRefusedText
	text_end

JennyAcceptedText:
	text_far _JennyAcceptedText
	text_end

OfficerJennyText1:
	text_far _OfficerJennyText1
	text_end

OfficerJennyText2:
	text_far _OfficerJennyText2
	text_end

OfficerJennyText3:
	text_far _OfficerJennyText3
	text_waitbutton
	text_end

OfficerJennyText4:
	text_far _OfficerJennyText4
	text_end

OfficerJennyText5:
	text_far _OfficerJennyText5
	text_end