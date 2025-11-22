// modular_zzveilbreak/code/modules/mobs/void_mobs.dm

// Define constants first
#define BB_VOID_SUMMON_COOLDOWN "void_summon_cooldown"
#define BB_VOID_HEAL_COOLDOWN "void_heal_cooldown"
#define BB_VOID_TAUNT_COOLDOWN "void_taunt_cooldown"

// Base void mob type with proper AI integration
/mob/living/basic/void_creature
	name = "Void Creature"
	desc = "A creature from the void."
	faction = list("void")
	gender = NEUTER
	speak_emote = list("hums")
	response_help_continuous = "touches"
	response_help_simple = "touch"
	response_disarm_continuous = "pushes"
	response_disarm_simple = "push"
	response_harm_continuous = "hits"
	response_harm_simple = "hit"
	maxHealth = 50
	health = 50
	melee_damage_lower = 10
	melee_damage_upper = 15
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'modular_zzveilbreak/sound/weapons/voidling_attack.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	unsuitable_atmos_damage = 0
	unsuitable_cold_damage = 0
	unsuitable_heat_damage = 0
	status_flags = CANPUSH
	obj_damage = 30
	movement_type = GROUND
	basic_mob_flags = DEL_ON_DEATH
	ai_controller = /datum/ai_controller/basic_controller/void

/mob/living/basic/void_creature/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/simple_flying)

	// Ensure proper hostility
	faction |= FACTION_HOSTILE

/mob/living/basic/void_creature/death(gibbed)
	// Drop loot before dusting
	if(!gibbed)
		drop_loot()

	. = ..()
	// Dust immediately after parent death proc
	visible_message(span_danger("[src] collapses into void dust!"))
	dust(just_ash = FALSE, drop_items = FALSE)
	return TRUE

/mob/living/basic/void_creature/proc/drop_loot()
	// Override in child types
	return

// Voidling - Aggressive melee attacker
/mob/living/basic/void_creature/voidling
	name = "Voidling"
	desc = "You struggle to comprehend the details of this creature, it keeps shifting and changing constantly."
	icon = 'modular_zzveilbreak/icons/mob/mobs.dmi'
	icon_state = "voidling"
	icon_living = "voidling"
	icon_dead = "voidling_dead"
	maxHealth = 30
	health = 30
	melee_damage_lower = 8
	melee_damage_upper = 12
	speed = 0.8 // Faster than base
	ai_controller = /datum/ai_controller/basic_controller/void/voidling

/mob/living/basic/void_creature/voidling/Move()
	. = ..()
	if(.)
		flick("voidling_2", src)

/mob/living/basic/void_creature/voidling/drop_loot()
	if(prob(60)) // 60% chance to drop loot
		var/loot_type = pick_loot_from_table(voidling_loot_table)
		if(loot_type)
			new loot_type(loc)
			visible_message(span_notice("Something drops from the void dust!"))

// Consumed Pathfinder - Vicious ranged attacker with strategic summoning
/mob/living/basic/void_creature/consumed_pathfinder
	name = "Consumed Pathfinder"
	desc = "A pathfinder just like you, consumed by the void. It moves with unnatural purpose."
	icon = 'modular_zzveilbreak/icons/mob/mobs.dmi'
	icon_state = "consumed"
	icon_living = "consumed"
	maxHealth = 80
	health = 80
	melee_damage_lower = 5
	melee_damage_upper = 8
	speed = 1
	ai_controller = /datum/ai_controller/basic_controller/void_pathfinder
	var/timer_id

/mob/living/basic/void_creature/consumed_pathfinder/Initialize(mapload)
	. = ..()
	// Start automatic firing timer
	timer_id = addtimer(CALLBACK(src, PROC_REF(fire_bolt)), 3 SECONDS, TIMER_LOOP | TIMER_STOPPABLE)

/mob/living/basic/void_creature/consumed_pathfinder/Destroy()
	if(timer_id)
		deltimer(timer_id)
		timer_id = null
	return ..()

/mob/living/basic/void_creature/consumed_pathfinder/proc/fire_bolt()
	if(QDELETED(src) || stat == DEAD)
		return
	var/list/targets = list()
	for(var/mob/living/L in view(7, src))
		if(!compare_factions(src, L) && !L.stat)
			targets += L
	if(!length(targets))
		return
	var/mob/living/target = pick(targets)

	// Direct projectile firing without preparePixelProjectile
	var/obj/projectile/magic/voidbolt/bolt = new(get_turf(src))
	bolt.original = target
	bolt.firer = src
	bolt.yo = target.y - y
	bolt.xo = target.x - x
	bolt.fire()

/mob/living/basic/void_creature/consumed_pathfinder/drop_loot()
	var/loot_type = pick_loot_from_table(consumed_pathfinder_drops)
	if(loot_type)
		new loot_type(loc)
		visible_message(span_notice("Something drops from the void dust!"))

