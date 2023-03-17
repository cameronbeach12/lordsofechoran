class_name high_level_ring extends accessory

func _init():
	acc_id = 6
	acc_name = "High-Level Ring"
	acc_type = TYPE.RING
	perks = [swift_reload.new(), expertise.new()]
	level = 1
	main_stat_base = 60
	con_stat_base = 65
	
	acc_calc()
