SafariZoneCenterWildMons:
	def_grass_wildmons 30 ; encounter rate
IF (DEF(_RED) || DEF(_GREEN)) 
	db 32, NIDORINO
	db 32, RHYHORN
	db 32, PINSIR
	db 34, EXEGGCUTE
	db 36, NIDORINA
	db 36, EXEGGCUTE
	db 37, TANGELA
	db 37, PARASECT
	db 35, SCYTHER
ENDC
IF DEF(_BLUE)
	db 32, NIDORINA
	db 32, RHYHORN
	db 32, SCYTHER
	db 34, EXEGGCUTE
	db 36, NIDORINO
	db 36, EXEGGCUTE
	db 37, TANGELA
	db 37, PARASECT
	db 35, PINSIR
ENDC
	db 32, CHANSEY
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
