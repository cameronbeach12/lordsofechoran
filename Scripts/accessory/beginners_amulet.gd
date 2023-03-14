class_name beginners_amulet extends accessory

func _init():
	acc_id = 1
	acc_name = "Beginner's Amulet"
	acc_type = TYPE.AMULET
	perks = [swift_reload.new(), expertise.new()]
	level = 1
	
	acc_calc()
