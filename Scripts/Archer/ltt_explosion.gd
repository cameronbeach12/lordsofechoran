extends Area2D

@onready var animator = $AnimatedSprite2D
@onready var damageIndicator = preload("res://prefabs/damage_indicator.tscn")
var crit_chance
var crit_damage
var damage_calc

# Called when the node enters the scene tree for the first time.
func _ready():
	animator.play("default")
	animator.connect("animation_looped", destroy)
	$Hitbox.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if animator.frame == 6:
		$Hitbox.disabled = false
	else:
		$Hitbox.disabled = true
	
func destroy():
	self.queue_free()


func _on_body_entered(body):
	var random = randf_range(0, 1)
	
	print(crit_chance)
	print(random)
	
	if crit_chance >= random:
		body.damage(crit_damage*damage_calc)
		
		var DAMAGEIND = damageIndicator.instantiate()
		DAMAGEIND.global_position = global_position
		get_node("/root").add_child(DAMAGEIND)
		
		DAMAGEIND.label.text = str("%3d" % (crit_damage*damage_calc))
		DAMAGEIND.label.add_theme_color_override("font_color", Color(1, 0, 0, 1))
		
	else:
		body.damage(damage_calc)
		
		var DAMAGEIND = damageIndicator.instantiate()
		DAMAGEIND.global_position = global_position
		get_node("/root").add_child(DAMAGEIND)
		DAMAGEIND.label.text = str("%3d" % damage_calc)
		DAMAGEIND.label.add_theme_color_override("font_color", Color(1, 1, 0, 1))

