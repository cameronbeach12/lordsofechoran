extends CharacterBody2D

enum STATE {
	IDLE,
	CHASE,
	PATROL,
	ATTACK
}

var timer: Timer

var state: STATE = STATE.IDLE
var max_health = 50000000
var health = max_health
var time_alive: float
var can_accumulate: bool = false
@onready var healthbar = $EnemyHealthBar

var canAttack = true
var justAttacked = false
var trackingObject
var attack_cooldown: float = 1.0
var movementSpeed: float = 100.0  
var movement_target_position: Vector2 = Vector2(60.0, 180.0)
@onready var navAgent = $NavigationAgent2D

func _ready():	
	healthbar._on_max_health_updated(max_health)
	healthbar._on_health_updated(health)
	
	navAgent.path_desired_distance = 4.0 
	navAgent.target_desired_distance = 4.0
	
	timer = Timer.new()
	timer.wait_time = attack_cooldown
	timer.autostart = false
	add_child(timer)
	timer.connect("timeout", on_timeout)
	
	call_deferred("actor_setup")
	
func on_timeout():
	canAttack = true
	
	timer.stop()

func actor_setup():
	await get_tree().physics_frame
	
	set_movement_target(movement_target_position)
	
func set_movement_target(movement_target: Vector2):
	navAgent.target_position = movement_target

func _process(delta):
	if can_accumulate:
		time_alive += delta
	
	if health <= 0:
		death()
		
func _physics_process(delta):
	if canAttack == false and justAttacked == true:
		var attack_reference = $Attack/Range
		attack_reference.disabled = true
		
		justAttacked = false
	
	if trackingObject != null:
		set_movement_target(trackingObject.global_position)
	
	if state == STATE.CHASE:
		var current_agent_position: Vector2 = global_position
		var next_path_position: Vector2 = navAgent.get_next_path_position()
		
		var new_velocity: Vector2 = next_path_position - current_agent_position
		
		new_velocity = new_velocity.normalized()
		new_velocity = new_velocity * movementSpeed
		
		velocity = new_velocity
		move_and_slide()
		
	if state == STATE.IDLE:
		pass
		
	if state == STATE.ATTACK and trackingObject != null and canAttack == true:
		canAttack = false
		justAttacked = true
		
		timer.start()
		
		var x_diff = trackingObject.position.x - self.position.x
		var y_diff = trackingObject.position.y - self.position.y
		
		var hyp = sqrt(x_diff**2 + y_diff**2)
		
		x_diff = x_diff / hyp
		y_diff = y_diff / hyp
		
		var attack_placement = Vector2(x_diff, y_diff) * 30
		
		var attack_reference = $Attack
		
		attack_reference.position = attack_placement
		
		var hitbox_reference = $Attack/Range
		
		hitbox_reference.disabled = false
	
func death():
	print(time_alive)
	
	print("DPS %.1f" % (max_health/time_alive))
	
	queue_free()

func damage(dam):
	can_accumulate = true
	
	health -= dam
	
	healthbar._on_health_updated(health)


func _on_player_detection_range_body_entered(body):
	state = STATE.CHASE
	trackingObject = body


func _on_player_detection_range_body_exited(body):
	state = STATE.IDLE
	
	trackingObject = null
	
	set_movement_target(global_position)


func _on_attack_target_range_body_entered(body):
	state = STATE.ATTACK


func _on_attack_target_range_body_exited(body):
	state = STATE.CHASE


func _on_attack_body_entered(body):
	if $Attack/Range.disabled == false:
		print(body)
		
	body.TakeDamage(100)
