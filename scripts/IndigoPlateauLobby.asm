IndigoPlateauLobby_Script:
	call SetLastBlackoutMap
	call Serial_TryEstablishingExternallyClockedConnection
	call EnableAutoTextBoxDrawing
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	ret z
	ResetEvent EVENT_VICTORY_ROAD_1_BOULDER_ON_SWITCH
	ld hl, wBeatLorelei
	bit 1, [hl]
	res 1, [hl]
	ret z
	; Elite 4 events
	ResetEventRange INDIGO_PLATEAU_EVENTS_START, EVENT_LANCES_ROOM_LOCK_DOOR
	ret

IndigoPlateauLobby_TextPointers:
	def_text_pointers
	dw_const IndigoPlateauLobbyNurseText,            TEXT_INDIGOPLATEAULOBBY_NURSE
	dw_const IndigoPlateauLobbyGymGuideText,         TEXT_INDIGOPLATEAULOBBY_GYM_GUIDE
	dw_const IndigoPlateauLobbyCooltrainerFText,     TEXT_INDIGOPLATEAULOBBY_COOLTRAINER_F
	dw_const IndigoPlateauLobbyClerkText,            TEXT_INDIGOPLATEAULOBBY_CLERK
	dw_const IndigoPlateauLobbyPostGameClerkText,    TEXT_INDIGOPLATEAULOBBY_POST_GAME_CLERK
	dw_const IndigoPlateauLobbyLinkReceptionistText, TEXT_INDIGOPLATEAULOBBY_LINK_RECEPTIONIST

IndigoPlateauLobbyNurseText:
	script_pokecenter_nurse

IndigoPlateauLobbyGymGuideText:
	text_far _IndigoPlateauLobbyGymGuideText
	text_end

IndigoPlateauLobbyCooltrainerFText:
	text_far _IndigoPlateauLobbyCooltrainerFText
	text_end

IndigoPlateauLobbyLinkReceptionistText:
	script_cable_club_receptionist

IndigoPlateauLobbyClerkText::
	script_mart  ULTRA_BALL, HYPER_POTION, FULL_RESTORE, REVIVE, FULL_HEAL, MAX_REPEL

IndigoPlateauLobbyPostGameClerkText::
	script_mart  MASTER_BALL, RARE_CANDY, TM_MEGA_PUNCH, TM_RAZOR_WIND, TM_SWORDS_DANCE, TM_WHIRLWIND, TM_MEGA_KICK, TM_TOXIC, TM_HORN_DRILL, TM_BODY_SLAM, TM_TAKE_DOWN, TM_DOUBLE_EDGE, TM_BUBBLEBEAM, TM_WATER_GUN, TM_ICE_BEAM, TM_BLIZZARD, TM_HYPER_BEAM, TM_PAY_DAY, TM_SUBMISSION, TM_COUNTER, TM_SEISMIC_TOSS, TM_RAGE, TM_MEGA_DRAIN, TM_SOLARBEAM, TM_DRAGON_RAGE, TM_THUNDERBOLT, TM_THUNDER, TM_EARTHQUAKE, TM_FISSURE, TM_DIG, TM_PSYCHIC_M, TM_TELEPORT, TM_MIMIC, TM_DOUBLE_TEAM, TM_REFLECT, TM_BIDE, TM_METRONOME, TM_SELFDESTRUCT, TM_EGG_BOMB, TM_FIRE_BLAST, TM_SWIFT, TM_SKULL_BASH, TM_SOFTBOILED, TM_DREAM_EATER, TM_SKY_ATTACK, TM_REST, TM_THUNDER_WAVE, TM_PSYWAVE, TM_EXPLOSION, TM_ROCK_SLIDE, TM_TRI_ATTACK, TM_SUBSTITUTE