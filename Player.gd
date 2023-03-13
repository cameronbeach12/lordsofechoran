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
var _class = CLASS.GUNSLINGER
var _damage_type = DAMAGE_TYPE.DEFAULT
var _state = STATE.IDLE

var cooldowns = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0] #1-6 skills, 7 dash
var max_cooldowns = [20.0, 17.5, 15.0, 12.5, 10.0, 7.5, 10.0]
var queue = []

const SPEED = 150.0
const DASH_MULT = 2.25

var target = position
var prev_velocity = Vector2()

@onready var animator = $AnimatedSprite2D
var suffix = ""
var actions = true
var dash_direction


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
	
	for i in range(6):
		if animator.animation == "skill_" + str(i+1) + suffix:
			_state = STATE.IDLE
			
	if animator.animation == "dash":
		_state = STATE.IDLE
		target = position
		cooldowns[6] = max_cooldowns[6]
		actions = true
		
	if !queue.is_empty() and _class == CLASS.GUNSLINGER:
		if queue[0] != "movement":
			if queue[0].left(5) == "skill":
				spell = int(queue[0][6])
				cooldowns[spell-1] = max_cooldowns[spell-1]
				_state = STATE.CASTING
				animator.play(queue[0] + "_GS")
				queue.clear()

func CooldownManagement(t):	
	print(cooldowns)
	
	for i in range(cooldowns.size()):
		if cooldowns[i] > 0:
			cooldowns[i] -= t
		else:
			pass

func _physics_process(delta):
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
				if Input.is_action_just_pressed("skill" + str(i + 1)) and _state != STATE.CASTING:
					cooldowns[i] = max_cooldowns[i]
					animator.play("skill_" + str(i+1) + suffix)
					target = position
					_state = STATE.CASTING
		for i in range(6):
			if cooldowns[i] <= 0:
				if Input.is_action_just_pressed("skill" + str(i + 1)) and _state == STATE.CASTING:
					if queue.is_empty():
						queue.append("skill_" + str(i+1))
					else:
						queue.insert(0, "skill_" + str(i+1))
			
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
	else:
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
