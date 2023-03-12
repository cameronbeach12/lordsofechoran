extends CharacterBody2D

enum STATE {
	DEFAULT,
	IDLE,
	WALKING,
	CASTING
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
const SPEED = 150.0
var target = position
var prev_velocity = Vector2()
@onready var animator = $AnimatedSprite2D
var queue = []

func animation():
	if _state == STATE.IDLE:
		animator.play("idle_down")
	elif _state == STATE.WALKING:
		if target.x > position.x:
			animator.play("walking_right")
		else:
			animator.play("walking_left")
			
func CheckSpellAnim():
	if animator.animation == "skill_1_GS":
		print(animator.animation)
		_state = STATE.IDLE
	elif animator.animation == "skill_2_GS":
		print(animator.animation)
		_state = STATE.IDLE
	elif animator.animation == "skill_3_GS":
		print(animator.animation)
		_state = STATE.IDLE
	elif animator.animation == "skill_4_GS":
		print(animator.animation)
		_state = STATE.IDLE
	elif animator.animation == "skill_5_GS":
		print(animator.animation)
		_state = STATE.IDLE
	elif animator.animation == "skill_6_GS":
		print(animator.animation)
		_state = STATE.IDLE
		
	if !queue.is_empty() and _class == CLASS.GUNSLINGER:
		if queue[0] != "movement":
			if queue[0].left(5) == "skill":
				_state = STATE.CASTING
				animator.play(queue[0] + "_GS")
				queue.clear()

func _physics_process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		target = get_global_mouse_position()
		if !queue.is_empty():
			if queue[0] != "movement":
				queue.clear()
				queue.insert(0, "movement")
		elif queue.is_empty() and _state == STATE.CASTING:
			queue.append("movement")
		
	if Input.is_action_just_pressed("skill1") and _state != STATE.CASTING:
		animator.play("skill_1_GS")
		target = position
		_state = STATE.CASTING
	elif Input.is_action_just_pressed("skill1") and _state == STATE.CASTING:
		if queue.is_empty():
			queue.append("skill_1")
		else:
			queue.insert(0, "skill_1")
				
	if Input.is_action_just_pressed("skill2") and _state != STATE.CASTING:
		animator.play("skill_2_GS")
		target = position
		_state = STATE.CASTING
	elif Input.is_action_just_pressed("skill2") and _state == STATE.CASTING:
		if queue.is_empty():
			queue.append("skill_2")
		else:
			queue.insert(0, "skill_2")
				
	if Input.is_action_just_pressed("skill3") and _state != STATE.CASTING:
		animator.play("skill_3_GS")
		target = position
		_state = STATE.CASTING
	elif Input.is_action_just_pressed("skill3") and _state == STATE.CASTING:
		if queue.is_empty():
			queue.append("skill_3")
		else:
			queue.insert(0, "skill_3")
				
	if Input.is_action_just_pressed("skill4") and _state != STATE.CASTING:
		animator.play("skill_4_GS")
		target = position
		_state = STATE.CASTING
	elif Input.is_action_just_pressed("skill4") and _state == STATE.CASTING:
		if queue.is_empty():
			queue.append("skill_4")
		else:
			queue.insert(0, "skill_4")
				
	if Input.is_action_just_pressed("skill5") and _state != STATE.CASTING:
		animator.play("skill_5_GS")
		target = position
		_state = STATE.CASTING
	elif Input.is_action_just_pressed("skill5") and _state == STATE.CASTING:
		if queue.is_empty():
			queue.append("skill_5")
		else:
			queue.insert(0, "skill_5")
	if Input.is_action_just_pressed("skill6") and _state != STATE.CASTING:
		animator.play("skill_6_GS")
		target = position
		_state = STATE.CASTING
	elif Input.is_action_just_pressed("skill6") and _state == STATE.CASTING:
		if queue.is_empty():
			queue.append("skill_6")
		else:
			queue.insert(0, "skill_6")
				
	
	velocity = position.direction_to(target) * SPEED
	
	if position.distance_to(target) > SPEED * delta:
		if _state != STATE.CASTING:
			queue.clear()
			move_and_slide()
	
	if (abs(target.x - position.x) < (SPEED * delta) and abs(target.y - position.y) < (SPEED * delta)) and _state != STATE.CASTING:
		_state = STATE.IDLE
	else:
		if _state != STATE.CASTING:
			_state = STATE.WALKING
	
	animation()
	print(queue)

func _on_animated_sprite_2d_animation_looped():
	CheckSpellAnim()
