CeruleanCaveB1FWildMons:
	def_grass_wildmons 25 ; encounter rate
	db 64, HYPNO
	db 64, GOLDUCK
	db 63, EXEGGUTOR
	db 62, GYARADOS
	db 65, PARASECT
	db 64, SLOWBRO
IF (DEF(_RED) || DEF(_GREEN)) 
	db 64, CLOYSTER
ENDC
IF DEF(_BLUE)
	db 64, CLOYSTER
ENDC
	db 65, TAUROS
	db 63, GENGAR
	db 67, ALAKAZAM
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