// Voidbug - Defensive tank that protects allies
/mob/living/basic/void_creature/voidbug
	name = "Voidbug"
	desc = "A resilient bug-like creature from the void, its chitinous plates deflect attacks with ease."
	icon = 'modular_zzveilbreak/icons/mob/mobs.dmi'
	icon_state = "void_bug"
	icon_living = "void_bug"
	icon_dead = "void_bug_dead"
	maxHealth = 200 // Much tankier
	health = 200
	melee_damage_lower = 2
	melee_damage_upper = 5
	speed = 1.3 // Slower but tougher
	attack_verb_continuous = "crushes"
	attack_verb_simple = "crush"
	ai_controller = /datum/ai_controller/basic_controller/void/voidbug
	var/block_chance = 40 // Higher block chance

/mob/living/basic/void_creature/voidbug/bullet_act(obj/projectile/P, def_zone, piercing_hit)
	if(prob(block_chance) && !piercing_hit)
		visible_message(span_warning("[src]'s chitin deflects the projectile!"))
		playsound(src, 'sound/effects/magic/cosmic_energy.ogg', 50, TRUE)
		return BULLET_ACT_BLOCK
	return ..()

/mob/living/basic/void_creature/voidbug/drop_loot()
	if(prob(70)) // 70% chance to drop loot
		var/loot_type = pick_loot_from_table(voidbug_loot_table)
		if(loot_type)
			new loot_type(loc)
			visible_message(span_notice("Something drops from the void dust!"))

// Void Healer - Support mob that prioritizes healing
/mob/living/basic/void_creature/void_healer
	name = "Void Healer"
	desc = "A benevolent void entity that mends its allies. It seems to pulse with restorative energy."
	icon = 'modular_zzveilbreak/icons/mob/mobs.dmi'
	icon_state = "void_healer"
	icon_living = "void_healer"
	icon_dead = "void_healer_dead"
	maxHealth = 40
	health = 40
	melee_damage_lower = 0
	melee_damage_upper = 0
	speed = 0.7 // Fast to escape
	attack_verb_continuous = "touches"
	attack_verb_simple = "touch"
	environment_smash = ENVIRONMENT_SMASH_NONE
	ai_controller = /datum/ai_controller/basic_controller/void_healer

/mob/living/basic/void_creature/void_healer/drop_loot()
	if(prob(50)) // 50% chance to drop loot
		var/loot_type = pick_loot_from_table(void_healer_table)
		if(loot_type)
			new loot_type(loc)
			visible_message(span_notice("Something drops from the void dust!"))

// Enhanced Projectile for Consumed Pathfinder
/obj/projectile/magic/voidbolt
	name = "void bolt"
	icon = 'modular_zzveilbreak/icons/item_icons/voidring.dmi'
	icon_state = "voidbolt"
	damage = 5
	damage_type = BURN
	range = 14
	speed = 0.3
	hitsound = 'sound/effects/magic/magic_missile.ogg'
	hitsound_wall = 'sound/effects/magic/magic_missile.ogg'

/obj/projectile/magic/voidbolt/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(isliving(target) && blocked < 100)
		var/mob/living/L = target
		L.apply_damage(damage, damage_type, blocked = blocked, attacking_item = src)
		if(iscarbon(L))
			var/mob/living/carbon/C = L
			C.adjust_stutter(4 SECONDS)
	return .

// AI CONTROLLERS AND BEHAVIORS

// Base void AI - much more aggressive
/datum/ai_controller/basic_controller/void
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic/void_aggressive,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/target_retaliate,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)

// Extremely aggressive targeting for void creatures
/datum/targeting_strategy/basic/void_aggressive
/datum/targeting_strategy/basic/void_aggressive/can_attack(mob/living/owner, atom/target, vision_range)
	if(!ismob(target))
		return FALSE

	var/mob/target_mob = target
	if(target_mob.stat == DEAD || isobserver(target_mob))
		return FALSE

	// Attack anything that's not our faction
	if(!compare_factions(owner, target_mob))
		return TRUE

	return FALSE

// Voidling specific AI - hyper aggressive
/datum/ai_controller/basic_controller/void/voidling
	planning_subtrees = list(
		/datum/ai_planning_subtree/target_retaliate,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)

// Voidbug specific AI - protective tank
/datum/ai_controller/basic_controller/void/voidbug
	planning_subtrees = list(
		/datum/ai_planning_subtree/target_retaliate,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)

