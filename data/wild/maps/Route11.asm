Route11WildMons:
	def_grass_wildmons 15 ; encounter rate
IF (DEF(_RED) || DEF(_GREEN)) 
	db 15, EKANS
	db 18, SPEAROW
	db 17, EKANS
	db 15, DROWZEE
	db 18, BELLSPROUT
	db 15, DROWZEE
	db 18, PIDGEOTTO
ENDC
IF DEF(_BLUE)
	db 15, SANDSHREW
	db 18, SPEAROW
	db 17, SANDSHREW
	db 15, DROWZEE
	db 18, ODDISH
	db 15, DROWZEE
	db 18, PIDGEOTTO
ENDC
	db 20, MAGNEMITE
	db 19, DROWZEE
	db 20, DROWZEE
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
