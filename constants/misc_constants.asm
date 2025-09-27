; Boolean checks
DEF FALSE EQU 0
DEF TRUE  EQU 1

; flag operations
	const_def
	const FLAG_RESET ; 0
	const FLAG_SET   ; 1
	const FLAG_TEST  ; 2

DEF SAFARI_TYPE_CLASSIC EQU 0
DEF SAFARI_TYPE_FREE_ROAM EQU 1

; wOptions
DEF TEXT_DELAY_INSTANT EQU %000 ; 1 ; Instant
DEF TEXT_DELAY_FAST   EQU %001 ; 3 ; Fast
DEF TEXT_DELAY_SLOW   EQU %011 ; 5 ; Slow
DEF TEXT_DELAY_MASK   EQU %011

	const_def 4
	const BIT_MUSIC_STYLE      ; 4
	const BIT_MUSIC_MUTE       ; 5
	const BIT_BATTLE_SHIFT     ; 6
	const BIT_BATTLE_ANIMATION ; 7

; wd732 flags
DEF BIT_DEBUG_MODE EQU 1

;;;;;;;;;;;;
	const_def
	const BIT_POKEDEX_DATA_DISPLAY_TYPE
	const BIT_POKEDEX_WHICH_SPRITE_SHOWING
	const BIT_VIEWING_POKEDEX
;;;;;;;;;;;;
