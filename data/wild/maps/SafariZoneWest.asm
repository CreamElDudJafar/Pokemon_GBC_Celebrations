SafariZoneWestWildMons:
	def_grass_wildmons 30 ; encounter rate
IF (DEF(_RED) || DEF(_GREEN)) 
	db 35, BUTTERFREE
	db 33, DODRIO
	db 35, VENOMOTH
	db 34, EXEGGUTOR
	db 36, FEAROW
	db 36, PIDGEOT
	db 36, SCYTHER
ENDC
IF DEF(_BLUE)
	db 35, BEEDRILL
	db 33, DODRIO
	db 35, VENOMOTH
	db 34, EXEGGUTOR
	db 36, FEAROW
	db 36, PIDGEOT
	db 36, SCYTHER
ENDC
	db 36, PINSIR
	db 36, TAUROS
	db 36, KANGASKHAN
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
