/obj/item/reagent_containers/peppermill // new with some animated art
	name = "pepper mill"
	desc = "Let the lord have his snack; twist the head until it cracks."
	icon = 'modular/Neu_Food/icons/cookware/peppermill.dmi'
	icon_state = "peppermill"
	layer = CLOSED_BLASTDOOR_LAYER // obj layer + a little, small obj layering above convenient
	drop_sound = 'sound/foley/dropsound/gen_drop.ogg'
	list_reagents = list(/datum/reagent/consumable/blackpepper = 5)
	reagent_flags = TRANSPARENT

/obj/item/reagent_containers/peppermill/get_mechanics_examine(mob/user)
	. = ..()
	. += span_info("Left-clicking a variety of cooked meats, such as frysteaks and fillets of fish, will season them into higher-classed meals.")

/obj/item/reagent_containers/peppermill/attackby(obj/item/P, mob/living/user, params)
    if(istype(P, /obj/item/reagent_containers/food/snacks/grown/pepperseed))
        if(do_after(user, 30))
            src.reagents.add_reagent(/datum/reagent/consumable/blackpepper, 3)
            user.visible_message("<span class='notice'>[user] fills the [src] with [P].</span>")
            qdel(P)
            return
        else
            to_chat(user, "<span class='warning'>I need to stand still to fill the peppermill!</span>")
        return ..()

/obj/item/reagent_containers/peppermill/innkeeper
	name = "overburderned pepper mill"
	desc = "Let the lord have his snack; twist the head until it cracks. Specially commissioned by the crown from the local university specifically for any inkeeper. It can hold double the amount of a regular peppermill!"
	volume = 60
	list_reagents = list(/datum/reagent/consumable/blackpepper = 30)
