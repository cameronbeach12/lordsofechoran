class_name beginners_legs extends "res://Scripts/Armor/Armor.gd"

func _init():
	level = 1 #max level = 60
	armor_id = 3
	armor_name = "Beginner's Legguards"
	armor_type = TYPE.LEGS
	main_stat_base = 50
	con_stat_base = 50
	
	armor_calc()
		
	perks = precise_spells.new()
