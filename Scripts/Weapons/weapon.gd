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
var weapon_quality: int
var weapon_type: TYPE
var perks: Array
var level: int

func upgrade():
	level += 1
	
	weapon_qual_calc()
			
func weapon_qual_calc():
	weapon_quality = 101
	
	for i in range(level - 1):
		if level > 40:
			weapon_quality = weapon_quality * 1.05
		elif level > 20:
			weapon_quality = weapon_quality * 1.04
		else:
			weapon_quality = weapon_quality * 1.03
