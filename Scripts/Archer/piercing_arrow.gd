extends Area2D

@onready var animator = $AnimatedSprite2D
@onready var damageIndicator = preload("res://prefabs/damage_indicator.tscn")
var bonus_damage = 1.00
var crit_chance
var crit_damage
var crit
var damage_calc
var direction
var SPEED = 500
var max_time = 0.35

# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = Timer.new()
	timer.wait_time = max_time
	timer.autostart = true
	add_child(timer)
	timer.connect("timeout", on_timeout)
	
	animator.play("default")

func on_timeout():
	self.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += SPEED*delta*direction

func damage_calculation():
	var random = randf_range(0, 1)
	
	if crit_chance >= random:
		crit = true
		return bonus_damage * (crit_damage * (damage_calc))
	else:
		crit = false
		return bonus_damage * damage_calc


func _on_body_entered(body):
	var damage = damage_calculation()
	
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
		
	bonus_damage += 0.1
