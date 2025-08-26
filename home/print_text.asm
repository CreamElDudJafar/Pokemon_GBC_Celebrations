; This function is used to wait a short period after printing a letter to the
; screen unless the player presses the A/B button or the delay is turned off
; through the [wd730] or [wLetterPrintingDelayFlags] flags.
PrintLetterDelay::
	ld a, [wd730]
	bit 6, a
	ret nz
	ld a, [wLetterPrintingDelayFlags]
	bit 1, a
	ret z
	push hl
	push de
	push bc
	push af
	callfar PrintLetterDelay_
	pop af
	pop bc
	pop de
	pop hl
	ret