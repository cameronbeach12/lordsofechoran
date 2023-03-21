extends Resource
class_name Armor

enum TYPE {
	HELM,
	CHEST,
	LEGS,
	FEET
}
#Change Bounds Here
const min_stat: int = 50
const max_stat: int = 75

const min_con: int = 50
const max_con: int = 80


@export_group("Information")
@export var _id:int
@export var _name:String
@export var armor_type:TYPE
var level: int

@export_group("Stats")
@export_range(min_stat, max_stat, 1) var main_stat_base: int = 50
@export_range(min_con, max_con, 1) var con_stat_base: int = 50
var main_stat_increase: int
var constitution_increase: int
var main_stat_mod: float = 25
var con_stat_mod: float = 15

@export_group("Perk")
@export var perks: perk

func _init():
	level = 1

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
