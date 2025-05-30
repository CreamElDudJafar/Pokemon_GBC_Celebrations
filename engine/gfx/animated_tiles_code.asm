AnimateWaterTile::
	ld hl, vTileset tile $14
	ld c, $10

	ld a, [wMovingBGTilesCounter2]
	inc a
	and 7
	ld [wMovingBGTilesCounter2], a

	and 4
	jr nz, .left
.right
	ld a, [hl]
	rrca
	ld [hli], a
	dec c
	jr nz, .right
	jr .done
.left
	ld a, [hl]
	rlca
	ld [hli], a
	dec c
	jr nz, .left
.done
	ldh a, [hTileAnimations]
	rrca
	ret nc

	xor a
	ldh [hMovingBGTilesCounter1], a
	ret

AnimateFlowerTile::
	xor a
	ldh [hMovingBGTilesCounter1], a

	ld a, [wMovingBGTilesCounter2]
IF DEF(_GREEN)
	and 2
	cp 2
ELSE
	and 3
	cp 1
ENDC

IF DEF(_GREEN)
	ld hl, FlowerTile1
	jr c, .copy
	ld hl, FlowerTile2
ELSE
	ld hl, FlowerTile1
	jr c, .copy
	ld hl, FlowerTile2
	jr z, .copy
	ld hl, FlowerTile3
ENDC
.copy
	ld de, vTileset tile $03
	ld c, $10
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret

IF DEF(_GREEN)
FlowerTile1: INCBIN "gfx/tilesets/tilesets_rg/flower1.2bpp"
FlowerTile2: INCBIN "gfx/tilesets/tilesets_rg/flower2.2bpp"
ELSE
FlowerTile1: INCBIN "gfx/tilesets/flower/flower1.2bpp"
FlowerTile2: INCBIN "gfx/tilesets/flower/flower2.2bpp"
FlowerTile3: INCBIN "gfx/tilesets/flower/flower3.2bpp"
ENDC