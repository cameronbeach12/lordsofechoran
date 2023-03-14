class_name critical_prowess extends perk

func _init():
	p_name = "Critical Prowess"
	p_description = "Increase base critical strike chance of spells by 5-20% based on character level. This perk can stack. \nArmor and Weapon Exclusive."
	has_condition = false
	damage_modifier = 1.0
	damage_mod_increase_per_level = 0.0
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
	critical_modifier = 0.05
	critical_mod_increase_per_level = 0.0025
	spell_speed_modifier = 1.0
	spell_speed_increase_per_level = 0.00
