class_name precise_spells extends perk

func _init():
	p_name = "Precise Spells"
	p_description = "Increase base critical damage of spells by 5-15% based on character level. This perk can stack. \nArmor Exclusive."
	has_condition = false
	damage_modifier = 1.0
	damage_mod_increase_per_level = 0.0
	critical_dam_modifier = 0.05
	critical_dam_mod_increase_per_level = 0.00166
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
	spell_speed_modifier = 1.0
	spell_speed_increase_per_level = 0.0
