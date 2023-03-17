class_name high_level_chest extends "res://Scripts/Armor/Armor.gd"

func _init():
	level = 1 #max level = 60
	armor_id = 5
	armor_name = "High-Level Chestplate"
	armor_type = TYPE.CHEST
	main_stat_base = 75
	con_stat_base = 80
	
	armor_calc()
		
	perks = critical_prowess.new()
