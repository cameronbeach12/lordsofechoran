extends Ability

func _ready():
	instance = load("res://prefabs/Abilities/flame_grenade/flame_grenade_instance.tscn")
	max_cooldown = 18.0
	cooldown = max_cooldown
	damage = 1400
	
	SetTimer()

func execute(s):
	is_on_cooldown = true
	
	timer.wait_time = max_cooldown * (1 - s.cooldown_reduction)
	timer.start()
	
	print(timer.wait_time)
	
	var create = instance.instantiate()
	create.target = s.get_global_mouse_position()
	create.global_position = s.global_position
	
	create.crit_chance = s.critical_chance
	create.crit_damage = s.critical_damage
	create.damage_calc = s.attack_power * s.damage_modifier * damage
	
	get_node("/root").add_child(create)
