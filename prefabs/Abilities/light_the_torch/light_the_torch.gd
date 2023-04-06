extends Ability

func _ready():
	instance = load("res://prefabs/Abilities/light_the_torch/light_the_torch_instance.tscn")
	cooldown = 9.0
	damage = 900
	
	SetTimer()

func execute(s):
	is_on_cooldown = true
	timer.start()
	
	var create = instance.instantiate()
	
	create.crit_chance = s.critical_chance
	create.crit_damage = s.critical_damage
	create.damage_calc = s.attack_power * s.damage_modifier * damage
	
	create.direction = (s.get_global_mouse_position() - s.global_position).normalized()
	create.global_position = s.global_position
	create.look_at(s.get_global_mouse_position())
	
	get_node("/root").add_child(create)
