PokemonMansion2FWildMons:
	def_grass_wildmons 10 ; encounter rate
IF (DEF(_RED) || DEF(_GREEN)) 
	db 35, GROWLITHE
	db 35, KOFFING
	db 34, KOFFING
	db 33, PONYTA
	db 40, MAGMAR
	db 33, PONYTA
	db 35, GRIMER
	db 37, PONYTA
	db 39, WEEZING
	db 39, MUK
ENDC
IF DEF(_BLUE)
	db 35, VULPIX
	db 35, GRIMER
	db 34, GRIMER
	db 33, PONYTA
	db 30, MAGMAR
	db 33, PONYTA
	db 35, KOFFING
	db 37, PONYTA
	db 39, MUK
	db 39, WEEZING
ENDC
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
