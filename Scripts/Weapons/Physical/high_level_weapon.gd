class_name high_level_bow extends pistol

func _init():
	weapon_id = 2
	weapon_name = "High-Level Bow"
	level = 1 #max level = 60
	base_weapon_quality = 75
	
	weapon_qual_calc()
	
	perks = [critical_prowess.new(), quickened_spell.new()]
