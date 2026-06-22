/obj/item/clothing/head/roguetown/spellcasterhat/drifter
	name = "Drifting magicians hat"
	desc = "A hat treated and hardened for extended travel. Perfect for the wandering mage!"
	icon = 'modular_causticcove/icons/items/hats.dmi'
	bloody_icon = 'modular_causticcove/icons/effects/hat_blood.dmi'
	mob_overlay_icon = 'modular_causticcove/icons/items/onmob/onmob.dmi'
	bloody_icon_state = "dhat"
	icon_state = "dhat"
	item_state = "dhat"
	armor = ARMOR_LEATHER
	sellprice = 15
	worn_x_dimension = 64
	worn_y_dimension = 68
	sewrepair = TRUE
	resistance_flags = FIRE_PROOF

/datum/crafting_recipe/roguetown/sewing/driftermagehat
	name = "Drifting magicians hat"
	category = "Hats"
	result = list(/obj/item/clothing/head/roguetown/spellcasterhat/drifter)
	reqs = list(/obj/item/natural/cloth = 1,
	            /obj/item/natural/fibers = 1,
				/obj/item/natural/hide/cured = 2)
	tools = list(/obj/item/needle)
	craftdiff = 6
	sellprice = 15

/obj/item/clothing/head/roguetown/spellcasterhat/wbonnet
	name = "Witches Bonnet"
	desc = "A particularly thick, pointed hat that is tied around the chin. Great for tucking the hair away for spell casting."
	icon = 'modular_causticcove/icons/items/hats.dmi'
	bloody_icon = 'modular_causticcove/icons/effects/hat_blood.dmi'
	mob_overlay_icon = 'modular_causticcove/icons/items/onmob/onmob.dmi'
	bloody_icon_state = "witch_bonnet"
	icon_state = "witch_bonnet"
	item_state = "witch_bonnet"
	armor = ARMOR_LEATHER
	sellprice = 18
	worn_x_dimension = 64
	worn_y_dimension = 68
	sewrepair = TRUE
	resistance_flags = FIRE_PROOF

/datum/crafting_recipe/roguetown/sewing/wbonnet
	name = "Witches Bonnet"
	category = "Hats"
	result = list(/obj/item/clothing/head/roguetown/spellcasterhat/wbonnet)
	reqs = list(/obj/item/natural/cloth = 2,
	            /obj/item/natural/fibers = 1,
				/obj/item/natural/hide/cured = 2)
	tools = list(/obj/item/needle)
	craftdiff = 6
	sellprice = 18

/obj/item/clothing/head/roguetown/grenzelhofthat/floweredAlc
	name = "Alchemist Cap"
	desc = "A Hat heavily treated with various reagents to make it quite firm and protective. Fantastic for one of the most dangerous jobs in the land; picking flowers."
	icon = 'modular_causticcove/icons/items/hats.dmi'
	bloody_icon = 'modular_causticcove/icons/effects/hat_blood.dmi'
	mob_overlay_icon = 'modular_causticcove/icons/items/onmob/onmob.dmi'
	icon_state = "herb_hata"
	item_state = "herb_hata"
	detail_tag = "_detail"
	altdetail_tag = "_detailalt"
	bloody_icon_state = "herb_hat"
	armor = ARMOR_LEATHER
	max_integrity = ARMOR_INT_HELMET_CLOTH + 70 //its a special hat made for alchemists by alchemists and not a loadout item, should be ok for a MINOR increase
	color = "#ffffff"
	detail_color = "#FFFFFF"
	altdetail_color = "#ffffff"
	worn_x_dimension = 64
	worn_y_dimension = 66

/obj/item/clothing/head/roguetown/grenzelhofthat/floweredAlc/attack_right(mob/user)
	if(!picked)
		var/choice = input(user, "Choose a color.", "ribbon colors") as anything in COLOR_MAP
		var/playerchoice = COLOR_MAP[choice]
		picked = TRUE
		detail_color = playerchoice
		detail_tag = "_detail"
		update_icon()
		if(loc == user && ishuman(user))
			var/mob/living/carbon/H = user
			H.update_inv_head()

/datum/crafting_recipe/roguetown/alchemy/floweredAlc
	name = "Alchemist Cap"
	category = "Hats"
	result = /obj/item/clothing/head/roguetown/grenzelhofthat/floweredAlc
	reqs = list(/obj/item/natural/cloth = 2, /obj/item/natural/fibers = 5, /obj/item/alch = 2)
	tools = list(/obj/item/needle)
	craftdiff = 6

/obj/item/clothing/head/roguetown/grenzelhofthat/floweredAlc/tricolor
	icon = 'modular_causticcove/icons/items/hats.dmi'
	bloody_icon = 'modular_causticcove/icons/effects/hat_blood.dmi'
	mob_overlay_icon = 'modular_causticcove/icons/items/onmob/onmob.dmi'
	icon_state = "herb_hatb"
	item_state = "herb_hatb"

/datum/crafting_recipe/roguetown/alchemy/floweredAlc/tri
	name = "Alchemists Cap (tri)"
	category = "Hats"
	result = /obj/item/clothing/head/roguetown/grenzelhofthat/floweredAlc/tricolor
	reqs = list(/obj/item/natural/cloth = 2, /obj/item/natural/fibers = 5, /obj/item/alch = 2)
	tools = list(/obj/item/needle)
	craftdiff = 6

/obj/item/clothing/head/roguetown/mushroomhat
	name = "Mushroom Cap"
	desc = "A thick hat made to mimic a mushroom's cap. Quite spongy. This one is dotted with spots."
	icon = 'modular_causticcove/icons/items/head.dmi'
	mob_overlay_icon = 'modular_causticcove/icons/items/onmob/head.dmi'
	icon_state = "mushroom_hat"
	item_state = "mushroom_hat"
	sewrepair = TRUE
	salvage_result = /obj/item/natural/fibers
	salvage_amount = 1
	detail_tag = "_detail"
	color = CLOTHING_RED
	detail_color = CLOTHING_CREAM

/obj/item/clothing/head/roguetown/mushroomhat/Initialize()
	. = ..()
	update_icon()

/obj/item/clothing/head/roguetown/mushroomhat/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/head/roguetown/mushroomhat/wide
	name = "Wide Mushroom Cap"
	desc = "A large and bulky hat made to look like a mushroom head. This one is plain-faced."
	icon_state = "mushroom_hat_wide"
	item_state = "mushroom_hat_wide"
