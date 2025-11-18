SafariZoneNorthWildMons:
	def_grass_wildmons 30 ; encounter rate
IF (DEF(_RED) || DEF(_GREEN)) 
	db 33, NIDOKING
	db 33, RHYHORN
	db 35, PARAS
	db 34, EXEGGCUTE
	db 35, NIDOQUEEN
	db 36, MAROWAK
	db 35, KANGASKHAN
ENDC
IF DEF(_BLUE)
	db 33, NIDOQUEEN
	db 33, RHYHORN
	db 35, PARAS
	db 34, EXEGGCUTE
	db 35, NIDOKING
	db 36, MAROWAK
	db 35, KANGASKHAN
ENDC
	db 36, VENOMOTH
	db 37, CHANSEY
	db 40, TAUROS
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
