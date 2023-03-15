extends CharacterBody2D

var target
var crit_chance
var crit_damage
var damage_calc
var SPEED = 350
var explosion_timer = 5.0
var health = 1

var explosion = preload("res://prefabs/fg_explosion.tscn")
@onready var animator = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = Timer.new()
	timer.wait_time = explosion_timer
	timer.autostart = true
	add_child(timer)
	timer.connect("timeout", on_timeout)
	
	animator.play("default")
	
func _physics_process(delta):
	velocity = position.direction_to(target) * SPEED
	
	if position.distance_to(target) > SPEED * delta:
		move_and_slide()

func explode(activated):
	var EXPLOSION = explosion.instantiate()
	EXPLOSION.activated = activated
	EXPLOSION.global_position = global_position
	
	EXPLOSION.damage_calc = damage_calc
	EXPLOSION.crit_chance = crit_chance
	EXPLOSION.crit_damage = crit_damage
	get_node("/root/").add_child(EXPLOSION)
	
	self.queue_free()
	
func damage():
	explode(true)

func on_timeout():
	explode(false)
