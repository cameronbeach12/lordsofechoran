class_name beginners_chest extends "res://Scripts/Armor/Armor.gd"

func _init():
	level = 1 #max level = 60
	armor_id = 2
	armor_name = "Beginner's Chestplate"
	armor_type = TYPE.CHEST
	main_stat_base = 50
	con_stat_base = 50
	
	armor_calc()
		
	perks = critical_prowess.new()
