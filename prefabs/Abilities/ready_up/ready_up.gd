extends Ability

var old_damage_mod
var old_spell_speed

#multiplicative
var buff_damage
#multiplicative
var buff_spell_speed

func _ready():
	instance = load("res://prefabs/Abilities/ready_up/ready_up_instance.tscn")
	max_cooldown = 7.5
	cooldown = max_cooldown
	damage = 400
	
	buff_duration = 5.0 
	SetBuffTimer()
	
	buff_damage = 1.30
	buff_spell_speed = 1.50
	
	SetTimer()

func execute(s):
	player_instance = s
	
	is_on_cooldown = true
	timer.wait_time = max_cooldown * (1 - s.cooldown_reduction)
	timer.start()
	
	buff_timer.start()
	
	var create = instance.instantiate()
	
	if old_damage_mod != null and old_spell_speed != null:
		reset_stats()
	
	old_damage_mod = s.damage_modifier
	old_spell_speed = s.spell_speed
	
	s.damage_modifier *= buff_damage
	s.spell_speed *= buff_spell_speed
	
	create.crit_chance = s.critical_chance
	create.crit_damage = s.critical_damage
	create.damage_calc = s.attack_power * s.damage_modifier * damage
	
	create.direction = (s.get_global_mouse_position() - s.global_position).normalized()
	create.global_position = s.global_position
	create.look_at(s.get_global_mouse_position())
	
	get_node("/root").add_child(create)

func reset_stats():
	player_instance.damage_modifier = old_damage_mod
	player_instance.spell_speed = old_spell_speed
