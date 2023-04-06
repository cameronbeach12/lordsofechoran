extends Ability

func _ready():
	instance = load("res://prefabs/Abilities/flame_grenade/flame_grenade_instance.tscn")
	cooldown = 18.0
	damage = 900
	
	SetTimer()

func execute(s):
	is_on_cooldown = true
	timer.start()
	
	var create = instance.instantiate()
	create.target = s.get_global_mouse_position()
	create.global_position = s.global_position
	
	create.crit_chance = s.critical_chance
	create.crit_damage = s.critical_damage
	create.damage_calc = s.attack_power * s.damage_modifier * damage
	
	get_node("/root").add_child(create)
