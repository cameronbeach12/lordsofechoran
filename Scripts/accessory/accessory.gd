class_name accessory extends Node

enum TYPE {
	AMULET,
	RING,
	EARRING
}

var acc_id:int
var acc_name:String
var acc_type:TYPE
var main_stat_increase: int
var constitution_increase: int
var perks: Array
var level: int

func upgrade():
	level += 1
	
	acc_calc()
		
func acc_calc():
	main_stat_increase = 80
	constitution_increase = 130
	
	for i in range(level - 1):
		if level > 40:
			main_stat_increase = main_stat_increase * 1.05
			constitution_increase = constitution_increase * 1.05
		elif level > 20:
			main_stat_increase = main_stat_increase * 1.04
			constitution_increase = constitution_increase * 1.04
		else:
			main_stat_increase = main_stat_increase * 1.03
			constitution_increase = constitution_increase * 1.03
