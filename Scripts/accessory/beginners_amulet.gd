class_name beginners_amulet extends accessory

func _init():
	acc_id = 1
	acc_name = "Beginner's Amulet"
	acc_type = TYPE.AMULET
	perks = [swift_reload.new(), expertise.new()]
	level = 1
	main_stat_base = 30
	con_stat_base = 50
	
	acc_calc()
