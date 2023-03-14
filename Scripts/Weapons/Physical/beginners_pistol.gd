class_name beginners_bow extends pistol

func _init():
	weapon_id = 1
	weapon_name = "Beginner's Bow"
	level = 1 #max level = 60
	
	weapon_qual_calc()
	
	perks = [critical_prowess.new(), quickened_spell.new()]
