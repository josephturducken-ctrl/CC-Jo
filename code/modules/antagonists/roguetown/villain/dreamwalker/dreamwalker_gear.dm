// Component for dream weapon special properties
/datum/component/dream_weapon
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/effect_type = null
	var/cooldown_time
	var/next_use = 0

/datum/component/dream_weapon/Initialize(effect_type, cooldown_time)
	. = ..()
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	src.effect_type = effect_type
	src.cooldown_time = cooldown_time

	RegisterSignal(parent, COMSIG_ITEM_ATTACK_SUCCESS, .proc/on_attack)
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, .proc/on_equipped)


/datum/component/dream_weapon/proc/on_attack(obj/item/source, mob/living/target, mob/living/user)
	SIGNAL_HANDLER
	if(!effect_type)
		return

	// Check cooldown
	if(world.time < next_use)
		return

	if(!ishuman(target))
		return

	var/mob/living/carbon/human/H = target

	// Apply effect based on type
	switch(effect_type)
		if("fire")
			H.adjust_fire_stacks(4)
			spawn(0)
				H.ignite_mob()
			target.visible_message(span_warning("[source] ignites [target] with strange flame!"))
		if("frost")
			apply_frost_stack(H, 2)
			target.visible_message(span_warning("[source] freezes [target] with scalding ice!"))
		if("poison")
			if(H.reagents)
				H.reagents.add_reagent(/datum/reagent/berrypoison, 2)
				target.visible_message(span_warning("[source] injects [target] with vile ooze!"))

	// Set cooldown
	next_use = world.time + cooldown_time

/datum/component/dream_weapon/proc/on_equipped(obj/item/source, mob/user, slot)
	SIGNAL_HANDLER
	if(HAS_TRAIT(user, TRAIT_DREAMWALKER))
		return

	// Non-dreamwalker trying to equip a dream weapon
	to_chat(user, span_userdanger("The weapon rejects your touch, burning with dream energy!"))
	user.dropItemToGround(source, TRUE)

	// Apply some damage or negative effect
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		spawn(0)
			H.apply_damage(10, BURN, pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))
			H.adjust_fire_stacks(2)
			H.ignite_mob()

/obj/item/rogueweapon/halberd/glaive/dreamscape
	name = "otherworldly spear"
	desc = "A strange spear, who knows where it came from. It seems like it is made out of ancient bone."
	icon_state = "dreamspear"
	anvilrepair = /datum/skill/craft/weaponsmithing
	smeltresult = null
	item_flags = DREAM_ITEM
	wbalance = WBALANCE_HEAVY
	max_blade_int = 200
	wdefense = 8

/obj/item/rogueweapon/halberd/glaive/dreamscape/active
	desc = "A strange spear, who knows where it came from. Strange harmonious sounds ring out as wind passes through the holes."
	icon_state = "dreamspearactive"
	max_blade_int = 400
	wdefense = 9
	force = 20
	force_wielded = 35

/obj/item/rogueweapon/greatsword/bsword/dreamscape
	name = "otherworldly sword"
	desc = "A strange sword made out of a strange reflective metal."
	icon_state = "dreamsword"
	force = 25
	force_wielded = 30
	max_integrity = 275
	smeltresult = null
	item_flags = DREAM_ITEM
	wbalance = WBALANCE_HEAVY
	wdefense = 4
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/sword/chop, /datum/intent/sword/thrust/long)
	gripped_intents = list(/datum/intent/sword/cut/zwei, /datum/intent/sword/chop, /datum/intent/sword/thrust/estoc/lunge, /datum/intent/sword/thrust/estoc)
	alt_grips = list(/datum/alt_grip/mordhau/broadsword/dream_broadsword)

/obj/item/rogueweapon/greatsword/bsword/dreamscape/active
	name = "otherworldly sword"
	desc = "A strange sword made out of a strange reflective metal. It oozes sickening sludge."
	icon_state = "dreamswordactive"
	max_integrity = 500
	force = 30
	force_wielded = 35
	wdefense = 5

/obj/item/rogueweapon/spear/dreamscape_trident
	name = "otherworldly trident"
	desc = "A strange trident. It feels like it shouldn't be an effective weapon, but the dull metal whispers tales of its power to you."
	icon_state = "dreamtri"
	smeltresult = null
	max_blade_int = 240
	minstr = 8
	wdefense = 4
	throwforce = 40
	force = 30
	force_wielded = 20
	item_flags = DREAM_ITEM
	var/shockwave_cooldown = 0
	var/shockwave_cooldown_interval = 1 MINUTES
	var/shockwave_divisor = 3
	var/shockwave_damage = FALSE

