/datum/round_event_control/radiation_storm
	name = "Radiation Storm"
	typepath = /datum/round_event/radiation_storm
	max_occurrences = 1
	category = EVENT_CATEGORY_SPACE
	//VENUS EDIT START: (Changed description to reflect that dorms and maintenance are best shielded from radiation)
	// description = "Radiation storm affects the station, forcing the crew to escape to maintenance."
	description = "Radiation storm affects the station, forcing the crew to escape to maintenance and dorms."
	//VENUS EDIT END
	min_wizard_trigger_potency = 3
	max_wizard_trigger_potency = 7

/datum/round_event/radiation_storm


/datum/round_event/radiation_storm/setup()
	start_when = 3
	end_when = start_when + 1
	announce_when = 1

/datum/round_event/radiation_storm/announce(fake)
	//VENUS EDIT START: (Changed priority announce to reflect that dorms and maintenance are best shielded from radiation)
	// priority_announce("High levels of radiation detected near the station. Maintenance is best shielded from radiation.", "Anomaly Alert", ANNOUNCER_RADIATION)
	priority_announce("High levels of radiation detected near the station. Maintenance and Dorms are best shielded from radiation.", "Anomaly Alert", ANNOUNCER_RADIATION)
	//VENUS EDIT END
	//sound not longer matches the text, but an audible warning is probably good

/datum/round_event/radiation_storm/start()
	SSweather.run_weather(/datum/weather/rad_storm)
