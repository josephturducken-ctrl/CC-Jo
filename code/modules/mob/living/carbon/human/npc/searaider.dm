GLOBAL_LIST_INIT(searaider_aggro, world.file2list("strings/rt/searaideraggrolines.txt"))

/mob/living/carbon/human/species/human/northern/searaider
	ai_controller = /datum/ai_controller/human_npc
	d_intent = INTENT_PARRY
	faction = list(FACTION_GRONNMEN, FACTION_STATION)
	ambushable = FALSE
	dodgetime = 30
	blood_toll_bucket = STATS_KILLED_GRONNMEN

/mob/living/carbon/human/species/human/northern/searaider/ambush
	threat_point = THREAT_MODERATE
	ambush_faction = "raiders"



/mob/living/carbon/human/species/human/northern/searaider/Initialize()
	. = ..()
	set_species(/datum/species/human/northern)
	addtimer(CALLBACK(src, PROC_REF(after_creation)), 1 SECONDS)


/mob/living/carbon/human/species/human/northern/searaider/after_creation()
	..()
	AddComponent(/datum/component/ai_aggro_system)
	SEND_SIGNAL(src, COMSIG_MOB_MODIFY_AGGRO_LINES, GLOB.searaider_aggro, TRUE)
	job = "Sea Raider"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_LEECHIMMUNE, INNATE_TRAIT)
	ADD_TRAIT(src, TRAIT_BREADY, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/human/species/human/northern/searaider)
	gender = pick(MALE, FEMALE)
	var/obj/item/organ/eyes/organ_eyes = getorgan(/obj/item/organ/eyes)
	var/obj/item/bodypart/head/head = get_bodypart(BODY_ZONE_HEAD)
	var/hairf = pick(list(/datum/sprite_accessory/hair/head/lowbraid,
						/datum/sprite_accessory/hair/head/countryponytailalt))
	var/hairm = pick(list(/datum/sprite_accessory/hair/head/ponytailwitcher,
						/datum/sprite_accessory/hair/head/lowbraid))
	var/beard = pick(list(/datum/sprite_accessory/hair/facial/viking,
						/datum/sprite_accessory/hair/facial/manly,
						/datum/sprite_accessory/hair/facial/longbeard))
	head.sellprice = HEAD_BOUNTY_SEARAIDER
	var/species = list(
		/datum/species/human/northern,
		/datum/species/human/northern, //Extra bias towards humens and dwarves/half elves
		/datum/species/human/northern,
		/datum/species/elf/wood,
		/datum/species/human/halfelf,
		/datum/species/human/halfelf,
		/datum/species/dwarf/mountain,
		/datum/species/dwarf/mountain,
	)

	set_species(pick(species))
	sleep(1) //To avoid bugs W/skin tone
	//Random voices, this can probably be more random-ish but it'll do for now
	var/voice_choice = rand(1, 12)
	switch(voice_choice)
		if(1)
			src.voice_color = "0bb1e4"
		if(2)
			src.voice_color = "d30c0c"
		if(3)
			src.voice_color = "4d4afc"
		if(4)
			src.voice_color = "da40c0"
		if(5)
			src.voice_color = "51e251"
		if(6)
			src.voice_color = "a059cf"
		if(7)
			src.voice_color = "8700c5"
		if(8)
			src.voice_color = "cfc886"
		if(9)
			src.voice_color = "ff9100"
		if(10)
			src.voice_color = "a0a0a0"
		if(11)
			src.voice_color = "797979"
		if(12)
			src.voice_color = "ff5e00"
	//Next up, we add hair
	var/datum/bodypart_feature/hair/head/new_hair = new()
	var/datum/bodypart_feature/hair/facial/new_facial = new()

	if(gender == FEMALE)
		new_hair.set_accessory_type(hairf, null, src)
	else
		new_hair.set_accessory_type(hairm, null, src)
		new_facial.set_accessory_type(beard, null, src)

	var/haircolor_choice = rand(1, 4)
	switch(haircolor_choice)
		if(1)
			new_hair.accessory_colors = "#C1A287"
			new_hair.hair_color = "#C1A287"
			new_facial.accessory_colors = "#C1A287"
			new_facial.hair_color = "#C1A287"
			hair_color = "#C1A287"
		if(2)
			new_hair.accessory_colors = "#A56B3D"
			new_hair.hair_color = "#A56B3D"
			new_facial.accessory_colors = "#A56B3D"
			new_facial.hair_color = "#A56B3D"
			hair_color = "#A56B3D"
		if(3) //Black
			new_hair.accessory_colors = "#030107"
			new_hair.hair_color = "#030107"
			new_facial.accessory_colors = "#030107"
			new_facial.hair_color = "#030107"
			hair_color = "#030107"
		if(4) //Red
			new_hair.accessory_colors = "#a53d3d"
			new_hair.hair_color = "#a53d3d"
			new_facial.accessory_colors = "#a53d3d"
			new_facial.hair_color = "#a53d3d"
			hair_color = "#a53d3d"
	//Now we take skin-tone picks
	var/obj/item/organ/ears/organ_ears = getorgan(/obj/item/organ/ears)
	var/skintone_choice = rand(1, 7) //Heavily simplified
	switch(skintone_choice)
		if(1)
			skin_tone = "SKIN_COLOR_GRENZELHOFT"
			if(organ_ears)
				organ_ears.accessory_colors = "SKIN_COLOR_GRENZELHOFT"
		if(2)
			skin_tone = "SKIN_COLOR_AVAR"
			if(organ_ears)
				organ_ears.accessory_colors = "SKIN_COLOR_AVAR"
		if(3)
			skin_tone = "SKIN_COLOR_OTAVA"
			if(organ_ears)
				organ_ears.accessory_colors = "SKIN_COLOR_OTAVA"
		if(4)
			skin_tone = "SKIN_COLOR_SHALVISTINE"
			if(organ_ears)
				organ_ears.accessory_colors = "SKIN_COLOR_SHALVISTINE"
		if(5)
			skin_tone = "SKIN_COLOR_LALVESTINE"
			if(organ_ears)
				organ_ears.accessory_colors = "SKIN_COLOR_LALVESTINE"
		if(6)
			skin_tone = "SKIN_COLOR_NALEDI"
			if(organ_ears)
				organ_ears.accessory_colors = "SKIN_COLOR_NALEDI"
		if(7)
			skin_tone = "SKIN_COLOR_KAZENGUN"
			if(organ_ears)
				organ_ears.accessory_colors = "SKIN_COLOR_KAZENGUN"
	//Add our hair bodypart features
	head.add_bodypart_feature(new_hair)
	head.add_bodypart_feature(new_facial)

	dna.update_ui_block(DNA_HAIR_COLOR_BLOCK)
	dna.species.handle_body(src)

	if(organ_eyes)
		organ_eyes.eye_color = "#336699"
		organ_eyes.accessory_colors = "#336699#336699"

	if(gender == FEMALE)
		real_name = pick(world.file2list("strings/rt/names/human/vikingf.txt"))
	else
		real_name = pick(world.file2list("strings/rt/names/human/vikingm.txt"))
	update_hair()
	update_body()


