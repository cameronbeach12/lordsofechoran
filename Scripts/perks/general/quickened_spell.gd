class_name quickened_spell extends perk

func _init():
	p_name = "Quickened Spell"
	p_description = "Increase the cast speed of your spells by 10-46% based on character level\
	and the damage of your spells by 3-18% based on character level for 5 seconds. 10 second cooldown. This perk cannot stack. \nWeapon Exclusive."
	has_condition = false
	damage_modifier = 1.03
	damage_mod_increase_per_level = 0.0025
	critical_dam_modifier = 1.0
	critical_dam_mod_increase_per_level = 0.0
	cdr_modifier = 1.0
	cdr_mod_increase_per_level = 0.0
	main_stat_modifier = 1.0
	main_stat_mod_increase_per_level = 0.0
	healing_modifier = 1.0 
	healing_mod_increase_per_level = 0.0 
	shielding_modifier = 1.0 
	shielding_mod_increase_per_level = 0.0 
	critical_modifier = 0.00
	critical_mod_increase_per_level = 0.0
	spell_speed_modifier = 0.10
	spell_speed_increase_per_level = 0.00666
