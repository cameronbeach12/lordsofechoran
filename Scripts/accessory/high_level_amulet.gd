class_name high_level_amulet extends accessory

func _init():
	acc_id = 4
	acc_name = "High-Level Amulet"
	acc_type = TYPE.AMULET
	perks = [swift_reload.new(), expertise.new()]
	level = 1
	main_stat_base = 60
	con_stat_base = 65
	
	acc_calc()
