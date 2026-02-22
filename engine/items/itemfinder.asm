HiddenItemNear:
	ld hl, HiddenItemCoords
	ld b, 0
.loop
	ld de, 3
	ld a, [wCurMap]
	call IsInRestOfArray
	ret nc ; return if current map has no hidden items
	push bc
	push hl
	ld hl, wObtainedHiddenItemsFlags
	ld c, b
	ld b, FLAG_TEST
	predef FlagActionPredef
	ld a, c
	pop hl
	pop bc
	inc b
	and a
	inc hl
	ld d, [hl]
	inc hl
	ld e, [hl]
	inc hl
	jr nz, .loop ; if the item has already been obtained
; check if the item is within 4-5 tiles (depending on the direction of item)
;joenote - there is a bug here. if an item has an x or y coord at 0, the carry bit will not be set and it will not be detected
;        - adding z-flag checks check to account for this
	ld a, [wYCoord]
	call Sub5ClampTo0
	cp d
	jr z, .y_zflag
	jr nc, .loop
.y_zflag
	ld a, [wYCoord]
	add 4
	cp d
	jr c, .loop
	ld a, [wXCoord]
	call Sub5ClampTo0
	cp e
	jr z, .x_zflag
	jr nc, .loop
.x_zflag
	ld a, [wXCoord]
	add 5  ; joenote - the game displays your character slightly off-center to the left, so add 5 for x direction to the right
	cp e
	jr c, .loop
	scf
	ret

Sub5ClampTo0:
; subtract 5 but clamp to 0
	sub 4  ;joenote - zeros are now included so subtract 4 instead
	cp $f0
	ret c
	xor a
	ret
