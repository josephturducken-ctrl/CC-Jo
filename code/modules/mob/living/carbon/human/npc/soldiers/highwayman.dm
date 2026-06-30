GLOBAL_LIST_INIT(highwayman_aggro, world.file2list("strings/rt/highwaymanaggrolines.txt"))

/mob/living/carbon/human/species/human/northern/highwayman
	ai_controller = /datum/ai_controller/human_npc
	faction = list(FACTION_BANDITS, FACTION_STATION)
	ambushable = FALSE
	dodgetime = 30
	d_intent = INTENT_PARRY
	blood_toll_bucket = STATS_KILLED_HIGHWAYMEN

/mob/living/carbon/human/species/human/northern/highwayman/ambush
	threat_point = THREAT_MODERATE
	ambush_faction = "bandits"

/mob/living/carbon/human/species/human/northern/highwayman/mount_reaver
	name = "mount reaver"
	threat_point = THREAT_HIGH
	ambush_faction = "bandits"

/mob/living/carbon/human/species/human/northern/highwayman/mount_reaver/after_creation()
	..()
	job = "Mount Reaver"
	equipOutfit(new /datum/outfit/job/roguetown/human/species/human/northern/mount_reaver)



/mob/living/carbon/human/species/human/northern/highwayman/Initialize()
	. = ..()
	set_species(/datum/species/human/northern)
	addtimer(CALLBACK(src, PROC_REF(after_creation)), 1 SECONDS)


/mob/living/carbon/human/species/human/northern/highwayman/after_creation()
	..()
	AddComponent(/datum/component/ai_aggro_system)
	SEND_SIGNAL(src, COMSIG_MOB_MODIFY_AGGRO_LINES, GLOB.highwayman_aggro, TRUE)
	job = "Highwayman"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_LEECHIMMUNE, INNATE_TRAIT)
	ADD_TRAIT(src, TRAIT_BREADY, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/human/species/human/northern/highwayman)
	var/obj/item/organ/eyes/organ_eyes = getorgan(/obj/item/organ/eyes)
	if(organ_eyes)
		organ_eyes.eye_color = pick("27becc", "35cc27", "000000")
	update_hair()
	update_body()
	var/obj/item/bodypart/head/head = get_bodypart(BODY_ZONE_HEAD)
	head.sellprice = HEAD_BOUNTY_HIGHWAYMAN
	var/species = list(
		/datum/species/human/northern,
		/datum/species/human/northern, //Extra bias towards humens and wood/half elves
		/datum/species/human/northern,
		/datum/species/elf/wood,
		/datum/species/elf/wood,
		/datum/species/human/halfelf,
		/datum/species/human/halfelf,
		/datum/species/dwarf/mountain,
	)

	set_species(pick(species))
	var/hairf = pick(list(
						/datum/sprite_accessory/hair/head/lowbraid,
						/datum/sprite_accessory/hair/head/countryponytailalt,
						/datum/sprite_accessory/hair/head/gloomy,
						/datum/sprite_accessory/hair/head/zone,
						/datum/sprite_accessory/hair/head/hime,
						/datum/sprite_accessory/hair/head/stacy,
						/datum/sprite_accessory/hair/head/sabitsuki,
						/datum/sprite_accessory/hair/head/sabitsuki_ponytail, 
						/datum/sprite_accessory/hair/head/kusanagi_alt,
						/datum/sprite_accessory/hair/head/fluffy,
						/datum/sprite_accessory/hair/head/fluffylong))
	var/hairm = pick(list(
						/datum/sprite_accessory/hair/head/ponytailwitcher,
						/datum/sprite_accessory/hair/head/bowlcut, 
						/datum/sprite_accessory/hair/head/bowlcut2,
						/datum/sprite_accessory/hair/head/lowbraid,
						/datum/sprite_accessory/hair/head/emo,
						/datum/sprite_accessory/hair/head/sabitsuki,
						/datum/sprite_accessory/hair/head/sabitsuki_ponytail, 
						/datum/sprite_accessory/hair/head/rogue))
	var/beard = pick(list(/datum/sprite_accessory/hair/facial/stubble,
						/datum/sprite_accessory/hair/facial/manly,
						/datum/sprite_accessory/hair/facial/fiveoclockmoustache,
						/datum/sprite_accessory/hair/facial/sevenoclockm,
						/datum/sprite_accessory/hair/facial/chinlessbeard,
						/datum/sprite_accessory/hair/facial/fullbeard,
						/datum/sprite_accessory/hair/facial/chinstrap,
						/datum/sprite_accessory/hair/facial/vandyke,
						/datum/sprite_accessory/hair/facial/longbeard))
	AddComponent(/datum/component/npc_death_line, null, 25)


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
	//eye picks, we have four-cause its easier to work with. Don't ask me why it randomly breaks to white eyes but sovlful NGL
	if(organ_eyes)
		var/eye_choice = rand(1, 4)
		switch(eye_choice)
			if(1)
				organ_eyes.eye_color = "#336699"
				organ_eyes.accessory_colors = "#336699#336699"
			if(2)
				organ_eyes.eye_color = "#339933"
				organ_eyes.accessory_colors = "#339933#339933"
			if(3)
				organ_eyes.eye_color = "#995333"
				organ_eyes.accessory_colors = "#995333#995333"
			if(3)
				organ_eyes.eye_color = "#131313" //Souless greytider look
				organ_eyes.accessory_colors = "#131313#131313"

	if(gender == FEMALE)
		real_name = pick(world.file2list("strings/names/first_female.txt"))
	else
		real_name = pick(world.file2list("strings/names/first_male.txt"))
	update_hair()
	update_body()
	src.regenerate_icons() //Fixes the weird body


