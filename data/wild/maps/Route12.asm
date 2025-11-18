Route12WildMons:
	def_grass_wildmons 15 ; encounter rate
IF (DEF(_RED) || DEF(_GREEN)) 
	db 25, ODDISH
	db 25, BELLSPROUT
	db 28, PIDGEY
	db 24, VENONAT
	db 23, FARFETCHD
	db 26, VENONAT
	db 26, FARFETCHD
	db 27, WEEPINBELL
	db 28, GLOOM
	db 30, GLOOM
ENDC
IF DEF(_BLUE)
	db 25, BELLSPROUT
	db 25, ODDISH
	db 28, PIDGEY
	db 24, VENONAT
	db 23, FARFETCHD
	db 26, VENONAT
	db 26, FARFETCHD
	db 27, GLOOM
	db 28, WEEPINBELL
	db 30, WEEPINBELL
ENDC
	end_grass_wildmons

	def_water_wildmons 3 ; encounter rate
	db 15, SLOWPOKE
	db 15, SLOWPOKE
	db 15, SLOWPOKE
	db 15, SLOWPOKE
	db 15, SLOWPOKE
	db 15, SLOWPOKE
	db 15, SLOWPOKE
	db 20, SLOWBRO
	db 20, SLOWBRO
	db 20, SLOWBRO
	end_water_wildmons
