class_name accessory extends Node

enum TYPE {
	AMULET,
	RING,
	EARRING
}

var acc_id:int
var acc_name:String
var acc_type:TYPE
var main_stat_increase: int #between 30 and 60
var constitution_increase: int # between 50 and 65
var main_stat_mod: float = 20
var con_mod: float = 20
var main_stat_base: int
var con_stat_base: int
var perks: Array
var level: int

func upgrade():
	level += 1
	
	acc_calc()
		
func acc_calc():
	main_stat_increase = main_stat_base
	constitution_increase = con_stat_base
	
	for i in range(level):
		main_stat_increase *= 1 + (60.0 / (540.0 + (60.0 + (i + 1.0) * main_stat_mod)))
		constitution_increase *= 1 + (60.0 / (540.0 + (60.0 + (i + 1.0) * con_mod)))
	
	print("Accessory")	
	print(main_stat_increase)
	print(constitution_increase)
