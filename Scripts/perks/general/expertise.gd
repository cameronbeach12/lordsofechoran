class_name expertise extends perk

func _init():
	p_name = "Expertise"
	p_description = "Increase main stat by 5-25% based on character level, This perk can stack. \
	\nAccessory Exclusive."
	has_condition = false
	damage_modifier = 1.0
	damage_mod_increase_per_level = 0.0
	critical_dam_modifier = 1.0
	critical_dam_mod_increase_per_level = 0.0
	cdr_modifier = 1.0
	cdr_mod_increase_per_level = 0.0
	main_stat_modifier = 0.05
	main_stat_mod_increase_per_level = 0.00333
	healing_modifier = 1.0 
	healing_mod_increase_per_level = 0.0 
	shielding_modifier = 1.0 
	shielding_mod_increase_per_level = 0.0 
	critical_modifier = 0.05
	critical_mod_increase_per_level = 0.0025
	spell_speed_modifier = 1.0
	spell_speed_increase_per_level = 0.00