/obj/item/rogueweapon/spear/dreamscape_trident/active
	name = "Iridescent trident"
	desc = "A strange trident glimmering with an oily hue. The air shimmers around it."
	icon_state = "dreamtriactive"
	max_integrity = 480
	throwforce = 50
	force = 35
	force_wielded = 25
	wdefense = 5
	shockwave_cooldown_interval = 30 SECONDS
	shockwave_divisor = 2
	shockwave_damage = TRUE

// Update weapon initializations with specific effects
/obj/item/rogueweapon/greataxe/dreamscape/active/Initialize()
	. = ..()
	AddComponent(/datum/component/dream_weapon, "fire", 20 SECONDS)

/obj/item/rogueweapon/halberd/glaive/dreamscape/active/Initialize()
	. = ..()
	AddComponent(/datum/component/dream_weapon, "frost", 40 SECONDS)

/obj/item/rogueweapon/greatsword/bsword/dreamscape/active/Initialize()
	. = ..()
	AddComponent(/datum/component/dream_weapon, "poison", 20 SECONDS)

/obj/item/rogueweapon/spear/dreamscape_trident/active/Initialize()
	. = ..()
	AddComponent(/datum/component/dream_weapon, null, 20 SECONDS)

/datum/outfit/job/roguetown/dreamwalker_armorrite/pre_equip(mob/living/carbon/human/H)
	..()
	var/list/items = list()
	items |= H.get_equipped_items(TRUE)
	for(var/I in items)
		H.dropItemToGround(I, TRUE)
	H.drop_all_held_items()
	armor = /obj/item/clothing/suit/roguetown/armor/plate/full/dreamwalker
	pants = /obj/item/clothing/under/roguetown/platelegs/dreamwalker
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor/dreamwalker
	gloves = /obj/item/clothing/gloves/roguetown/plate/dreamwalker
	head = /obj/item/clothing/head/roguetown/helmet/bascinet/dreamwalker
	neck = /obj/item/clothing/neck/roguetown/bevor

/obj/item/clothing/suit/roguetown/armor/plate/full/dreamwalker
	name = "otherworldly fullplate"
	desc = "Strange iridescent full plate. It reflects light as if covered in shiny oil."
	icon_state = "dreamplate"
	max_integrity = ARMOR_INT_CHEST_PLATE_ANTAG
	item_flags = DREAM_ITEM

/obj/item/clothing/suit/roguetown/armor/plate/full/dreamwalker/Initialize()
	. = ..()
	AddComponent(/datum/component/dream_weapon, null, 20 SECONDS)

/obj/item/clothing/under/roguetown/platelegs/dreamwalker
	max_integrity = ARMOR_INT_LEG_ANTAG
	name = "otherworldly legplate"
	desc = "Strange iridescent leg plate. It reflects light as if covered in shiny oil."
	icon_state = "dreamlegs"
	armor = ARMOR_PLATE_BSTEEL
	item_flags = DREAM_ITEM

/obj/item/clothing/under/roguetown/platelegs/dreamwalker/Initialize()
	. = ..()
	AddComponent(/datum/component/dream_weapon, null, 20 SECONDS)

/obj/item/clothing/shoes/roguetown/boots/armor/dreamwalker
	max_integrity = ARMOR_INT_SIDE_ANTAG
	name = "otherworldly boots"
	desc = "Strange iridescent plated boots. It reflects light as if covered in shiny oil."
	icon_state = "dreamboots"
	armor = ARMOR_PLATE_BSTEEL
	item_flags = DREAM_ITEM

/obj/item/clothing/shoes/roguetown/boots/armor/dreamwalker/Initialize()
	. = ..()
	AddComponent(/datum/component/dream_weapon, null, 20 SECONDS)

/obj/item/clothing/gloves/roguetown/plate/dreamwalker
	name = "otherworldly gauntlets"
	desc = "Strange iridescent plated gauntlets. It reflects light as if covered in shiny oil."
	icon_state = "dreamgauntlets"
	max_integrity = ARMOR_INT_SIDE_ANTAG
	item_flags = DREAM_ITEM

/obj/item/clothing/gloves/roguetown/plate/dreamwalker/Initialize()
	. = ..()
	AddComponent(/datum/component/dream_weapon, null, 20 SECONDS)

/obj/item/clothing/neck/roguetown/bevor/dreamwalker
	name = "otherworldly bevor"
	desc = "Strange iridescent plated bevor. It reflects light as if covered in shiny oil."
	icon_state = "dbevor"
	max_integrity = ARMOR_INT_SIDE_ANTAG
	item_flags = DREAM_ITEM

/obj/item/clothing/neck/roguetown/bevor/dreamwalker/Initialize()
	. = ..()
	AddComponent(/datum/component/dream_weapon, null, 20 SECONDS)

