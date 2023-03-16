extends Area2D

var direction
var crit_chance
var crit_damage
var damage_calc
var max_time = .35
var SPEED = 500
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
	
func _on_body_entered(body):
	print("Working")
	
	self.queue_free()
