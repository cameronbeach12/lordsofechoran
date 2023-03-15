extends Area2D

@onready var animator = $AnimatedSprite2D
@onready var damageIndicator = preload("res://prefabs/damage_indicator.tscn")
var activated
var bonus_damage = 1.35
var crit_chance
var crit_damage
var crit
var damage_calc

# Called when the node enters the scene tree for the first time.
func _ready():
	animator.play("default")
	animator.connect("animation_looped", destroy)
	$Hitbox.disabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if animator.frame == 2:
		$Hitbox.disabled = false
	else:
		$Hitbox.disabled = false
		
func destroy():
	self.queue_free()
	
func damage_calculation():
	var random = randf_range(0, 1)
	
	if activated == true:
		if crit_chance >= random:
			crit = true
			return bonus_damage * (crit_damage * (damage_calc))
		else:
			return bonus_damage * damage_calc
	else:
		if crit_chance >= random:
			crit = true
			return crit_damage * damage_calc
		else:
			return damage_calc
		

func _on_body_entered(body):
	var random = randf_range(0, 1)
	
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
