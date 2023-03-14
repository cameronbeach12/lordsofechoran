class_name beginners_feet extends "res://Scripts/Armor/Armor.gd"

func _init():
	level = 1 #max level = 60
	armor_id = 4
	armor_name = "Beginner's Boots"
	armor_type = TYPE.FEET
	
	armor_calc()
		
	perks = critical_prowess.new()
