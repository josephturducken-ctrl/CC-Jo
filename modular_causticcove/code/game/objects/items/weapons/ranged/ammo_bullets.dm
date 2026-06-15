//Internal Mag Defines for the guns
/obj/item/ammo_box/magazine/internal/blackpowder
	name = "blackpowder weapon barrel"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/bullet/blackpowder
	caliber = "musketball"
	max_ammo = 1
	start_empty = TRUE

//Bullet Ammo and Projectile Defines
// -- Base Blackpowder Bullet --
/obj/item/ammo_casing/caseless/rogue/bullet/blackpowder
	name = "iron musketball"
	desc = "A small metal sphere to be fired from a gun."
	projectile_type = /obj/projectile/bullet/reusable/bullet/blackpowder
	caliber = "musketball"
	icon = 'icons/roguetown/weapons/ranged/sling_mob.dmi' //Caustic Edit - Re-add the icon file
	icon_state = "musketball"
	dropshrink = 0.5
	possible_item_intents = list(/datum/intent/use)
	max_integrity = 0.1

/obj/projectile/bullet/reusable/bullet/blackpowder //Adjust the stats of the bullet's damage and range through the weapon's individual modifier stats instead of here!
	name = "iron ball"
	damage = 100 //Setting this to 100 for easier math on the weapon's end. THIS variable should probably remain 100, since the individual multipliers on the weapons have been keyed into this number. Adjusting this will change all weapons similarly.
	icon = 'icons/roguetown/weapons/ranged/sling_proj.dmi'
	icon_state = "scatter_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/bullet/blackpowder
	range = 30 //This can be overridden with the stats on the guns themselves.
	hitsound = 'sound/combat/hits/hi_bolt (1).ogg'
	embedchance = 95 //It honestly might be funny the small chance it doesn't embed to have rediculous situations. Did it go through? Did it not at all (somehow)?
	woundclass = BCLASS_PIERCE
	flag = "piercing"
	armor_penetration = PEN_HEAVY
	speed = 0.1
	npc_simple_damage_mult = 2
