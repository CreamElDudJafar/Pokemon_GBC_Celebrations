PokemonMansionB1FWildMons:
	def_grass_wildmons 10 ; encounter rate
IF (DEF(_RED) || DEF(_GREEN)) 
	db 35, KOFFING
	db 37, GRIMER
	db 37, GROWLITHE
	db 36, PONYTA
	db 40, WEEZING
	db 38, PONYTA
	db 35, MAGMAR
	db 42, MAGMAR
	db 42, MUK
	db 35, DITTO
ENDC
IF DEF(_BLUE)
	db 35, GRIMER
	db 37, KOFFING
	db 37, VULPIX
	db 36, PONYTA
	db 40, MUK
	db 38, PONYTA
	db 35, MAGMAR
	db 42, MAGMAR
	db 42, WEEZING
	db 35, DITTO
ENDC
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
