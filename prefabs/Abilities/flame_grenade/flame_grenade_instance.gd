extends CharacterBody2D

var target
var can_move
var crit_chance
var crit_damage
var damage_calc
var direction
var speed = 450
var distance = 150
var explosion_time = 5.0
var health = 1

var timer

var explosion = preload("res://prefabs/Abilities/flame_grenade/fg_explosion.tscn")
@onready var animator = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	print(target)
	
	var explosion_timer = Timer.new()
	explosion_timer.wait_time = explosion_time
	explosion_timer.autostart = true
	add_child(explosion_timer)
	explosion_timer.connect("timeout", explosion_on_timeout)
	
	timer = Timer.new()
	timer.wait_time = float(distance) / speed
	timer.autostart = true
	add_child(timer)
	timer.connect("timeout", on_timeout)
	
	if target == null:
		target = position
		
	print(target)
	
	can_move = true
	
	direction = (target - position).normalized()
	
	animator.play("default")
	
func _physics_process(delta):
	if can_move:
		if position.distance_to(target) > speed * delta:
			position += direction * speed * delta
		else:
			can_move = false

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

func explosion_on_timeout():
	explode(false)
	
func on_timeout():
	timer.stop()
	
	can_move = false
