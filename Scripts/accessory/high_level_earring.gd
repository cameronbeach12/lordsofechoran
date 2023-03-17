class_name high_level_earring extends accessory

func _init():
	acc_id = 5
	acc_name = "High-Level Earring"
	acc_type = TYPE.EARRING
	perks = [swift_reload.new(), expertise.new()]
	level = 1
	main_stat_base = 60
	con_stat_base = 65
	
	acc_calc()
