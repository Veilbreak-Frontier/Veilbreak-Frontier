/datum/round_event_control/portal_storm_monkey
	name = "Random Chimp Event"
	typepath = /datum/round_event/portal_storm/portal_storm_monkey
	weight = 15
	max_occurrences = 2
	earliest_start = 20 MINUTES
	category = EVENT_CATEGORY_ENTITIES
	track = EVENT_TRACK_MAJOR
	description = "Angry monkies pour out of portals."

/datum/round_event/portal_storm/portal_storm_monkey
	boss_types = list(/mob/living/basic/gorilla/lesser = 1)
	hostile_types = list(
		/mob/living/carbon/human/species/monkey/angry = 10,
	)

/datum/round_event/portal_storm/portal_storm_monkey/announce(fake)
	priority_announce("Random Chimp Event detected en route to [station_name()]. Brace for mad apes.")
