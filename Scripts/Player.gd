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
	
#action animation handler
func animation():
	if _state == STATE.IDLE:
		animator.play("idle")
	elif _state == STATE.WALKING:
		if target.x > position.x:
			animator.play("walking")
			animator.flip_h = false
		else:
			animator.play("walking")
			animator.flip_h = true
			
func CheckSpellAnim():
	var spell = 0
	
	#loop through skills
	for i in range(6):
		if animator.animation == "skill_" + str(i+1):
			_state = STATE.IDLE
		if i == 0:
			Skill1()
		elif i == 1:
			Skill2()
		elif i == 2:
			Skill3()
		elif i == 3:
			Skill4()
		elif i == 4:
			Skill5()
		elif i == 5:
			Skill6()
	
	#check for end of dash
	if animator.animation == "dash":
		_state = STATE.IDLE
		target = position
		cooldowns[6] = max_cooldowns[6]
		actions = true
	
	#check the action queue
	if !queue.is_empty():
		if queue[0] != "movement":
			if queue[0].left(5) == "skill":
				spell = int(queue[0][6])
				cooldowns[spell-1] = max_cooldowns[spell-1]
				_state = STATE.CASTING
				animator.play(queue[0])
				queue.clear()
				
func CooldownManagement(t):	
	#decrease cooldowns by delta
	for i in range(cooldowns.size()):
		if cooldowns[i] > 0:
			cooldowns[i] -= t
		else:
			pass
			
func _physics_process(delta):
	devView.text = "Q Cooldown = " + str(int(cooldowns[0]))\
	+ "\nW Cooldown = " + str(int(cooldowns[1]))\
	+ "\nE Cooldown = " + str(int(cooldowns[2]))\
	+ "\nA Cooldown = " + str(int(cooldowns[3]))\
	+ "\nS Cooldown = " + str(int(cooldowns[4]))\
	+ "\nD Cooldown = " + str(int(cooldowns[5]))\
	+ "\nDash Cooldown = " + str(int(cooldowns[6]))\
	+ "\nState = " + str(_state)
	
	#manage cooldowns
	CooldownManagement(delta)
	
	#target and movement queue
	if actions:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			target = get_global_mouse_position()
			if !queue.is_empty():
				if queue[0] != "movement":
					queue.clear()
					queue.insert(0, "movement")
			elif queue.is_empty() and _state == STATE.CASTING:
				queue.append("movement")
				
		#Lots of animation stuff
		for i in range(6):
			if cooldowns[i] <= 0:
				if Input.is_action_just_pressed("skill" + str(i + 1)) and _state == STATE.CASTING:
					if queue.is_empty():
						queue.append("skill_" + str(i+1))
					else:
						queue.insert(0, "skill_" + str(i+1))
				if Input.is_action_just_pressed("skill" + str(i + 1)) and _state != STATE.CASTING:
					cooldowns[i] = max_cooldowns[i]
					animator.play("skill_" + str(i+1))
					target = position
					_state = STATE.CASTING
	#dashing
	if Input.is_action_just_pressed("dash") and cooldowns[6] <= 0:
		_state = STATE.DASHING
		dash_direction = (get_global_mouse_position() - global_position).normalized()
		target = get_global_mouse_position()
		animator.play("dash")
		actions = false
				
	#set velo in prep for movement
	if _state != STATE.DASHING:
		velocity = position.direction_to(target) * SPEED
	else:
		velocity = position.direction_to(target) * (SPEED * DASH_MULT)
	
	#move if we aren't close to our target, clear queue
	if _state != STATE.DASHING:
		if position.distance_to(target) > SPEED * delta:
			if _state != STATE.CASTING:
				queue.clear()
				move_and_slide()
	else: #dash movement
		queue.clear()
		position += SPEED*DASH_MULT*delta*dash_direction
	
	#state checks
	if (abs(target.x - position.x) < (SPEED * delta) and abs(target.y - position.y) < (SPEED * delta)) and _state != STATE.CASTING and _state != STATE.DASHING:
		_state = STATE.IDLE
	else:
		if _state != STATE.CASTING and _state != STATE.DASHING:
			_state = STATE.WALKING
	
	#animate
	animation()

#These functions will be polymorphed by child				
func Skill1():
	pass

func Skill2():
	pass
	
func Skill3():
	pass
	
func Skill4():
	pass

func Skill5():
	pass

func Skill6():
	pass
