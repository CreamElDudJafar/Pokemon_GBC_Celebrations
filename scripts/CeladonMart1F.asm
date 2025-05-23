CeladonMart1F_Script:
	jp EnableAutoTextBoxDrawing

CeladonMart1F_TextPointers:
	def_text_pointers
	dw_const CeladonMart1FReceptionistText,     TEXT_CELADONMART1F_RECEPTIONIST
	dw_const CeladonMart1FTraderText,	    TEXT_CELADONMART1F_TRADER
	dw_const CeladonMart1FDirectorySignText,    TEXT_CELADONMART1F_DIRECTORY_SIGN
	dw_const CeladonMart1FCurrentFloorSignText, TEXT_CELADONMART1F_CURRENT_FLOOR_SIGN

CeladonMart1FReceptionistText:
	text_far _CeladonMart1FReceptionistText
	text_end

CeladonMart1FDirectorySignText:
	text_far _CeladonMart1FDirectorySignText
	text_end

CeladonMart1FCurrentFloorSignText:
	text_far _CeladonMart1FCurrentFloorSignText
	text_end
	
CeladonMart1FTraderText:
	text_asm
	ld a, TRADE_WITH_SELF
	ld [wWhichTrade], a
	predef DoInGameTradeDialogue
	rst TextScriptEnd
