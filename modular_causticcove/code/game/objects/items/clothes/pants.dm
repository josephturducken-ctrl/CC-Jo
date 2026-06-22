/obj/item/clothing/under/roguetown/skirt/ratty
	name = "ratty skirt"
	desc = "Ratty, tattered, worn. What bog did you pull this from?"
	icon = 'modular_causticcove/icons/items/pants.dmi'
	mob_overlay_icon = 'modular_causticcove/icons/items/onmob/pants.dmi'
	icon_state = "ratty_skirt"
	item_state = "ratty_skirt"
	color = CLOTHING_DIRT
	detail_tag = "_detail"
	detail_color = CLOTHING_TEAL
	nodismemsleeves = TRUE
	sleevetype = null
	sleeved = null

/obj/item/clothing/under/roguetown/skirt/ratty/Initialize()
	. = ..()
	update_icon()

/obj/item/clothing/under/roguetown/skirt/ratty/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)
