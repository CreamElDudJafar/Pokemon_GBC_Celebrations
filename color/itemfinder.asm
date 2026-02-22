; Hook for engine/items/itemfinder.asm
HiddenItemNear:
	rst _DelayFrame
	jp _HiddenItemNear ; check for hidden items