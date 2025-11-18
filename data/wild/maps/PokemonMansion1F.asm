PokemonMansion1FWildMons:
	def_grass_wildmons 10 ; encounter rate
IF (DEF(_RED) || DEF(_GREEN)) 
	db 32, KOFFING
	db 30, KOFFING
	db 34, PONYTA
	db 30, PONYTA
	db 35, GROWLITHE
	db 33, VULPIX
	db 30, GRIMER
	db 28, PONYTA
	db 37, WEEZING
	db 39, MUK
ENDC
IF DEF(_BLUE)
	db 32, GRIMER
	db 30, GRIMER
	db 34, PONYTA
	db 30, PONYTA
	db 35, VULPIX
	db 33, GROWLITHE
	db 30, KOFFING
	db 28, PONYTA
	db 37, MUK
	db 39, WEEZING
ENDC
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
