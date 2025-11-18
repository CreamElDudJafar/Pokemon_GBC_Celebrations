PowerPlantWildMons:
	def_grass_wildmons 10 ; encounter rate
	db 32, VOLTORB
	db 35, MAGNEMITE
	db 33, PIKACHU
	db 33, PIKACHU
	db 34, GRIMER
	db 37, MUK
	db 37, MAGNETON
	db 38, ELECTRODE
IF (DEF(_RED) || DEF(_GREEN)) 
	db 37, RAICHU
	db 37, ELECTABUZZ
ENDC
IF DEF(_BLUE)
	db 37, ELECTABUZZ
	db 37, RAICHU
ENDC
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