/obj/item/clothing/head/roguetown/helmet/bascinet/dreamwalker
	name = "otherworldly squid helm"
	desc = "A otherworldly squid helm. It reflects light as if covered in shiny oil."
	adjustable = CAN_CADJUST
	icon_state = "dreamsquidhelm"
	max_integrity = ARMOR_INT_HELMET_ANTAG
	item_flags = DREAM_ITEM
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/32x48/head.dmi'
	block2add = null
	worn_x_dimension = 32
	worn_y_dimension = 48
	body_parts_covered = FULL_HEAD
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH

/obj/item/clothing/head/roguetown/helmet/bascinet/dreamwalker/Initialize()
	. = ..()
	AddComponent(/datum/component/dream_weapon, null, 20 SECONDS)

/datum/component/dreamwalker_repair
	/// List of dream items being repaired
	var/list/repairing_items = list()
	/// List of timers for broken items being fully repaired
	var/list/repair_timers = list()
	/// Processing interval
	/// Careful touching this as setting it too low makes it REALLY hard to break items.
	var/process_interval = 5 SECONDS
	/// Time of last processing
	var/last_process = 0

/datum/component/dreamwalker_repair/Initialize()
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE
	to_chat(parent, span_userdanger("Your body pulses with strange dream energies."))
	RegisterSignal(parent, COMSIG_MOB_EQUIPPED_ITEM, .proc/on_item_equipped)
	RegisterSignal(parent, COMSIG_MOB_DROPITEM, .proc/on_item_dropped)
	// Register for processing
	START_PROCESSING(SSprocessing, src)

/datum/component/dreamwalker_repair/Destroy()
	STOP_PROCESSING(SSprocessing, src)
	// Clean up all timers
	for(var/obj/item/I in repair_timers)
		deltimer(repair_timers[I])
	repair_timers = null
	repairing_items = null
	return ..()

/datum/component/dreamwalker_repair/process(delta_time)
	// Only process every x seconds
	if(world.time < last_process + process_interval)
		return

	last_process = world.time

	// Process all items in the repair list
	for(var/obj/item/I in repairing_items)
		if(I.obj_broken)
			continue // Broken items are handled separately
		if(I.obj_integrity < I.max_integrity)
			I.obj_integrity = min(I.obj_integrity + I.max_integrity * 0.01, I.max_integrity) // Repair 1% of max integrity
			I.update_icon()
		if(I.blade_int < I.max_blade_int)
			I.add_bintegrity(min(I.blade_int + I.max_blade_int * 0.01, I.max_blade_int), src.parent) // Sharpen 1% of max sharpness

/datum/component/dreamwalker_repair/proc/on_item_equipped(mob/user, obj/item/source, slot)
	SIGNAL_HANDLER
	if(source.item_flags & DREAM_ITEM)
		to_chat(parent, span_notice("the [source] pulses in your hands, dream energies passively repairing it."))
		add_item(source)

/datum/component/dreamwalker_repair/proc/on_item_dropped(mob/user, obj/item/source)
	SIGNAL_HANDLER
	if(source.item_flags & DREAM_ITEM)
		to_chat(parent, span_notice("the [source] stops pulsing as it leaves your person."))
		remove_item(source)

/datum/component/dreamwalker_repair/proc/add_item(obj/item/I)
	if(I in repairing_items)
		return
	repairing_items += I
	RegisterSignal(I, COMSIG_ITEM_BROKEN, .proc/on_item_broken)

	// If item is already broken, start full repair process
	if(I.obj_broken)
		start_full_repair(I)

/datum/component/dreamwalker_repair/proc/remove_item(obj/item/I)
	if(I in repairing_items)
		repairing_items -= I
		UnregisterSignal(I, COMSIG_ITEM_BROKEN)
		// Cancel any ongoing full repair
		if(I in repair_timers)
			deltimer(repair_timers[I])
			repair_timers -= I

/datum/component/dreamwalker_repair/proc/on_item_broken(obj/item/source)
	SIGNAL_HANDLER
	if(source in repairing_items)
		source.visible_message(span_danger("The [source] shatters, but it seems strange energies are slowly bending the metal back into shape."))
		start_full_repair(source)

/datum/component/dreamwalker_repair/proc/start_full_repair(obj/item/I)
	// Cancel any existing timer
	if(I in repair_timers)
		deltimer(repair_timers[I])

	// Set a timer to fully repair after 1 minute
	repair_timers[I] = addtimer(CALLBACK(src, .proc/finish_full_repair, I), 1 MINUTES, TIMER_STOPPABLE)

/datum/component/dreamwalker_repair/proc/finish_full_repair(obj/item/I)
	// Check if the item is still in our inventory and broken
	if(I && (I in repairing_items) && I.obj_broken)
		I.visible_message(span_danger("The [I] melds back into a useable shape."))
		I.obj_fix()
		// Restore up to 25% of durability instead of all of it. This is slightly more as I.integrity_failure for MOST things.
		I.obj_integrity *= 0.25
		I.update_icon()

	// Remove the timer reference
	repair_timers -= I
