class_name beginners_helm extends "res://Scripts/Armor/Armor.gd"

func _init():
	level = 1 #max level = 60
	armor_id = 1
	armor_name = "Beginner's Helmet"
	armor_type = TYPE.HELM
	main_stat_base = 50
	con_stat_base = 50
	
	armor_calc()	
		
	perks = precise_spells.new()
