/datum/action/cooldown/spell/voided_beam
	button_icon = 'icons/mob/actions/mage_shared.dmi'
	name = "Void Beam"
	desc = "Fire a concentrated beam of void energy! Any objects in it's path will be dealt constant damage as long as they remain in contact with the beam.  It can be channeled for up to 3 seconds, during which you are unable to move or it breaks your concentration! Devine Skeleton Death Blast!"
	fluff_desc = "A spell sought after by mages and wizards who encountered denizens of the planar void utilizing similar attacks. It took some time, but eventually they were able to mimic the concentrated beam of energy. It lacks the same aspects of the void that originated the idea, but it is only a matter of time before that too is able to be utilized."
	button_icon_state = "soulshot"
	sound = 'sound/magic/obeliskbeam.ogg'
	spell_color = GLOW_COLOR_KINESIS
	glow_intensity = GLOW_INTENSITY_MEDIUM

	cast_range = SPELL_RANGE_PROJECTILE
	point_cost = 3

	primary_resource_type = SPELL_COST_STAMINA
	primary_resource_cost = SPELLCOST_SINGLE_CC

	invocations = list("Focus Vacui Esotericus!")
	invocation_type = INVOCATION_SHOUT

	charge_required = TRUE
	weapon_cast_penalized = TRUE
	charge_time = CHARGETIME_MINOR
	hold_drain = 1
	charge_slowdown = CHARGING_SLOWDOWN_MEDIUM
	charge_sound = 'sound/magic/charging.ogg'
	cooldown_time = 25 SECONDS
	attunement_school = ASPECT_NAME_KINESIS

	associated_skill = /datum/skill/magic/arcane
	spell_tier = 2
	spell_impact_intensity = SPELL_IMPACT_MEDIUM
	displayed_damage = 25

	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC | SPELL_REQUIRES_HUMAN | SPELL_REQUIRES_SAME_Z

	var/initial_beam_damage = 25
	var/beam_contact_damage = 10
	var/beam_duration = 3 SECONDS
	var/list/beam_parts = list()

/datum/action/cooldown/spell/voided_beam/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/H = owner
	if(!istype(H))
		return FALSE

	var/turf/T = get_turf(cast_on)
	if(!T)
		return FALSE

	var/turf/source_turf = get_turf(H)
	if(T.z > H.z)
		source_turf = get_step_multiz(source_turf, UP)
	if(T.z < H.z)
		source_turf = get_step_multiz(source_turf, DOWN)
	if(!(T in get_hear(cast_range, source_turf)))
		to_chat(H, span_warning("I can't cast where I can't see!"))
		return FALSE
	
	fire_beam(T)
	do_after(owner, delay = beam_duration, target = owner)
	end_beam()
	return TRUE

/datum/action/cooldown/spell/voided_beam/proc/fire_beam(var/turf/target_turf)
	var/turf/origin_turf = get_turf(owner)
	playsound(origin_turf, 'sound/magic/obeliskbeam.ogg', 150, FALSE, 0, 3)
	var/list/affected_turfs = get_line(origin_turf, target_turf) - origin_turf
	for(var/turf/affected_turf in affected_turfs)
		if(affected_turf.opacity)
			break
		var/blocked = FALSE
		for(var/obj/potential_block in affected_turf.contents)
			if(potential_block.opacity)
				blocked = TRUE
				break
		if(blocked)
			break
		var/obj/effect/obeliskbeam/void/new_voidbeam = new(affected_turf)
		new_voidbeam.contact_damage = 10
		new_voidbeam.dir = owner.dir
		beam_parts += new_voidbeam
		new_voidbeam.assign_creator(owner)
		for(var/mob/living/hit_mob in affected_turf.contents)
			hit_mob.apply_damage(damage = 25, damagetype = BURN)
			to_chat(hit_mob, span_userdanger("You're blasted by [owner]'s void beam!"))
//		RegisterSignal(new_voidbeam, COMSIG_QDELETING, PROC_REF(end_beam)) // In case idk a singularity eats it or something
	if(!length(beam_parts))
		return FALSE
	var/atom/last_voidbeam = beam_parts[length(beam_parts)]
	last_voidbeam.icon_state = "obeliskbeam_end"
	var/atom/first_voidbeam = beam_parts[1]
	first_voidbeam.icon_state = "obeliskbeam_start"
	return TRUE

/// Get rid of our laser when we are done with it
/datum/action/cooldown/spell/voided_beam/proc/end_beam()
	if(!length(beam_parts))
		return FALSE
	for(var/obj/effect/obeliskbeam/void/beam in beam_parts)
		beam.disperse()
	beam_parts = list()

/// Segments of the actual beam, these hurt if you stand in them
/obj/effect/obeliskbeam/void
	name = "concentrated arcyne beam"
	var/contact_damage

/obj/effect/obeliskbeam/void/New(loc, var/dam)
	contact_damage = dam
	. = ..()

/// Hurt the passed mob
/obj/effect/obeliskbeam/void/damage(mob/living/hit_mob)
	hit_mob.apply_damage(damage = contact_damage, damagetype = BURN)
	to_chat(hit_mob, span_danger("You're damaged by [src]!"))
