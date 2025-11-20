//This file is for nanite program designs that are unique to veilbreak

/datum/nanite_program/protocol/quantum
	name = "Quantum Replication"
	desc = "Borrows replication power from other realities to replicate faster, grants a net of 3.5 nanites per second. Only works in void."
	use_rate = 0.2
	var/boost = 3.7

/datum/nanite_program/protocol/quantum/on_process(datum/nanite_holder/holder)
	if(istype(get_turf(holder.host), /turf/open/floor/void_tile))
		nanites.adjust_nanites(null, boost)

/datum/nanite_program/regenerative/e_regen
	name = "Efficient Regeneration"
	desc = "Provides slow but highly efficient healing."
	use_rate = 0.3
	healing_rate = 1

/datum/nanite_program/regenerative/f_regen
	name = "Fast Regeneration"
	desc = "Provides rapid healing at a high energy cost."
	use_rate = 8
	healing_rate = 10

/datum/design/nanites/quantum
	name = "Quantum Replication"
	desc = "Borrows replication power from other realities to replicate faster, grants a net of 3.5 nanites per second. Only works in void."
	use_rate = 0.2
	id = "nanite_quantum"
	program_type = /datum/nanite_program/protocol/quantum
	category = list(NANITE_CATEGORY_PROTOCOLS)
	department_tech = list(TECHWEB_NANITE_PROTOCOLS)

/datum/design/nanites/e_regen
	name = "Efficient Regeneration"
	desc = "A nanite program that provides slow but highly efficient healing."
	id = "e_regen"
	program_type = /datum/nanite_program/regenerative/e_regen
	category = list(NANITE_CATEGORY_MEDICAL)
	department_tech = list(TECHWEB_NANITE_HARMONIC)

/datum/design/nanites/f_regen
	name = "Fast Regeneration"
	desc = "A nanite program that provides rapid healing at a high energy cost."
	id = "f_regen"
	program_type = /datum/nanite_program/regenerative/f_regen
	category = list(NANITE_CATEGORY_MEDICAL)
	department_tech = list(TECHWEB_NANITE_HARMONIC)
