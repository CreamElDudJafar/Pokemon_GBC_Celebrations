CeruleanCave1FWildMons:
	def_grass_wildmons 10 ; encounter rate
	db 64, RHYDON
	db 63, GOLEM
	db 62, ELECTRODE
	db 61, LICKITUNG
	db 65, CHANSEY
IF (DEF(_RED) || DEF(_GREEN)) 
	db 60, DITTO
ENDC
IF DEF(_BLUE)
	db 60, DITTO
ENDC
	db 64, VILEPLUME
	db 63, VICTREEBEL
	db 64, MACHAMP
	db 65, RAICHU
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
