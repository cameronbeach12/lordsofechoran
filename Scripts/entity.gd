extends CharacterBody2D
class_name entity

enum FACING {
	DEFAULT,
	LEFT,
	RIGHT
}

var facing = FACING.DEFAULT

var max_health: int
var health: int
var health_regen: float

var max_mana: int
var mana: int
var mana_regen: float

var speed: int
var dash_speed: int
var dash_distance: int
var dash_timer: Timer

var endurance: int
var endurance_mod: float

var constitution: int
var con_modifier: float
var attack_power: int
var main_stat: int
var main_stat_modifier: float
var critical_chance: int
var critical_damage: float
var cooldown_reduction: float
var spell_speed: float
var speed_modifier: float
var damage_modifier: float
var healing_modifier: float
var shielding_modifier: float

var is_busy: bool
var is_dashing: bool
var is_casting: bool

var cooldowns: Array
var max_cooldowns: Array

var level: int

func IncreaseEndurance():
	endurance += 100 * endurance_mod

func SetConstitutionMod():
	con_modifier = maxf(0.5, float(endurance)/1000)
	
func SetEnduranceMod():
	endurance_mod = con_modifier

func SetHP():
	health = max_health
	
func HPRegen(delta: float):
	health += health_regen * delta
	
	CheckHP()
	
func CheckHP():
	if health > max_health:
		health = max_health
		
func SetMana():
	mana = max_mana
	
func ManaRegen(delta: float):
	mana += mana_regen * delta
	
	CheckMana()
	
func SetMaxMana():
	max_mana = 400 + level * level
	
	SetMana()
	
func CheckMana():
	if mana > max_mana:
		mana = max_mana
		
func SetAttackPower(quality):
	attack_power = quality * sqrt(main_stat) / 10
	
func SetMaxHealth():
	max_health = constitution
	
	SetHP()
	
func TakeDamage(amount: int):
	health -= amount
	
func LoadAbility(_name: String):
	var prefab = load("res://prefabs/Abilities/" + _name + "/" + _name + ".tscn")
	var prefabNode = prefab.instantiate()
	add_child(prefabNode)
	return prefabNode
