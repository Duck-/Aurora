/obj/item/weapon/banhammer
	desc = "A banhammer"
	name = "banhammer"
	icon = 'icons/obj/items.dmi'
	icon_state = "toyhammer"
	flags = FPRINT | TABLEPASS
	slot_flags = SLOT_BELT
	throwforce = 0
	w_class = 2.0
	throw_speed = 7
	throw_range = 15
	attack_verb = list("banned")

	suicide_act(mob/user)
		viewers(user) << "\red <b>[user] is hitting \himself with the [src.name]! It looks like \he's trying to ban \himself from life.</b>"
		return (BRUTELOSS|FIRELOSS|TOXLOSS|OXYLOSS)

/obj/item/weapon/nullrod
	name = "null rod"
	desc = "A rod of pure obsidian, its very presence disrupts and dampens the powers of paranormal phenomenae."
	icon_state = "nullrod"
	item_state = "nullrod"
	flags = FPRINT | TABLEPASS
	slot_flags = SLOT_BELT
	force = 15
	throw_speed = 1
	throw_range = 4
	throwforce = 10
	w_class = 2

	suicide_act(mob/user)
		viewers(user) << "\red <b>[user] is impaling \himself with the [src.name]! It looks like \he's trying to commit suicide.</b>"
		return (BRUTELOSS|FIRELOSS)

/obj/item/weapon/nullrod/attack(mob/M as mob, mob/living/user as mob) //Paste from old-code to decult with a null rod.

	M.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been attacked with [src.name] by [user.name] ([user.ckey])</font>")
	user.attack_log += text("\[[time_stamp()]\] <font color='red'>Used the [src.name] to attack [M.name] ([M.ckey])</font>")

	msg_admin_attack("[user.name] ([user.ckey]) attacked [M.name] ([M.ckey]) with [src.name] (INTENT: [uppertext(user.a_intent)]) (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>)")

	if (!(istype(user, /mob/living/carbon/human) || ticker) && ticker.mode.name != "monkey")
		user << "\red You don't have the dexterity to do this!"
		return

	if ((CLUMSY in user.mutations) && prob(50))
		user << "\red The rod slips out of your hand and hits your head."
		user.take_organ_damage(10)
		user.Paralyse(20)
		return

	if (M.stat !=2)
		if((M.mind in ticker.mode.cult) && prob(33))
			M << "\red The power of [src] clears your mind of the cult's influence!"
			user << "\red You wave [src] over [M]'s head and see their eyes become clear, their mind returning to normal."
			ticker.mode.remove_cultist(M.mind)
			for(var/mob/O in viewers(M, null))
				O.show_message(text("\red [] waves [] over []'s head.", user, src, M), 1)
/*		else if(prob(10)) //Fail chance is kind of dumb for something so rarely used.
			user << "\red The rod slips in your hand."
			..()*/
		else if(M.mind)
			if(M.mind.vampire)
				if(ishuman(M))
					if(!(VAMP_FULL in M.mind.vampire.powers))
						user << "\red The rod burns cold in your hand, filling you with grim determination.  You feel the creature's power weaken."
						M << "<span class='warning'>The nullrod's power interferes with your own!  They are on to you!</span>"
						M.mind.vampire.nullified = max(8, M.mind.vampire.nullified + 8)
		//..() Ported from readapted vamp null code.  Original seen down there.  This doesn't need to be here since it's in the loops now.
		else
			user << "\red The rod appears to do nothing."
			for(var/mob/O in viewers(M, null))
				O.show_message(text("\red [] waves [] over []'s head.", user, src, M), 1)
			return
/*	if(M.mind)
		if(M.mind.vampire)
			if(ishuman(M))
				if(!(VAMP_FULL in M.mind.vampire.powers))
					M << "<span class='warning'>The nullrod's power interferes with your own!</span>"
					M.mind.vampire.nullified = max(5, M.mind.vampire.nullified + 2)
	..()
*/
/obj/item/weapon/nullrod/afterattack(atom/A, mob/user as mob)
	if (istype(A, /turf/simulated/floor))
		user << "\blue You hit the floor with the [src]."
		call(/obj/effect/rune/proc/revealrunes)(src)