// Consumed Pathfinder AI - Strategic kiter and summoner
/datum/ai_controller/basic_controller/void_pathfinder
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic/void_aggressive,
		BB_VOID_SUMMON_COOLDOWN = 0,
		BB_RANGED_SKIRMISH_MIN_DISTANCE = 4, // Keep at least 4 tiles away
		BB_RANGED_SKIRMISH_MAX_DISTANCE = 6, // But no more than 6 tiles
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/target_retaliate,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/flee_target, // Let the default flee logic run
		/datum/ai_planning_subtree/maintain_distance_from_target, // Our custom kiting logic
		/datum/ai_planning_subtree/void_pathfinder_summon,
		/datum/ai_planning_subtree/basic_ranged_attack_subtree, // Attack when in range
	)

// Pathfinder Summoning Subtree
/datum/ai_planning_subtree/void_pathfinder_summon
/datum/ai_planning_subtree/void_pathfinder_summon/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/basic/void_creature/consumed_pathfinder/pathfinder = controller.pawn
	if(!istype(pathfinder))
		return

	var/mob/living/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!target)
		return

	// Cooldown check
	if(world.time <= controller.blackboard[BB_VOID_SUMMON_COOLDOWN])
		return

	// Only summon if there are not too many other voidlings around
	var/allies = 0
	for(var/mob/living/basic/void_creature/voidling/V in view(7, pathfinder))
		allies++
	if(allies >= 3)
		return

	// Check if we are a safe distance away to summon
	var/dist = get_dist(pathfinder, target)
	if(dist < 4)
		return // Too close, prioritize moving away

	controller.queue_behavior(/datum/ai_behavior/void_summon, BB_BASIC_MOB_CURRENT_TARGET)
	return SUBTREE_RETURN_FINISH_PLANNING

// Pathfinder Summon Behavior
/datum/ai_behavior/void_summon
	action_cooldown = 25 SECONDS // Longer cooldown
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT

/datum/ai_behavior/void_summon/perform(seconds_per_tick, datum/ai_controller/controller, target_key)
	var/mob/living/basic/void_creature/consumed_pathfinder/pathfinder = controller.pawn
	if(!istype(pathfinder))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	pathfinder.visible_message(span_warning("[pathfinder] begins to channel the void..."))
	if(!do_after(pathfinder, 30, target = controller.blackboard[target_key])) // 3 second cast time
		pathfinder.visible_message(span_warning("[pathfinder]'s summoning was interrupted!"))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	// Summon 1-2 voidlings
	var/summon_count = rand(1, 2)
	for(var/i in 1 to summon_count)
		var/mob/living/basic/void_creature/voidling/new_voidling = new(pathfinder.loc)
		new_voidling.faction = pathfinder.faction.Copy()

		// Make summoned voidling aggressive toward our target
		var/mob/living/target = controller.blackboard[target_key]
		if(target && new_voidling.ai_controller)
			new_voidling.ai_controller.set_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET, target)

	// Set cooldown
	controller.set_blackboard_key(BB_VOID_SUMMON_COOLDOWN, world.time + action_cooldown)

	// Visual and sound feedback
	playsound(pathfinder, 'sound/effects/magic/summon_magic.ogg', 50, TRUE)
	pathfinder.visible_message(span_danger("[pathfinder] summons voidlings from a tear in reality!"))

	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED

// Void Healer AI - Smart support, prioritizes healing
/datum/ai_controller/basic_controller/void_healer
	blackboard = list(
		BB_VOID_HEAL_COOLDOWN = 0,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/void_healer_find_and_heal, // New primary logic
		/datum/ai_planning_subtree/target_retaliate, // Flee if attacked
		/datum/ai_planning_subtree/simple_find_target, // Find enemy to flee from
		/datum/ai_planning_subtree/flee_target, // Flee
	)

// New healing subtree that finds a target and moves to it
/datum/ai_planning_subtree/void_healer_find_and_heal
/datum/ai_planning_subtree/void_healer_find_and_heal/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/basic/void_creature/void_healer/healer = controller.pawn
	if(!istype(healer))
		return

	// Cooldown check
	if(world.time <= controller.blackboard[BB_VOID_HEAL_COOLDOWN])
		return

	// Find the most injured ally in a larger radius
	var/mob/living/most_injured_ally = null
	var/lowest_health_percent = 1
	for(var/mob/living/ally in view(10, healer)) // Increased view range
		if(ally.faction == healer.faction && ally.health > 0 && ally != healer)
			var/health_percent = ally.health / ally.maxHealth
			if(health_percent < lowest_health_percent)
				lowest_health_percent = health_percent
				most_injured_ally = ally

	if(most_injured_ally)
		// We found someone to heal.
		controller.set_blackboard_key("heal_target", most_injured_ally)
		controller.queue_behavior(/datum/ai_behavior/move_to_and_perform, "heal_target", /datum/ai_behavior/void_heal, 3) // Move within 3 tiles to heal
		return SUBTREE_RETURN_FINISH_PLANNING

// New heal behavior, simpler and more direct
/datum/ai_behavior/void_heal
	action_cooldown = 5 SECONDS // Slightly faster cooldown

