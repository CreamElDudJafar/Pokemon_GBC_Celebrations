Route6WildMons:
	def_grass_wildmons 15 ; encounter rate
IF (DEF(_RED) || DEF(_GREEN)) 
	db 13, ODDISH
	db 13, PIDGEY
	db 15, MEOWTH
	db 10, MANKEY
	db 15, ABRA
	db 15, BELLSPROUT
	db 18, LICKITUNG
	db 16, JIGGLYPUFF
	db 16, JIGGLYPUFF
	db 19, MAGNEMITE
ENDC
IF DEF(_BLUE)
	db 13, BELLSPROUT
	db 13, PIDGEY
	db 15, MANKEY
	db 10, MEOWTH
	db 15, ABRA
	db 15, ODDISH
	db 18, LICKITUNG
	db 16, JIGGLYPUFF
	db 16, JIGGLYPUFF
	db 19, MAGNEMITE
ENDC
	end_grass_wildmons

	def_water_wildmons 3 ; encounter rate
	db 15, PSYDUCK
	db 15, PSYDUCK
	db 15, PSYDUCK
	db 15, PSYDUCK
	db 15, PSYDUCK
	db 15, PSYDUCK
	db 15, PSYDUCK
	db 28, GOLDUCK
	db 28, GOLDUCK
	db 30, GOLDUCK
	end_water_wildmons
