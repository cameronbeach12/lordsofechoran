class_name beginners_bow extends pistol

func _init():
	weapon_id = 1
	weapon_name = "Beginner's Bow"
	level = 1 #max level = 60
	#35-65
	#50 is average quality
	#65 is best quality in the game
	#35 is worst quality in the game
	#50 is nearly double damage of 75
	base_weapon_quality = 50
	
	weapon_qual_calc()
	
	perks = [critical_prowess.new(), quickened_spell.new()]
