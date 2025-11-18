// Cyborg PKA variants and upgrades
/obj/item/gun/energy/recharge/kinetic_accelerator/cyborg/railgun
	name = /obj/item/gun/energy/recharge/kinetic_accelerator/railgun::name
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/railgun::desc
	icon = /obj/item/gun/energy/recharge/kinetic_accelerator/railgun::icon
	icon_state = /obj/item/gun/energy/recharge/kinetic_accelerator/railgun::icon_state
	base_icon_state = /obj/item/gun/energy/recharge/kinetic_accelerator/railgun::base_icon_state
	inhand_icon_state = /obj/item/gun/energy/recharge/kinetic_accelerator/railgun::inhand_icon_state
	pin = /obj/item/gun/energy/recharge/kinetic_accelerator/railgun::pin
	recharge_time = /obj/item/gun/energy/recharge/kinetic_accelerator/railgun::recharge_time
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/railgun)
	max_mod_capacity = /obj/item/gun/energy/recharge/kinetic_accelerator/railgun::max_mod_capacity

/obj/item/gun/energy/recharge/kinetic_accelerator/cyborg/shotgun
	name = /obj/item/gun/energy/recharge/kinetic_accelerator/shotgun::name
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/shotgun::desc
	icon = /obj/item/gun/energy/recharge/kinetic_accelerator/shotgun::icon
	icon_state = /obj/item/gun/energy/recharge/kinetic_accelerator/shotgun::icon_state
	base_icon_state = /obj/item/gun/energy/recharge/kinetic_accelerator/shotgun::base_icon_state
	inhand_icon_state = /obj/item/gun/energy/recharge/kinetic_accelerator/shotgun::inhand_icon_state
	recharge_time = /obj/item/gun/energy/recharge/kinetic_accelerator/shotgun::recharge_time
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/shotgun)
	max_mod_capacity = /obj/item/gun/energy/recharge/kinetic_accelerator/shotgun::max_mod_capacity

/obj/item/gun/energy/recharge/kinetic_accelerator/cyborg/shockwave
	name = /obj/item/gun/energy/recharge/kinetic_accelerator/shockwave::name
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/shockwave::desc
	icon = /obj/item/gun/energy/recharge/kinetic_accelerator/shockwave::icon
	icon_state = /obj/item/gun/energy/recharge/kinetic_accelerator/shockwave::icon_state
	base_icon_state = /obj/item/gun/energy/recharge/kinetic_accelerator/shockwave::base_icon_state
	inhand_icon_state = /obj/item/gun/energy/recharge/kinetic_accelerator/shockwave::inhand_icon_state
	recharge_time = /obj/item/gun/energy/recharge/kinetic_accelerator/shockwave::recharge_time
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/shockwave)
	max_mod_capacity = /obj/item/gun/energy/recharge/kinetic_accelerator/shockwave::max_mod_capacity

/obj/item/gun/energy/recharge/kinetic_accelerator/cyborg/repeater
	name = /obj/item/gun/energy/recharge/kinetic_accelerator/repeater::name
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/repeater::desc
	icon = /obj/item/gun/energy/recharge/kinetic_accelerator/repeater::icon
	icon_state = /obj/item/gun/energy/recharge/kinetic_accelerator/repeater::icon_state
	base_icon_state = /obj/item/gun/energy/recharge/kinetic_accelerator/repeater::base_icon_state
	inhand_icon_state = /obj/item/gun/energy/recharge/kinetic_accelerator/repeater::inhand_icon_state
	recharge_time = /obj/item/gun/energy/recharge/kinetic_accelerator/repeater::recharge_time
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/repeater)
	max_mod_capacity = /obj/item/gun/energy/recharge/kinetic_accelerator/repeater::max_mod_capacity

/obj/item/gun/energy/recharge/kinetic_accelerator/cyborg/glock
	name = /obj/item/gun/energy/recharge/kinetic_accelerator/glock::name
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/glock::desc
	icon = /obj/item/gun/energy/recharge/kinetic_accelerator/glock::icon
	icon_state = /obj/item/gun/energy/recharge/kinetic_accelerator/glock::icon_state
	base_icon_state = /obj/item/gun/energy/recharge/kinetic_accelerator/glock::base_icon_state
	inhand_icon_state = /obj/item/gun/energy/recharge/kinetic_accelerator/glock::inhand_icon_state
	recharge_time = /obj/item/gun/energy/recharge/kinetic_accelerator/glock::recharge_time
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/glock)
	max_mod_capacity = /obj/item/gun/energy/recharge/kinetic_accelerator/glock::max_mod_capacity

/obj/item/gun/energy/recharge/kinetic_accelerator/cyborg/m79
	name = /obj/item/gun/energy/recharge/kinetic_accelerator/m79::name
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/m79::desc
	icon = /obj/item/gun/energy/recharge/kinetic_accelerator/m79::icon
	icon_state = /obj/item/gun/energy/recharge/kinetic_accelerator/m79::icon_state
	base_icon_state = /obj/item/gun/energy/recharge/kinetic_accelerator/m79::base_icon_state
	inhand_icon_state = /obj/item/gun/energy/recharge/kinetic_accelerator/m79::inhand_icon_state
	pin = /obj/item/gun/energy/recharge/kinetic_accelerator/m79::pin
	recharge_time = /obj/item/gun/energy/recharge/kinetic_accelerator/m79::recharge_time
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/m79)
	max_mod_capacity = /obj/item/gun/energy/recharge/kinetic_accelerator/m79::max_mod_capacity
	disablemodification = /obj/item/gun/energy/recharge/kinetic_accelerator/m79::disablemodification

