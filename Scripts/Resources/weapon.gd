extends Resource
class_name Weapon

enum TYPE {
	BOW,
	STAFF,
	AMULET,
	GREATSWORD,
	GAUNTLETS
}

const min_mod = 50
const max_mod = 75

@export_group("Information")
@export var _id:int
@export var _name:String
var level: int

@export_group("Quality")
@export_range(min_mod, max_mod, 1) var base_weapon_quality: int = 50 #between 50-75
var weapon_quality: int
var multiplier = 25

@export_group("Weapon Type")
@export var weapon_type: TYPE

@export_group("Perks")
@export var perks: Array

func _init():
	level = 1

func upgrade():
	level += 1
	
	print("Weapon Level: %d" % level)
	
	weapon_qual_calc()
			
func weapon_qual_calc():
	print("My Base Weapon Quality %d" % base_weapon_quality)
	
	weapon_quality = base_weapon_quality
	
	for i in range(level):
		weapon_quality *= 1 + (60.0 / (540.0 + (60.0 + (i + 1.0) * multiplier)))
		
	print("Weapon")
	print(weapon_quality)
