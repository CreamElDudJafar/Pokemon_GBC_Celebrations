IF DEF(_GREEN)
SFX_Intro_Hop_Ch8:
	noise_note 4, 12, 1, 66
	sound_ret
ELSE
SFX_Intro_Hop_Ch5:
	duty_cycle 2
	pitch_sweep 2, 6
	square_note 12, 12, 2, 1664
	pitch_sweep 0, 8
	sound_ret
ENDC