/obj/item/weapon/sord
	name = "\improper SORD"
	desc = "This thing is so unspeakably shitty you are having a hard time even holding it."
	icon_state = "sord"
	item_state = "sord"
	flags = FPRINT | TABLEPASS
	slot_flags = SLOT_BELT
	force = 2
	throwforce = 1
	sharp = 1
	edge = 1
	w_class = 3
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

	suicide_act(mob/user)
		viewers(user) << "\red <b>[user] is impaling \himself with the [src.name]! It looks like \he's trying to commit suicide.</b>"
		return(BRUTELOSS)

/obj/item/weapon/sord/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	playsound(loc, 'sound/weapons/bladeslice.ogg', 50, 1, -1)
	return ..()

/obj/item/weapon/claymore
	name = "claymore"
	desc = "What are you standing around staring at this for? Get to killing!"
	icon_state = "claymore"
	item_state = "claymore"
	flags = FPRINT | TABLEPASS | CONDUCT
	slot_flags = SLOT_BELT
	force = 40
	throwforce = 10
	sharp = 1
	edge = 1
	w_class = 4
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

	IsShield()
		return 1

	suicide_act(mob/user)
		viewers(user) << "\red <b>[user] is falling on the [src.name]! It looks like \he's trying to commit suicide.</b>"
		return(BRUTELOSS)

/obj/item/weapon/claymore/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	playsound(loc, 'sound/weapons/bladeslice.ogg', 50, 1, -1)
	return ..()

/obj/item/weapon/katana
	name = "katana"
	desc = "Woefully underpowered in D20"
	icon_state = "katana"
	item_state = "katana"
	flags = FPRINT | TABLEPASS | CONDUCT
	slot_flags = SLOT_BELT | SLOT_BACK
	force = 40
	throwforce = 10
	sharp = 1
	edge = 1
	w_class = 4
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

	suicide_act(mob/user)
		viewers(user) << "\red <b>[user] is slitting \his stomach open with the [src.name]! It looks like \he's trying to commit seppuku.</b>"
		return(BRUTELOSS)

/obj/item/weapon/katana/IsShield()
		return 1

/obj/item/weapon/katana/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	playsound(loc, 'sound/weapons/bladeslice.ogg', 50, 1, -1)
	return ..()

/obj/item/weapon/harpoon
	name = "harpoon"
	sharp = 1
	edge = 0
	desc = "Tharr she blows!"
	icon_state = "harpoon"
	item_state = "harpoon"
	force = 20
	throwforce = 15
	w_class = 3
	attack_verb = list("jabbed","stabbed","ripped")

/obj/item/weapon/canesword
	name = "cane sword"
	sharp = 1
	edge = 1
	desc = "A thin, sharp blade with an elegant handle."
	icon_state = "canesword"
	item_state = "canesword"
	force = 20
	throwforce = 10
	w_class = 4 //there ain't no way in fuck you're shuving this inside your rucksack. No way.
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

/obj/item/weapon/metal_bat
	desc = "The quality is a swing and a miss."
	name = "Metal Bat"
	icon_state = "metalbat"
	item_state = "bat_l"
	force = 15.0
	throwforce = 5.0
	throw_speed = 5
	throw_range = 10
	w_class = 4.0
	flags = FPRINT | TABLEPASS
	attack_verb = list("struck out", "beat", "bludgeoned", "homerunned")

/obj/item/weapon/pla_bat
	desc = "The quality is a swing and a miss."
	name = "Plasteel Bat"
	icon_state = "plabat"
	item_state = "bat_l"
	force = 20.0
	throwforce = 5.0
	throw_speed = 5
	throw_range = 10
	w_class = 4.0
	flags = FPRINT | TABLEPASS
	attack_verb = list("struck out", "beat", "bludgeoned", "homerunned")

/obj/item/weapon/wood_bat
	desc = "The quality is a swing and a miss."
	name = "Wooden Bat"
	icon_state = "woodbat"
	item_state = "bat_l"
	force = 10.0
	throwforce = 5.0
	throw_speed = 5
	throw_range = 10
	w_class = 4.0
	flags = FPRINT | TABLEPASS
	attack_verb = list("struck out", "beat", "bludgeoned", "homerunned")