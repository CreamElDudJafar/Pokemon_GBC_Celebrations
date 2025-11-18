PokemonMansion3FWildMons:
	def_grass_wildmons 10 ; encounter rate
IF (DEF(_RED) || DEF(_GREEN)) 
	db 35, KOFFING
	db 35, GROWLITHE
	db 36, VULPIX
	db 33, PONYTA
	db 40, MAGMAR
	db 40, WEEZING
	db 35, GRIMER
	db 39, WEEZING
	db 38, PONYTA
	db 42, MUK
ENDC
IF DEF(_BLUE)
	db 35, GRIMER
	db 35, VULPIX
	db 36, GROWLITHE
	db 33, PONYTA
	db 40, MAGMAR
	db 40, MUK
	db 35, KOFFING
	db 39, MUK
	db 38, PONYTA
	db 42, WEEZING
ENDC
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
