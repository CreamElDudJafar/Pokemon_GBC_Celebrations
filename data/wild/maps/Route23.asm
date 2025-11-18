Route23WildMons:
	def_grass_wildmons 10 ; encounter rate
IF (DEF(_RED) || DEF(_GREEN)) 
	db 41, PRIMEAPE
ENDC
IF DEF(_BLUE)
	db 41, PRIMEAPE
ENDC
	db 41, ELECTABUZZ
	db 36, MAGMAR
	db 44, CHANSEY
	db 44, KANGASKHAN
	db 44, TAUROS
IF (DEF(_RED) || DEF(_GREEN)) 
	db 15, CHARMANDER
ENDC
IF DEF(_BLUE)
	db 15, CHARMANDER
ENDC
	db 15, SQUIRTLE
	db 15, BULBASAUR
	db 15, EEVEE
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
