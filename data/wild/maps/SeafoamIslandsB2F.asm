SeafoamIslandsB2FWildMons:
	def_grass_wildmons 10 ; encounter rate
	db 30, SEEL
IF (DEF(_RED) || DEF(_GREEN)) 
	db 30, SLOWPOKE
	db 32, KRABBY
	db 28, HORSEA
	db 30, STARYU
	db 30, JYNX
	db 28, SHELLDER
	db 30, GOLBAT
	db 32, KINGLER
	db 37, SLOWBRO
ENDC
IF DEF(_BLUE)
	db 30, PSYDUCK
	db 32, SEEL
	db 28, KRABBY
	db 30, SHELLDER
	db 30, JYNX
	db 28, STARYU
	db 30, GOLBAT
	db 32, KINGLER
	db 37, GOLDUCK
ENDC
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
