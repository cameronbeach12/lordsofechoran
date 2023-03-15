class_name Weapon extends Node

enum TYPE {
	PISTOL,
	STAFF,
	AMULET,
	GREATSWORD,
	GAUNTLETS
}

var weapon_id:int
var weapon_name:String
var base_weapon_quality: int #between 50-75
var weapon_quality: int
var multiplier = 25
var weapon_type: TYPE
var perks: Array
var level: int

func upgrade():
	level += 1
	
	weapon_qual_calc()
			
func weapon_qual_calc():
	weapon_quality = base_weapon_quality
	
	for i in range(level):
		weapon_quality *= 1 + (60.0 / (540.0 + (60.0 + (i + 1.0) * multiplier)))
		
	print("Weapon")
	print(weapon_quality)