/datum/outfit/job/roguetown/human/species/human/northern/highwayman/pre_equip(mob/living/carbon/human/H)
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	if(prob(50))
		mask = /obj/item/clothing/mask/rogue/ragmask/red
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
	if(prob(50))
		shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/light
	pants = /obj/item/clothing/under/roguetown/trou/leather
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/helmet/leather
	if(prob(30))
		head = /obj/item/clothing/head/roguetown/helmet/leather/volfhelm
	if(prob(50))
		neck = /obj/item/clothing/neck/roguetown/coif
	gloves = /obj/item/clothing/gloves/roguetown/leather
	H.STASTR = rand(12,14) //GENDER EQUALITY!!
	H.STASPD = 11
	H.STACON = 6
	H.STAWIL = 6
	H.STAPER = 10
	H.STAINT = 8
	if(prob(50))
		r_hand = /obj/item/rogueweapon/sword/short/iron
	else
		r_hand = /obj/item/rogueweapon/mace/cudgel
	if(prob(20))
		r_hand = /obj/item/rogueweapon/sword/falchion/militia
	if(prob(20))
		r_hand = /obj/item/rogueweapon/pick/militia
	if(prob(25))
		l_hand = /obj/item/rogueweapon/shield/wood
	if(prob(10))
		l_hand = /obj/item/rogueweapon/shield/buckler/palloy
	if(prob(15))
		neck = /obj/item/storage/belt/rogue/pouch/bombs
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	if(prob(30))
		neck = /obj/item/clothing/neck/roguetown/leather
	H.eye_color = "27becc"
	H.hair_color = "61310f"
	H.facial_hair_color = H.hair_color
	if(H.gender == FEMALE)
		H.hairstyle =  "Messy (Rogue)"
	else
		H.hairstyle = "Messy"
		H.facial_hairstyle = "Beard (Manly)"
	H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE) // Trash mobs, untrained.
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)

/datum/outfit/job/roguetown/human/species/human/northern/mount_reaver/pre_equip(mob/living/carbon/human/H)
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	if(prob(50))
		mask = /obj/item/clothing/mask/rogue/ragmask/red
	armor = /obj/item/clothing/suit/roguetown/armor/plate/cuirass/iron
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	pants = /obj/item/clothing/under/roguetown/trou/leather
	if(prob(55))
		head = /obj/item/clothing/head/roguetown/helmet/skullcap
	else if(prob(30))
		head = /obj/item/clothing/head/roguetown/helmet/sallet/visored/iron
	else if(prob(30))
		head = /obj/item/clothing/head/roguetown/helmet/heavy/barbute
	else
		head = /obj/item/clothing/head/roguetown/helmet/kettle/iron
	if(prob(70))
		neck = /obj/item/clothing/neck/roguetown/coif
	gloves = /obj/item/clothing/gloves/roguetown/leather
	H.STASTR = 12
	H.STASPD = 11
	H.STACON = 8
	H.STAWIL = 8
	H.STAPER = 11
	H.STAINT = 8
	if(prob(35))
		r_hand = /obj/item/rogueweapon/sword/short/iron
	else if(prob(30))
		r_hand = /obj/item/rogueweapon/sword/falchion/militia
	else if(prob(20))
		r_hand = /obj/item/rogueweapon/mace/cudgel
	else
		r_hand = /obj/item/rogueweapon/pick/militia
	if(prob(30))
		l_hand = /obj/item/rogueweapon/shield/tower
	else if(prob(35))
		l_hand = /obj/item/rogueweapon/shield/wood
	else if(prob(15))
		l_hand = /obj/item/rogueweapon/shield/buckler/palloy
	if(prob(25))
		neck = /obj/item/storage/belt/rogue/pouch/bombs
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	H.eye_color = "27becc"
	H.hair_color = "61310f"
	H.facial_hair_color = H.hair_color
	if(H.gender == FEMALE)
		H.hairstyle =  "Messy (Rogue)"
	else
		H.hairstyle = "Messy"
		H.facial_hairstyle = "Beard (Manly)"
	H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
