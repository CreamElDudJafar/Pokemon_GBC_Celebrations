Route7WildMons:
	def_grass_wildmons 15 ; encounter rate
	db 19, PIDGEY
IF (DEF(_RED) || DEF(_GREEN)) 
	db 19, ODDISH
	db 17, KOFFING
	db 23, JIGGLYPUFF
	db 22, VULPIX
	db 18, MANKEY
	db 18, JIGGLYPUFF
	db 20, GROWLITHE
	db 20, EKANS
	db 20, MANKEY
ENDC
IF DEF(_BLUE)
	db 19, BELLSPROUT
	db 19, KOFFING
	db 23, JIGGLYPUFF
	db 22, GROWLITHE
	db 18, MEOWTH
	db 18, JIGGLYPUFF
	db 20, VULPIX
	db 20, EKANS
	db 20, MEOWTH
ENDC
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
