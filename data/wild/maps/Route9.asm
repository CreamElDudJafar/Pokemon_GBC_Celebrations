Route9WildMons:
	def_grass_wildmons 15 ; encounter rate
	db 16, RATTATA
	db 16, SPEAROW
	db 14, VENONAT
IF (DEF(_RED) || DEF(_GREEN)) 
	db 14, EKANS
	db 15, SPEAROW
	db 15, EKANS
	db 17, SANDSHREW
	db 17, PINSIR
	db 15, LICKITUNG
	db 17, LICKITUNG
ENDC
IF DEF(_BLUE)
	db 14, SANDSHREW
	db 15, SPEAROW
	db 15, SANDSHREW
	db 17, EKANS
	db 17, PINSIR
	db 15, LICKITUNG
	db 17, LICKITUNG
ENDC
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
