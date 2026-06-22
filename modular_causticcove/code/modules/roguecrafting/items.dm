/datum/crafting_recipe/roguetown/survival/leash
	name = "rope leash"
	result = /obj/item/leash
	reqs = list(
	/obj/item/rope, 
	/obj/item/natural/fibers = 1,)
	craftdiff = 0

/datum/crafting_recipe/roguetown/survival/straw_sandals
	name = "straw sandals"
	result = /obj/item/clothing/shoes/roguetown/sandals/straw
	reqs = list(/obj/item/natural/fibers = 2)
	verbage_simple = "weave"
	verbage = "weaves"

/datum/crafting_recipe/roguetown/sewing/mushhat
	name = "mushroom hat"
	category = "Hats"
	result = list(/obj/item/clothing/head/roguetown/mushroomhat)
	reqs = list(
		/obj/item/natural/dirtclod = 1,
		/obj/item/grown/log/tree/stick = 2,
		/obj/item/natural/fibers = 1,
		)
	craftdiff = 2

/datum/crafting_recipe/roguetown/sewing/mushhatwide
	name = "wide mushroom hat"
	category = "Hats"
	result = list(/obj/item/clothing/head/roguetown/mushroomhat/wide)
	reqs = list(
		/obj/item/natural/dirtclod = 2,
		/obj/item/grown/log/tree/stick = 2,
		/obj/item/natural/fibers = 2,
		)
	craftdiff = 2

/datum/crafting_recipe/roguetown/sewing/bastshoes
	name = "bast shoes"
	category = "Footwear"
	result = list(/obj/item/clothing/shoes/roguetown/simpleshoes/bast)
	reqs = list(
		/obj/item/natural/cloth = 2,
		/obj/item/rope = 1,
		)
	craftdiff = 1

/datum/crafting_recipe/roguetown/sewing/ratty_skirt
	name = "Ratty Skirt"
	result = list(/obj/item/clothing/under/roguetown/skirt/ratty)
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/dirtclod = 1,
				/obj/item/natural/fibers = 2)
	craftdiff = 2