/obj/item/gun/energy/recharge/kinetic_accelerator/cyborg/m79/add_bayonet_point()
	return

// MINING BORG UPGRADES

// Base helper: installs a specific KA type, ensuring we only ever have one KA at a time.
/obj/item/borg/upgrade/pka_variant
	name = "mining cyborg PKA variant"
	desc = "Reconfigures the mounted PKA into a specialized variant. Only one can be active."
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	allow_duplicates = FALSE
	/// Override in children to provide the KA type to install
	var/ka_type_to_install = /obj/item/gun/energy/recharge/kinetic_accelerator/cyborg

/obj/item/borg/upgrade/pka_variant/proc/install_variant(mob/living/silicon/robot/R, mob/living/user)
	// Remove any existing cyborg KA (base or other variants), carry over modkits if possible
	var/list/obj/item/borg/upgrade/modkit/kept_modkits = list()
	for(var/obj/item/gun/energy/recharge/kinetic_accelerator/cyborg/old_ka in R.model.modules)
		if(old_ka.modkits && length(old_ka.modkits))
			for(var/obj/item/borg/upgrade/modkit/MK in old_ka.modkits)
				// Detach modkit from old KA first so it won't be deleted with it
				MK.uninstall(old_ka)
				MK.forceMove(get_turf(R))
				kept_modkits += MK
		R.model.remove_module(old_ka)

	var/obj/item/gun/energy/recharge/kinetic_accelerator/cyborg/new_ka = new ka_type_to_install(R.model)

	// Try to reinstall modkits within capacity; drop excess to ground
	for(var/obj/item/borg/upgrade/modkit/MK in kept_modkits)
		if(MK.install(new_ka, user, FALSE))
			MK.forceMove(new_ka)
		else
			MK.forceMove(get_turf(R))

	R.model.basic_modules += new_ka
	R.model.add_module(new_ka, FALSE, TRUE)
	to_chat(R, span_notice("PKA reconfigured: [new_ka.name]."))
	return TRUE

/obj/item/borg/upgrade/pka_variant/action(mob/living/silicon/robot/R, user = usr)
	// Prevent stacking multiple PKA variant boards: only one may be installed at a time
	if(locate(/obj/item/borg/upgrade/pka_variant) in R.upgrades)
		to_chat(R, span_alert("Upgrade mounting error! PKA hardpoint already occupied!"))
		to_chat(user, span_warning("Remove the installed PKA variant first!"))
		return FALSE
	. = ..()
	if(!.)
		return .
	return install_variant(R, user)

// If deactivated, revert to the standard cyborg PKA
/obj/item/borg/upgrade/pka_variant/deactivate(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if(!.)
		return .
	// Remove our variant if present
	var/removed_any = FALSE
	for(var/obj/item/gun/energy/recharge/kinetic_accelerator/cyborg/ka in R.model.modules)
		R.model.remove_module(ka)
		removed_any = TRUE
	if(removed_any)
		var/obj/item/gun/energy/recharge/kinetic_accelerator/cyborg/base = new /obj/item/gun/energy/recharge/kinetic_accelerator/cyborg(R.model)
		R.model.basic_modules += base
		R.model.add_module(base, FALSE, TRUE)
		to_chat(R, span_notice("PKA restored to standard configuration."))
	return TRUE

// Specific variant upgrades

/obj/item/borg/upgrade/pka_variant/railgun
	name = "mining cyborg PKA: railgun"
	desc = "Replaces the mounted PKA with a railgun configuration (wastes-only)."
	ka_type_to_install = /obj/item/gun/energy/recharge/kinetic_accelerator/cyborg/railgun

/obj/item/borg/upgrade/pka_variant/shotgun
	name = "mining cyborg PKA: shotgun"
	desc = "Replaces the mounted PKA with a triple-shot spread configuration."
	ka_type_to_install = /obj/item/gun/energy/recharge/kinetic_accelerator/cyborg/shotgun

/obj/item/borg/upgrade/pka_variant/shockwave
	name = "mining cyborg PKA: shockwave"
	desc = "Replaces the mounted PKA with a close-range shockwave configuration."
	ka_type_to_install = /obj/item/gun/energy/recharge/kinetic_accelerator/cyborg/shockwave

/obj/item/borg/upgrade/pka_variant/repeater
	name = "mining cyborg PKA: repeater"
	desc = "Replaces the mounted PKA with a repeater (rapid, lower power)."
	ka_type_to_install = /obj/item/gun/energy/recharge/kinetic_accelerator/cyborg/repeater

/obj/item/borg/upgrade/pka_variant/pistol
	name = "mining cyborg PKA: pistol"
	desc = "Replaces the mounted PKA with a pistol configuration (high mod capacity)."
	ka_type_to_install = /obj/item/gun/energy/recharge/kinetic_accelerator/cyborg/glock

/obj/item/borg/upgrade/pka_variant/grenade
	name = "mining cyborg PKA: grenade launcher"
	desc = "Replaces the mounted PKA with a grenade launcher configuration (wastes-only)."
	ka_type_to_install = /obj/item/gun/energy/recharge/kinetic_accelerator/cyborg/m79
