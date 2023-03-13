extends CharacterBody2D

enum STATE {
	DEFAULT,
	IDLE,
	WALKING,
	CASTING,
	DASHING
}

enum DAMAGE_TYPE {
	DEFAULT,
	PHYSICAL,
	FIRE,
	ICE,
	EARTH,
	WATER
}

enum CLASS {
	DEFAULT,
	BERSERKER,
	GUNSLINGER,
	WIZARD,
	MONK,
	PALADIN
}

#QUEUE INTERRUPT PRIORITY - DASH, MOVEMENT, SKILL
#DASHING CLEARS THE QUEUE

#Enums
var _class = CLASS.GUNSLINGER #class type
var _damage_type = DAMAGE_TYPE.DEFAULT #damage type
var _state = STATE.IDLE #current player state

#Arrays
var cooldowns = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0] #1-6 skills, 7 dash
var max_cooldowns = [20.0, 17.5, 15.0, 12.5, 10.0, 7.5, 10.0] # maximum cooldowns for all skills
var queue = [] #action queue

#Floats
const SPEED = 150.0 #Movement Speed
const DASH_MULT = 2.25 #Dash movement speed multiplier

#vectors
var target = position #target movement position

#animator
@onready var animator = $AnimatedSprite2D #sprite animation
@onready var devView = $Camera2D/DevText

#Strings
var suffix = "" #class suffix

#Bools
var actions = true #able to do actions yes/no

#Unassigned
var dash_direction

#set suffix among other creation items
func _ready():	
	if _class == CLASS.GUNSLINGER:
		suffix = "_GS"
	elif _class == CLASS.BERSERKER:
		suffix = "_BER"
	elif _class == CLASS.MONK:
		suffix = "_MK"
	elif _class == CLASS.PALADIN:
		suffix = "_PAL"
	elif _class == CLASS.WIZARD:
		suffix = "_WIZ"
	else:
		print("CLASS IS DEFAULT -> ANIMATION NOT VALID")

#action animation handler
func animation():
	if _state == STATE.IDLE:
		animator.play("idle_down")
	elif _state == STATE.WALKING:
		if target.x > position.x:
			animator.play("walking_right")
		else:
			animator.play("walking_left")
			
func CheckSpellAnim():
	var spell = 0
	
	#loop through skills
	for i in range(6):
		if animator.animation == "skill_" + str(i+1) + suffix:
			_state = STATE.IDLE
	
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
				animator.play(queue[0] + suffix)
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
					animator.play("skill_" + str(i+1) + suffix)
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

#at the end of an animation, check to see if the animation was a spell
func _on_animated_sprite_2d_animation_looped():
	CheckSpellAnim()
