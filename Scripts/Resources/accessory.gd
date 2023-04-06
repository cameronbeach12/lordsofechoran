extends Resource
class_name Accessory

enum TYPE {
	AMULET,
	RING,
	EARRING
}

const min_main = 90
const max_main = 180
const min_con = 150
const max_con = 195

@export_group("Information")
@export var _id:int
@export var _name:String
@export var acc_type:TYPE
var level: int # max 20

@export_group("Stats")
var main_stat_increase: int #between 30 and 60
var constitution_increase: int # between 50 and 65
var main_stat_mod: float = 25
var con_mod: float = 20
@export_range(min_main, max_main, 1) var main_stat_base: int = 30
@export_range(min_con, max_con, 1) var con_stat_base: int = 50

@export_group("Perks")
@export var perks: Array

func _init():
	level = 1
	
	acc_calc()

func upgrade(s):
	level += 1
	
	acc_calc()
	
	s.SetConstitution()
	s.SetMainStat()
		
func acc_calc():
	main_stat_increase = main_stat_base
	constitution_increase = con_stat_base
	
	for i in range(level):
		main_stat_increase *= 1 + (60.0 / (540.0 + (60.0 + (i + 1.0) * main_stat_mod)))
		constitution_increase *= 1 + (60.0 / (540.0 + (60.0 + (i + 1.0) * con_mod)))
	
	#print("Accessory")	
	#print(main_stat_increase)
	#print(constitution_increase)

