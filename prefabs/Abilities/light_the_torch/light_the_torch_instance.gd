extends Area2D

var direction
var crit_chance
var crit_damage
var damage_calc
var max_time = .35
var SPEED = 500
@onready var EXPLOSION = preload("res://prefabs/Abilities/light_the_torch/ltt_explosion.tscn")
@onready var animator = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = Timer.new()
	timer.wait_time = max_time
	timer.autostart = true
	add_child(timer)
	timer.connect("timeout", on_timeout)
	
	animator.play("default")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += SPEED*delta*direction
	
func on_timeout():
	self.queue_free()
	
func explode():
	var explosion = EXPLOSION.instantiate()
	
	explosion.global_position = global_position
	
	explosion.damage_calc = damage_calc
	explosion.crit_chance = crit_chance
	explosion.crit_damage = crit_damage
	
	get_node("/root").add_child(explosion)


func _on_body_entered(body):
	if body.name == "Flame Grenade":
		body.damage()
		return
	
	explode()
