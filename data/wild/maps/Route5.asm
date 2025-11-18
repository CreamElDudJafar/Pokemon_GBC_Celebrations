Route5WildMons:
	def_grass_wildmons 15 ; encounter rate
IF (DEF(_RED) || DEF(_GREEN)) 
	db 13, ODDISH
	db 13, PIDGEY
	db 13, FARFETCHD
	db 10, MEOWTH
	db 12, MANKEY
	db 15, ODDISH
	db 16, ABRA
	db 17, PIDGEOTTO
	db 15, MEOWTH
	db 16, MEOWTH
ENDC
IF DEF(_BLUE)
	db 13, BELLSPROUT
	db 13, PIDGEY
	db 15, FARFETCHD
	db 10, MEOWTH
	db 12, MANKEY
	db 15, BELLSPROUT
	db 16, ABRA
	db 17, PIDGEOTTO
	db 15, MEOWTH
	db 16, MEOWTH
ENDC
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
