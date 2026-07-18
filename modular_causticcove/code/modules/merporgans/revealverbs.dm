/mob/living/carbon/verb/reveal_bodypart()
	set name = "Reveal Bodypart"
	set desc = "Toggles between always showing or hiding your chosen bodypart, regardless of clothing worn."
	set category = "IC.Actions"

	var/list/choices = list("Penis", "Vagina", "Breasts", "Testicles", "Butt", "Belly")
	var/chosen = tgui_input_list(src, "Reveal what part?", "Exhibitionist~", choices)
	if(!chosen)
		return

	switch(chosen)
		if("Penis")
			var/obj/item/organ/penis/dong = src.internal_organs_slot[ORGAN_SLOT_PENIS]
			if(dong)
				dong.always_show = !dong.always_show
				/*if(dong.always_show)
					dong.relevant_layers = list(BODY_FRONT_LAYER)
				else
					dong.relevant_layers = list(CROTCH_LAYER)*/
				to_chat(src, span_notice("You are now [dong.always_show ? "revealing" : "hiding"] your penis."))
				src.update_body_parts(TRUE)
			else
				to_chat(src, span_notice("You don't have a penis!"))
			return
		if("Vagina")
			var/obj/item/organ/vagina/vag = src.internal_organs_slot[ORGAN_SLOT_VAGINA]
			if(vag)
				vag.always_show = !vag.always_show
				/*if(vag.always_show)
					vag.relevant_layers = list(BODY_FRONT_LAYER)
				else
					vag.relevant_layers = list(CROTCH_LAYER)*/
				to_chat(src, span_notice("You are now [vag.always_show ? "revealing" : "hiding"] your vagina."))
				src.update_body_parts(TRUE)
			else
				to_chat(src, span_notice("You don't have a vagina!"))
			return
		if("Breasts")
			var/obj/item/organ/breasts/booba = src.internal_organs_slot[ORGAN_SLOT_BREASTS]
			if(booba)
				booba.always_show = !booba.always_show
				/*if(booba.always_show)
					booba.relevant_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
				else
					booba.relevant_layers = list(BODY_BEHIND_LAYER, BREASTS_LAYER)*/
				to_chat(src, span_notice("You are now [booba.always_show ? "revealing" : "hiding"] your breasts."))
				src.update_body_parts(TRUE)
			else
				to_chat(src, span_notice("You don't have breasts!"))
			return
		if("Testicles")
			var/obj/item/organ/testicles/balls = src.internal_organs_slot[ORGAN_SLOT_TESTICLES]
			if(balls)
				balls.always_show = !balls.always_show
				/*if(balls.always_show)
					balls.relevant_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
				else
					balls.relevant_layers = list(BODY_BEHIND_LAYER, TESTICLES_LAYER)*/
				to_chat(src, span_notice("You are now [balls.always_show ? "revealing" : "hiding"] your testicles."))
				src.update_body_parts(TRUE)
			else
				to_chat(src, span_notice("You don't have testicles!"))
			return
		if("Butt")
			var/obj/item/organ/butt/ass = src.internal_organs_slot[ORGAN_SLOT_BUTT]
			if(ass)
				ass.always_show = !ass.always_show
				/*if(ass.always_show)
					ass.relevant_layers = list(BODY_FRONT_LAYER)
				else
					ass.relevant_layers = list(ASS_LAYER)*/
				to_chat(src, span_notice("You are now [ass.always_show ? "revealing" : "hiding"] your butt."))
				src.update_body_parts(TRUE)
			else
				to_chat(src, span_notice("You don't have a butt!"))
			return
		if("Belly")
			var/obj/item/organ/belly/tum = src.internal_organs_slot[ORGAN_SLOT_BELLY]
			if(tum)
				tum.always_show = !tum.always_show
				/*if(tum.always_show)
					tum.relevant_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
				else
					tum.relevant_layers = list(BODY_BEHIND_LAYER, BELLY_LAYER)*/
				to_chat(src, span_notice("You are now [tum.always_show ? "revealing" : "hiding"] your belly."))
				src.update_body_parts(TRUE)
			else
				to_chat(src, span_notice("You don't have a belly!"))
			return
			
/mob/living/carbon/verb/toggle_taur_mask()
	set name = "Toggle Taur Clothingmask"
	set desc = "Toggles between enabling or disabling the clothing clipping mask that hides certain clothing layers from clipping over the Taur half."
	set category = "IC.Actions"

	var/obj/item/bodypart/BP = src.get_bodypart(BODY_ZONE_L_LEG)
	if(!BP || !istype(BP, /obj/item/bodypart/taur))
		to_chat(src, span_notice("You are not a taur."))
		return
	
	var/obj/item/bodypart/taur/T = BP
	T.use_mask = !T.use_mask
	to_chat(src, span_notice("You are now [T.use_mask ? "using" : "ignoring"] the Taur clothing mask!"))
	src.queue_icon_update(PENDING_UPDATE_INV_CLOAK|PENDING_UPDATE_INV_SHIRT|PENDING_UPDATE_INV_ARMOR|PENDING_UPDATE_INV_PANTS)
