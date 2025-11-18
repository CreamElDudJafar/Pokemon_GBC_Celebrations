ViridianForestWildMons:
	def_grass_wildmons 8 ; encounter rate
IF (DEF(_RED) || DEF(_GREEN)) 
	db  5, WEEDLE
	db  5, CATERPIE
	db  6, KAKUNA
	db  6, METAPOD
	db  4, CATERPIE
	db  5, ODDISH
	db  5, PIDGEY
	db  9, PIDGEOTTO
ENDC
IF DEF(_BLUE)
	db  5, CATERPIE
	db  5, WEEDLE
	db  6, METAPOD
	db  6, KAKUNA
	db  4, WEEDLE
	db  5, ODDISH
	db  5, PIDGEY
	db  9, PIDGEOTTO
ENDC
	db  5, PIKACHU
	db  5, PIKACHU
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons