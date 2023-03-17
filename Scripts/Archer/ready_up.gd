extends Area2D

var crit
var direction
var crit_chance
var crit_damage
var damage_calc
var max_time = .35
var SPEED = 500
@onready var damageIndicator = preload("res://prefabs/damage_indicator.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = Timer.new()
	timer.wait_time = max_time
	timer.autostart = true
	add_child(timer)
	timer.connect("timeout", on_timeout)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += SPEED*delta*direction
	
func on_timeout():
	self.queue_free()
	
func damage_calculation():
	var random = randf_range(0, 1)
	
	if crit_chance >= random:
		crit = true
		return (crit_damage * (damage_calc))
	else:
		crit = false
		return damage_calc
	
func _on_body_entered(body):
	var damage = damage_calc
	
	body.damage(damage)
	
	var DAMAGEIND = damageIndicator.instantiate()
	DAMAGEIND.global_position = global_position
	get_node("/root").add_child(DAMAGEIND)
	
	if crit == true:
		print("Crit")
		DAMAGEIND.label.text = str("%3d" % damage)
		DAMAGEIND.label.add_theme_color_override("font_color", Color(1, 0, 0, 1))
	else:
		print("No Crit")
		DAMAGEIND.label.text = str("%3d" % damage)
		DAMAGEIND.label.add_theme_color_override("font_color", Color(1, 1, 0, 1))
	
	self.queue_free()
