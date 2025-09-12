Route22WildMons:
	def_grass_wildmons 25 ; encounter rate
	db  3, RATTATA
IF (DEF(_RED) || DEF(_GREEN)) 
	db  3, NIDORAN_M
	db  4, RATTATA
	db  4, NIDORAN_M
	db  2, RATTATA
	db  5, DODUO
	db  3, SPEAROW
	db  5, SPEAROW
	db  4, NIDORAN_F
	db  4, POLIWAG
ENDC
IF DEF(_BLUE)
	db  3, NIDORAN_F
	db  4, RATTATA
	db  4, NIDORAN_F
	db  2, RATTATA
	db  5, DODUO
	db  3, SPEAROW
	db  5, SPEAROW
	db  4, NIDORAN_M
	db  4, POLIWAG
ENDC
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
