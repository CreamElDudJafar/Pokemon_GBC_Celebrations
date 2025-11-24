	db DEX_RAPIDASH ; pokedex id

	db  65, 100,  70, 115,  80
	;   hp  atk  def  spd  spc

	db FIRE, FIRE ; type
	db 60 ; catch rate
	db 192 ; base exp

IF GEN_2_GRAPHICS
	INCBIN "gfx/pokemon/gsfront/rapidash.pic", 0, 1 ; sprite dimensions
ELSE
	INCBIN "gfx/pokemon/front/rapidash.pic", 0, 1 ; sprite dimensions
ENDC
	dw RapidashPicFront, RapidashPicBack

	db EMBER, TAIL_WHIP, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC, HORN_DRILL, BODY_SLAM, TAKE_DOWN,  DOUBLE_EDGE,  REST,\
	     HYPER_BEAM,   RAGE,         MIMIC,        DOUBLE_TEAM,  REFLECT,      \
	     BIDE,         FIRE_BLAST,   SWIFT,        SKULL_BASH,    SUBSTITUTE,         \
	     FLAMETHROWER
	; end

	db BANK(RapidashPicFront)
