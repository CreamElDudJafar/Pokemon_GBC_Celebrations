	db DEX_WIGGLYTUFF ; pokedex id

	db 140,  70,  55,  45,  85
	;   hp  atk  def  spd  spc

	db NORMAL, NORMAL ; type
	db 50 ; catch rate
	db 109 ; base exp

IF GEN_2_GRAPHICS
	INCBIN "gfx/pokemon/gsfront/wigglytuff.pic", 0, 1 ; sprite dimensions
ELSE
	INCBIN "gfx/pokemon/front/wigglytuff.pic", 0, 1 ; sprite dimensions
ENDC
	dw WigglytuffPicFront, WigglytuffPicBack

	db SING, DOUBLESLAP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,  MEGA_KICK, TOXIC, BODY_SLAM,  TAKE_DOWN,   REST,      \
	     DOUBLE_EDGE,  BUBBLEBEAM,   WATER_GUN,    ICE_BEAM,     BLIZZARD,     \
	     HYPER_BEAM,   SUBMISSION,   COUNTER,      SEISMIC_TOSS, RAGE,         \
	     SOLARBEAM,    THUNDERBOLT,  THUNDER,      PSYCHIC_M,    TELEPORT,     \
	     MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         FIRE_BLAST,   \
	     SKULL_BASH,    THUNDER_WAVE, PSYWAVE,      TRI_ATTACK,  SUBSTITUTE,  \
	     STRENGTH,     FLASH,         FLAMETHROWER
	; end

	db BANK(WigglytuffPicFront)
