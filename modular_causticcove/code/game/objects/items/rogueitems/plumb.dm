// Plumb! To pixelshift structures

/obj/item/plumbbob
	name = "builder's plumb"
	desc = "A traditional plumb, used by carpenters and other makers to ensure that angles are straight, and if not, adjust them as needed. <br>Traditionally made with lead, this one is made out of cheaper, and equally effective stone attached to a spool of twine."
	icon = 'modular_causticcove/icons/obj/plumb.dmi'
	icon_state = "plumb_bob"
	slot_flags = ITEM_SLOT_HIP
	grid_height = 64
	grid_width = 32

	var/x_change = 0
	var/y_change = 0
	var/layer_change = 2.9
	var/rotation = 0

	var/list/structure_blacklist = list(
		/obj/structure/roguewindow,
		/obj/structure/mineral_door,
		/obj/structure/bars,
		/obj/structure/dungeon_entry,
		/obj/structure/far_travel,
		/obj/structure/minecart_rail,
		/obj/structure/ladder,
		/obj/structure/flora/newtree, // Could add the other flora types, but moving flowers can be pretty
		/obj/structure/flora/newbranch,
		/obj/structure/flora/newleaf,
		/obj/structure/table, // Tables and shelves get weird when offset
		/obj/structure/rack/rogue/shelf,
		/obj/structure/fluff/railing,
	)

/obj/item/plumbbob/examine(mob/user)
	. = ..()
	. += span_notice("Current offsets: </br>X axis - [x_change]. </br>Y axis - [y_change]. </br>Layer - [layer_change]. </br>Rotation - [rotation]. </br>")

/obj/item/plumbbob/attack_self(mob/living/user)
	. = ..()
	if(.)
		return
	var/choice = input(user, "Which parameter?", "DECORATION", name) as null|anything in list("X axis","Y axis","Layer","Rotation")
	if(!choice || !user)
		return
	switch(choice)
		if("X axis")
			var/offset = input(user, "X AXIS", "DECORATION", 0) as null|num
			x_change = offset
			if(offset > 32)
				x_change = 32
			if(offset < -32)
				x_change = -32
			to_chat(user, "The X axis offset has been set to: [x_change]")
		if("Y axis")
			var/offset = input(user, "Y AXIS", "DECORATION", 0) as null|num
			y_change = offset
			if(offset > 32)
				y_change = 32
			if(offset < -32)
				y_change = -32
			to_chat(user, "The Y axis offset has been set to: [y_change]")
		if("Layer")
			var/offset = input(user, "LAYER", "DECORATION", 2.91) as null|num
			layer_change = offset
			to_chat(user, "The layer offset has been set to: [layer_change]. (Default is 2.91)")
		if("Rotation")
			var/offset = input(user, "ROTATION", "DECORATION", 0) as null|num
			rotation = offset
			to_chat(user, "The rotation offset has been set to: [rotation]")
	return

/obj/item/plumbbob/attack_right(mob/living/user)
	. = ..()
	x_change = 0
	y_change = 0
	layer_change = 2.9
	rotation = 0
	to_chat(user, "The [name] has been reset.")
	return

/obj/item/plumbbob/attack_obj(obj/target, mob/living/user)
	if(is_type_in_list(target,structure_blacklist))
		to_chat(user, "<span class='warning'>[target.name]'s position cannot be adjusted.</span>")
		return
	if(do_after(user, 1 SECONDS))
		visible_message("[user] uses the plumb to adjust the [target]'s position.", "I adjust the [target]'s position.")
		var/matrix/M = matrix()
		M.Turn(rotation)
		M.Translate(x_change,y_change)
		target.layer = layer_change
		target.transform = M
		var/was_dense = initial(target.density)
		if(was_dense)
			if(x_change >= 10 || x_change <= -10 || y_change >= 10 || y_change <= -10)
				target.density = FALSE
			else
				target.density = TRUE
		return
	else
		to_chat(user, "<span class='warning'>I must stand still to adjust the [target.name]'s position.</span>")
		return


/datum/crafting_recipe/roguetown/survival/plumbbob
	name = "builder's plumb"
	category = "Tools"
	result = /obj/item/plumbbob
	reqs = list(
		/obj/item/natural/fibers = 2,
		/obj/item/natural/whetstone = 1,
		)
	craftdiff = 2
