extends CharacterBody2D

enum STATE {
	DEFAULT,
	IDLE,
	WALKING,
	CASTING,
	DASHING
}

enum CLASS {
	DEFAULT,
	BERSERKER,
	GUNSLINGER,
	WIZARD,
	MONK,
	PALADIN
}

enum DAMAGE_STAT {
	DEFAULT,
	STRENGTH,
	DEXTERITY,
	INTELLIGENCE
}

enum HEALING_STAT {
	DEFAULT,
	WISDOM
}

#QUEUE INTERRUPT PRIORITY - DASH, MOVEMENT, SKILL
#DASHING CLEARS THE QUEUE

#Enums
var _class = CLASS.DEFAULT #class type
var _state = STATE.IDLE #current player state

#weapon identification - eventually we will read this in
var weapon: Weapon
var helmet: Armor
var chest: Armor
var legs: Armor
var feet: Armor

#Arrays
var cooldowns = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0] #1-6 skills, 7 dash
var max_cooldowns = [20.0, 17.5, 15.0, 12.5, 10.0, 7.5, 10.0] # maximum cooldowns for all skills
var queue = [] #action queue

#Floats
var SPEED = 150.0 #Movement Speed
var DASH_MULT = 2.25 #Dash movement speed multiplier

#vectors
var target = position #target movement position

#animator
@onready var animator = $AnimatedSprite2D #sprite animation
@onready var devView = $Camera2D/DevText

#Bools
var actions = true #able to do actions yes/no

#Unassigned
var dash_direction

#class specifics, initialized later
var cooldown_reduction: float
var critical_damage_mod: float
var perks_list: Array
var inventory: Array
var damage_mod: float
var level: int
var constitution: int
var con_mod: float
var max_con_mod: float
var con_mod_per_level: float
var health: int
var critical_chance: float

var damage_stat: DAMAGE_STAT
var healing_stat: HEALING_STAT

var main_stat: int
var main_stat_mod: float

var attack_power: int

var spell_speed: float
	
