extends CharacterBody2D

enum STATE {
	IDLE,
	WALKING,
	CASTING
}

var state = STATE.IDLE
const SPEED = 100.0
var target = position
var prev_velocity = Vector2()
@onready var animator = $AnimatedSprite2D

func animation():
	if state == STATE.IDLE:
		animator.play("idle_down")
	else:
		if target.x > position.x:
			animator.play("walking_right")
		else:
			animator.play("walking_left")

func _physics_process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		target = get_global_mouse_position()
	
	velocity = position.direction_to(target) * SPEED
	
	if position.distance_to(target) > SPEED * delta:
		move_and_slide()
	
	if abs(target.x - position.x) < (SPEED * delta) and abs(target.y - position.y) < (SPEED * delta):
		state = STATE.IDLE
	else:
		state = STATE.WALKING
	
	animation()
