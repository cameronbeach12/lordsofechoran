class_name beginners_earring extends accessory

func _init():
	acc_id = 2
	acc_name = "Beginner's Earring"
	acc_type = TYPE.EARRING
	perks = [swift_reload.new(), expertise.new()]
	level = 1
	
	acc_calc()
