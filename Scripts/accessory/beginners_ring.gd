class_name beginners_ring extends accessory

func _init():
	acc_id = 3
	acc_name = "Beginner's Ring"
	acc_type = TYPE.RING
	perks = [swift_reload.new(), expertise.new()]
	level = 1
	
	acc_calc()
