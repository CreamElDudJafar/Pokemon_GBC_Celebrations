Route25WildMons:
	def_grass_wildmons 15 ; encounter rate
IF (DEF(_RED) || DEF(_GREEN)) 
	db 12, ODDISH
	db 12, BELLSPROUT
	db 13, ABRA
	db 14, ODDISH
	db 14, BELLSPROUT
	db 15, PIDGEY
	db 13, VENONAT
	db 16, VENONAT
	db 17, EKANS
	db 17, PIDGEOTTO
ENDC
IF DEF(_BLUE)
	db 12, ODDISH
	db 12, BELLSPROUT
	db 13, ABRA
	db 14, ODDISH
	db 14, BELLSPROUT
	db 15, PIDGEY
	db 13, VENONAT
	db 16, VENONAT
	db 17, EKANS
	db 17, PIDGEOTTO
ENDC
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
