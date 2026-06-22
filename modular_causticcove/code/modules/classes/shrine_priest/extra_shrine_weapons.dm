/obj/item/rogueweapon/scabbard/sword/kazengun/chokuto
	name = "chokuto scabbard"
	desc = "A polished and adorned scabbard with a cyan-colored cloth tassel attached. The symbol of a shrine priest hangs off the sash."
	icon = 'modular_causticcove/icons/items/scabbard.dmi'
	icon_state = "shrine_sheath"
	item_state = "shrine_sheath"
	valid_blade = /obj/item/rogueweapon/sword/sabre/mulyeog/chokuto

/obj/item/rogueweapon/scabbard/sword/kazengun/chokuto/decorated
	name = "decorated chokuto scabbard"
	desc = "A scabbard wrapped with fine purple silk, and a cyan-colored rope has been wrapped around the end."
	icon_state = "shrine_sheath_decorated"
	item_state = "shrine_sheath_decorated"
	valid_blade = /obj/item/rogueweapon/sword/sabre/mulyeog/chokuto/decorated

/obj/item/rogueweapon/sword/sabre/mulyeog/chokuto
	name = "chokuto"
	desc = "A single-edged blade with a cyan-colored tassel attached to the pommel. It is adorned with the symbol of a shrine priest at the end of it."
	icon = 'modular_causticcove/icons/weapons/swords32.dmi'
	sheathe_icon = "chokuto"
	icon_state = "chokuto"
	max_integrity = 200
	sellprice = 80

/obj/item/rogueweapon/sword/sabre/mulyeog/chokuto/decorated
	name = "decorated chokuto"
	desc = "A single-edged blade with a purple-colored tassel and wrapping attached to the grip. The tassel is adorned with the symbol of a shrine priest at the end of it."
	icon_state = "chokuto_decorated"
	force = 27
	max_integrity = 280
	sharpness_mod = 2
	sellprice = 150

/obj/item/rogueweapon/woodstaff/quarterstaff/iron/shrine_priest
	name = "iron quarterstaff"
	desc = "A fine quarterstaff decorated and adorned with the iconography of a shrine priest. It has weathered the trip so far, and it will continue to remain steady."
	icon = 'modular_causticcove/icons/weapons/polearms64.dmi'
	icon_state = "shrinestaff"
	associated_skill = /datum/skill/combat/staves
	max_integrity = 250
	sellprice = 30
