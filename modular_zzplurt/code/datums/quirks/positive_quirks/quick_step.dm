/datum/quirk/quick_step
	name = "Quick Step"
	desc = "You walk with determined strides, and out-pace most people when walking."
	value = 2
	mob_trait = TRAIT_SPEEDY_STEP
	gain_text = span_notice("You feel determined. No time to lose.")
	lose_text = span_danger("You feel less determined. What's the rush, man?")
	medical_record_text = "Patient scored highly on racewalking tests."
	icon = FA_ICON_PERSON_RUNNING // ANOTHER FITTING QUIRK ICON???? WOW!!!!!!!!!!!!!!!!

/datum/movespeed_modifier/quick_step
	multiplicative_slowdown = -0.5

/datum/quirk/quick_step/add(client/client_source)
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	RegisterSignal(H, COMSIG_MOVE_INTENT_TOGGLED, PROC_REF(on_move_intent_change))
	// Initial check in case they start walking
	if(H.move_intent == MOVE_INTENT_WALK)
		H.add_movespeed_modifier(/datum/movespeed_modifier/quick_step)

/datum/quirk/quick_step/proc/on_move_intent_change(mob/living/source)
	SIGNAL_HANDLER
	if(source.move_intent == MOVE_INTENT_WALK)
		source.add_movespeed_modifier(/datum/movespeed_modifier/quick_step)
	else
		source.remove_movespeed_modifier(/datum/movespeed_modifier/quick_step)

/datum/quirk/quick_step/remove()
	UnregisterSignal(quirk_holder, COMSIG_MOVE_INTENT_TOGGLED)
	quirk_holder.remove_movespeed_modifier(/datum/movespeed_modifier/quick_step)
	return ..()
