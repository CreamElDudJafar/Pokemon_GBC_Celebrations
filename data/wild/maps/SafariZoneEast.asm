SafariZoneEastWildMons:
	def_grass_wildmons 30 ; encounter rate
IF (DEF(_RED) || DEF(_GREEN)) 
	db 32, TAUROS
	db 33, DODUO
	db 35, PINSIR
	db 34, EXEGGCUTE
	db 36, MAROWAK
	db 36, KANGASKHAN
	db 36, RHYHORN
	db 37, PARASECT
	db 35, CHANSEY
	db 40, SCYTHER
ENDC
IF DEF(_BLUE)
	db 32, TAUROS
	db 33, DODUO
	db 35, SCYTHER
	db 34, EXEGGCUTE
	db 36, MAROWAK
	db 36, KANGASKHAN
	db 36, RHYHORN
	db 37, PARASECT
	db 35, CHANSEY
	db 40, PINSIR
ENDC
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
