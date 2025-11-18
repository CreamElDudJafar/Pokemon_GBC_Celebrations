Route15WildMons:
	def_grass_wildmons 15 ; encounter rate
IF (DEF(_RED) || DEF(_GREEN)) 
	db 26, ODDISH
	db 26, DITTO
	db 24, VENONAT
	db 32, PIDGEOTTO
	db 28, ODDISH
	db 28, BELLSPROUT
	db 30, GLOOM
	db 30, WEEPINBELL
ENDC
IF DEF(_BLUE)
	db 26, BELLSPROUT
	db 26, DITTO
	db 24, VENONAT
	db 32, PIDGEOTTO
	db 28, ODDISH
	db 28, BELLSPROUT
	db 30, GLOOM
	db 30, WEEPINBELL
ENDC
	db 30, VENONAT
	db 33, VENOMOTH
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