/datum/outfit/job/roguetown/human/species/human/northern/searaider/pre_equip(mob/living/carbon/human/H)
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	if(prob(50))
		wrists = /obj/item/clothing/wrists/roguetown/bracers/leather/heavy
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
	if(prob(50))
		shirt = /obj/item/clothing/suit/roguetown/shirt/tunic
	pants = /obj/item/clothing/under/roguetown/tights
	if(prob(50))
		pants = /obj/item/clothing/under/roguetown/chainlegs/iron
	head = /obj/item/clothing/head/roguetown/helmet/leather
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/helmet/horned
	if(prob(50))
		neck = /obj/item/clothing/neck/roguetown/gorget
	if(prob(50))
		gloves = /obj/item/clothing/gloves/roguetown/leather
	var/archer_variant = FALSE
	if(prob(30)) // archer
		backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
		backl = /obj/item/quiver/arrows
		r_hand = /obj/item/rogueweapon/sword/iron
		H.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.upgrade_ai_controller(/datum/ai_controller/human_npc/archer)
		archer_variant = TRUE
	else
		switch(rand(1, 4))
			if(1)
				r_hand = /obj/item/rogueweapon/sword/iron
				l_hand = /obj/item/rogueweapon/shield/wood
			if(2)
				r_hand = /obj/item/rogueweapon/spear
			if(3)
				r_hand = /obj/item/rogueweapon/greataxe
			if(4)
				r_hand = /obj/item/rogueweapon/greatsword/iron

	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	H.STASPD = 9
	H.STACON = 8
	H.STAWIL = 8
	H.STAPER = 10
	H.STAINT = 1
	H.STASTR = 14
	if(archer_variant)
		H.STASTR -= 2
		H.STAPER += 3
	H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)

/mob/living/carbon/human/species/human/northern/searaider/archer
	ai_controller = /datum/ai_controller/human_npc/archer

/mob/living/carbon/human/species/human/northern/searaider/archer/ambush
	threat_point = THREAT_MODERATE
	ambush_faction = "raiders"

/mob/living/carbon/human/species/human/northern/searaider/archer/after_creation()
	..()
	for(var/obj/item/I in held_items)
		qdel(I)
	for(var/obj/item/I in get_equipped_items(FALSE))
		if(istype(I, /obj/item/gun) || istype(I, /obj/item/quiver))
			qdel(I)
	equipOutfit(new /datum/outfit/job/roguetown/human/species/human/northern/searaider/archer)

/datum/outfit/job/roguetown/human/species/human/northern/searaider/archer/pre_equip(mob/living/carbon/human/H)
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
	shirt = /obj/item/clothing/suit/roguetown/shirt/tunic
	pants = /obj/item/clothing/under/roguetown/tights
	head = /obj/item/clothing/head/roguetown/helmet/leather
	gloves = /obj/item/clothing/gloves/roguetown/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
	backl = /obj/item/quiver/arrows
	r_hand = /obj/item/rogueweapon/sword/iron
	H.STASPD = 9
	H.STACON = 8
	H.STAWIL = 8
	H.STAPER = 13
	H.STAINT = 1
	H.STASTR = 12
	H.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.upgrade_ai_controller(/datum/ai_controller/human_npc/archer)
