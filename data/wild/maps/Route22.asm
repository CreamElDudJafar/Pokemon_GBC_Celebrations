Route22WildMons:
	def_grass_wildmons 25 ; encounter rate
	db  3, RATTATA
IF (DEF(_RED) || DEF(_GREEN)) 
	db  2, NIDORAN_M
	db  2, NIDORAN_F
	db  3, MANKEY
	db  4, NIDORAN_M
	db  4, NIDORAN_F
	db  5, MANKEY
	db  4, SPEAROW
	db  5, SPEAROW
	db  3, POLIWAG
ENDC
IF DEF(_BLUE)
	db  2, NIDORAN_M
	db  2, NIDORAN_F
	db  3, MANKEY
	db  4, NIDORAN_M
	db  4, NIDORAN_F
	db  5, MANKEY
	db  4, SPEAROW
	db  5, SPEAROW
	db  3, POLIWAG
ENDC
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
