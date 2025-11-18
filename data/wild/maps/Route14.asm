Route14WildMons:
	def_grass_wildmons 15 ; encounter rate
IF (DEF(_RED) || DEF(_GREEN)) 
	db 26, ODDISH
	db 26, BELLSPROUT
	db 23, DITTO
	db 24, VENONAT
	db 25, PIDGEOTTO
	db 26, VENONAT
	db 30, SCYTHER
	db 30, GLOOM
ENDC
IF DEF(_BLUE)
	db 26, BELLSPROUT
	db 26, ODDISH
	db 23, DITTO
	db 24, VENONAT
	db 25, PIDGEOTTO
	db 26, VENONAT
	db 30, SCYTHER
	db 30, WEEPINBELL
ENDC
	db 30, VENOMOTH
	db 33, VENOMOTH
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
