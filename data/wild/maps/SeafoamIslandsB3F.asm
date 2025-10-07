SeafoamIslandsB3FWildMons:
	def_grass_wildmons 10 ; encounter rate
IF (DEF(_RED) || DEF(_GREEN)) 
	db 31, SLOWPOKE
	db 31, SEEL
	db 33, SLOWPOKE
	db 33, SEEL
	db 29, HORSEA
	db 31, SHELLDER
	db 31, HORSEA
	db 29, SHELLDER
	db 39, SEADRA
ENDC
IF DEF(_BLUE)
	db 31, HORSEA
	db 31, SEEL
	db 33, PSYDUCK
	db 33, SEEL
	db 29, KRABBY
	db 31, STARYU
	db 31, KRABBY
	db 29, STARYU
	db 39, KINGLER
ENDC
	db 37, DEWGONG
	end_grass_wildmons

	def_water_wildmons 5 ; encounter rate
	db 25, GOLDEEN
	db 30, GOLDEEN
	db 30, GOLDEEN
	db 30, STARYU
	db 35, HORSEA
	db 40, STARYU
	db 40, HORSEA
	db 40, SEADRA
	db 40, SEADRA
	db 40, STARMIE
	end_water_wildmons
