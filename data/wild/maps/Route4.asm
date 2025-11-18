Route4WildMons:
	def_grass_wildmons 20 ; encounter rate
	db 10, RATTATA
	db 10, SPEAROW
	db 12, MANKEY
IF (DEF(_RED) || DEF(_GREEN)) 
	db  9, EKANS
	db 11, SPEAROW
	db 10, SANDSHREW
	db 12, EKANS
	db 12, SANDSHREW
	db 10, PSYDUCK
	db 12, FARFETCHD
ENDC
IF DEF(_BLUE)
	db  9, SANDSHREW
	db 11, SPEAROW
	db 10, EKANS
	db 12, SANDSHREW
	db 12, EKANS
	db 10, PSYDUCK
	db 12, FARFETCHD
ENDC
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
