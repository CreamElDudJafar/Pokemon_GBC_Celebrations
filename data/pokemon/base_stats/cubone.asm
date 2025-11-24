	db DEX_CUBONE ; pokedex id

	db  50,  50,  95,  35,  40
	;   hp  atk  def  spd  spc

	db GROUND, GROUND ; type
	db 190 ; catch rate
	db 87 ; base exp

IF GEN_2_GRAPHICS
	INCBIN "gfx/pokemon/gsfront/cubone.pic", 0, 1 ; sprite dimensions
ELSE
	INCBIN "gfx/pokemon/front/cubone.pic", 0, 1 ; sprite dimensions
ENDC
	dw CubonePicFront, CubonePicBack

	db GROWL, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   MEGA_KICK, TOXIC, BODY_SLAM,  TAKE_DOWN,  BIDE,  \
	     DOUBLE_EDGE,  BUBBLEBEAM,   WATER_GUN,    ICE_BEAM,     BLIZZARD,     \
	     SUBMISSION,   COUNTER,      SEISMIC_TOSS, RAGE,         EARTHQUAKE,   \
	     FISSURE,      DIG,          MIMIC,        DOUBLE_TEAM,  SWORDS_DANCE,         \
	     FIRE_BLAST,   SKULL_BASH,   REST, SUBSTITUTE,   CUT,  STRENGTH	   \
	; end

	db BANK(CubonePicFront)
