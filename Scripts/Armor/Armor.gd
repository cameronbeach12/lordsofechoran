class_name Armor extends Node

enum TYPE {
	HELM,
	CHEST,
	LEGS,
	FEET
}

var armor_id:int
var armor_name:String
var armor_type:TYPE
var main_stat_base: int # 50-75
var con_stat_base: int # 50-80
var main_stat_increase: int
var constitution_increase: int
var main_stat_mod: float = 20
var con_stat_mod: float = 20
var perks: perk
var level: int

func upgrade():
	level += 1
	
	armor_calc()
		
func armor_calc():
	main_stat_increase = main_stat_base
	constitution_increase = con_stat_base
	
	for i in range(level):
		main_stat_increase *= 1 + (60.0 / (540.0 + (60.0 + (i + 1.0) * main_stat_mod)))
		constitution_increase *= 1 + (60.0 / (540.0 + (60.0 + (i + 1.0) * con_stat_mod)))
	
	print("Armor")	
	print(main_stat_increase)
	print(constitution_increase)