/datum/ai_behavior/void_heal/perform(seconds_per_tick, datum/ai_controller/controller, target_key)
	var/mob/living/basic/void_creature/void_healer/healer = controller.pawn
	var/mob/living/target_to_heal = controller.blackboard[target_key]

	if(!istype(healer) || !istype(target_to_heal) || target_to_heal.stat == DEAD)
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	// Check if target still needs healing
	if(target_to_heal.health >= target_to_heal.maxHealth)
		healer.visible_message(span_notice("[healer] pauses its healing as [target_to_heal] is fully recovered."))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED

	// Heal the ally
	var/heal_amount = 40 // Stronger heal
	target_to_heal.adjustBruteLoss(-heal_amount)
	target_to_heal.adjustFireLoss(-heal_amount)

	// Visual and sound feedback
	playsound(healer, 'sound/effects/magic/staff_healing.ogg', 50, TRUE)
	new /obj/effect/temp_visual/heal(target_to_heal.loc, "#8A2BE2") // Purple heal effect

	healer.visible_message(span_green("[healer] pulses with violet energy, mending [target_to_heal]'s wounds!"))

	controller.set_blackboard_key(BB_VOID_HEAL_COOLDOWN, world.time + action_cooldown)
	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED

// CORRECTED AI BEHAVIORS AND SUBTREES

// BEHAVIOR for moving towards a target
/datum/ai_behavior/move_towards_target
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT

/datum/ai_behavior/move_towards_target/perform(seconds_per_tick, datum/ai_controller/controller, target_key)
	var/atom/movable/target = controller.blackboard[target_key]
	if(!target)
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	var/mob/living/owner = controller.pawn
	// Stop if we are next to the target
	if(get_dist(owner, target) <= 1)
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED

	controller.ai_movement.start_moving_towards(controller, target, 1)
	return

// SUBTREE for kiting/maintaining distance
/datum/ai_planning_subtree/maintain_distance_from_target
/datum/ai_planning_subtree/maintain_distance_from_target/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!target)
		controller.clear_blackboard_key(BB_BASIC_MOB_FLEE_TARGET)
		return

	var/mob/living/owner = controller.pawn
	var/dist = get_dist(owner, target)

	var/min_dist = controller.blackboard[BB_RANGED_SKIRMISH_MIN_DISTANCE] || 4
	var/max_dist = controller.blackboard[BB_RANGED_SKIRMISH_MAX_DISTANCE] || 6

	// Too close, tell the flee subtree to run
	if(dist < min_dist)
		controller.set_blackboard_key(BB_BASIC_MOB_FLEE_TARGET, target)
		return

	// No longer too close, tell the flee subtree to stop
	controller.clear_blackboard_key(BB_BASIC_MOB_FLEE_TARGET)

	// Too far, move closer
	if(dist > max_dist)
		controller.queue_behavior(/datum/ai_behavior/move_towards_target, BB_BASIC_MOB_CURRENT_TARGET)
		return SUBTREE_RETURN_FINISH_PLANNING

	// Just right, do nothing and let the next subtrees handle attacking or summoning
	return

// BEHAVIOR for moving to a target and then performing another action
/datum/ai_behavior/move_to_and_perform
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT
	var/target_key
	var/action_behavior_type
	var/prox_distance = 1

/datum/ai_behavior/move_to_and_perform/New(datum/ai_controller/controller, t_key, action_type, prox)
	src.target_key = t_key
	src.action_behavior_type = action_type
	if(prox > 1)
		src.prox_distance = prox

/datum/ai_behavior/move_to_and_perform/perform(seconds_per_tick, datum/ai_controller/controller)
	var/atom/movable/target = controller.blackboard[target_key]
	if(!target || QDELETED(target))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	var/mob/living/owner = controller.pawn
	var/dist = get_dist(owner, target)

	if(dist > prox_distance)
		controller.ai_movement.start_moving_towards(controller, target, prox_distance)
		return
	else
		// In range, perform the action
		var/datum/ai_behavior/action = new action_behavior_type()
		// We pass the original target key to the action behavior
		return action.perform(seconds_per_tick, controller, target_key)

// Visual effect for healing
/obj/effect/temp_visual/heal
	icon = 'icons/effects/effects.dmi'
	icon_state = "heal"
	duration = 1 SECONDS

/obj/effect/temp_visual/heal/Initialize(mapload, color)
	. = ..()
	if(color)
		add_atom_colour(color, FIXED_COLOUR_PRIORITY)

// Helper proc for faction checking
/proc/compare_factions(mob/living/owner, mob/target)
	if(!owner.faction || !target.faction)
		return FALSE

	// Check if they share any factions (shouldn't attack if they do)
	for(var/faction in owner.faction)
		if(faction in target.faction)
			return TRUE
	return FALSE
