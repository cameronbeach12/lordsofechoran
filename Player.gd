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

var _class = CLASS.DEFAULT
var _damage_type = DAMAGE_TYPE.DEFAULT
var _state = STATE.IDLE
const SPEED = 150.0
var target = position
var prev_velocity = Vector2()
@onready var animator = $AnimatedSprite2D
	
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

func _physics_process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		target = get_global_mouse_position()
		
	if Input.is_action_just_pressed("skill1"):
		animator.play("skill_1_GS")
		_state = STATE.CASTING
	elif Input.is_action_just_pressed("skill2"):
		animator.play("skill_2_GS")
		_state = STATE.CASTING
	elif Input.is_action_just_pressed("skill3"):
		animator.play("skill_3_GS")
		_state = STATE.CASTING
	elif Input.is_action_just_pressed("skill4"):
		animator.play("skill_4_GS")
		_state = STATE.CASTING
	elif Input.is_action_just_pressed("skill5"):
		animator.play("skill_5_GS")
		_state = STATE.CASTING
	elif Input.is_action_just_pressed("skill6"):
		animator.play("skill_6_GS")
		_state = STATE.CASTING
	
	velocity = position.direction_to(target) * SPEED
	
	if position.distance_to(target) > SPEED * delta:
		move_and_slide()
	
	if (abs(target.x - position.x) < (SPEED * delta) and abs(target.y - position.y) < (SPEED * delta)) and _state != STATE.CASTING:
		_state = STATE.IDLE
	else:
		if _state != STATE.CASTING:
			_state = STATE.WALKING
	
	animation()
	print(_state)

func _on_animated_sprite_2d_animation_looped():
	CheckSpellAnim()
