extends "res://Scripts/Player.gd"

@onready var LTT = preload("res://prefabs/light_the_torch.tscn")
@onready var FG = preload("res://prefabs/flame_grenade.tscn")
@onready var PA = preload("res://prefabs/piercing_arrow.tscn")

#skill stuff
var q_direction
var q_angle
var q_damage = 700

var w_target
var w_damage = 1000

var e_global_timer
var e_distance = 500
var e_old_ss
var e_old_cdr
var e_cdr_mod = 0.25
var e_spell_speed_mod = 1.25 
var e_duration = 5.0

var a_direction
var a_angle
var a_damage = 400

func level_up():
	level += 1
	
	verify_stats()

func _ready():
	max_cooldowns = [12.0, 16.0, 8.0, 6.0, 0, 0, 8]
	level = 1
	critical_chance = 0.10
	critical_damage_mod = 2.0
	spell_speed = 1.15
	damage_mod = 1.0
	perks_list = []
	con_mod = 0.8
	max_con_mod = 4.2
	cooldown_reduction = 0.0
	main_stat_mod = 1.0
	speed_mod = 1.0
	damage_stat = DAMAGE_STAT.DEXTERITY
	healing_stat = HEALING_STAT.WISDOM
	passive_description = "You are more dexterous than the others!\nGain 10% base critical strike chance and 15% increased spell speed!"
	#this will eventually be read in
	#0 weapon 1 helm 2 chest 3 legs 4 feet 5 acc1 6 acc2 7 acc3
	inventory = [high_level_bow.new(), beginners_helm.new(), beginners_chest.new(), beginners_legs.new(),\
	beginners_feet.new(), beginners_amulet.new(), beginners_earring.new(),beginners_ring.new()]
	
	verify_stats()
	
	for i in range(59):
		inventory[0].upgrade()
		inventory[1].upgrade()
		inventory[2].upgrade()
		inventory[3].upgrade()
		inventory[4].upgrade()
		inventory[5].upgrade()
		inventory[6].upgrade()
		inventory[7].upgrade()
		level_up()
		
func verify_stats():
	critical_chance = 0.10
	critical_damage_mod = 2.0
	spell_speed = 1.15
	damage_mod = 1.0
	perks_list = []
	con_mod = 0.8
	max_con_mod = 4.2
	cooldown_reduction = 0.0
	main_stat_mod = 1.0
	SPEED = 150
	speed_mod = 1.0
	damage_stat = DAMAGE_STAT.DEXTERITY
	healing_stat = HEALING_STAT.WISDOM
	passive_description = "You are more dexterous than the others!\nGain 10% base critical strike chance and 15% increased spell speed!"
	
	constitution = 400 + inventory[1].constitution_increase + inventory[2].constitution_increase \
	+ inventory[3].constitution_increase + inventory[4].constitution_increase \
	+ inventory[5].constitution_increase + inventory[6].constitution_increase \
	+ inventory[7].constitution_increase
	
	perks_management()

	#19 level ups, so divide by 19
	con_mod_per_level = (max_con_mod - con_mod) / 19
	
	if level != 1:
		for i in range(level - 1):
			con_mod = con_mod + con_mod_per_level
	
	health = constitution * con_mod
	
	main_stat = (400 + inventory[1].main_stat_increase + inventory[2].main_stat_increase \
	+ inventory[3].main_stat_increase + inventory[4].main_stat_increase \
	+ inventory[5].main_stat_increase + inventory[6].main_stat_increase \
	+ inventory[7].main_stat_increase) * main_stat_mod

	attack_power = inventory[0].weapon_quality * sqrt(main_stat) / 10
	SPEED = SPEED * speed_mod
	
	print("Level: " + str(level))
	print("Constitution: " + str(constitution))
	print("Health: " + str(health))
	print("Main Stat: " + str(main_stat))
	print("Spell Speed: %.2f" % spell_speed)
	print("Critical Chance: " + str(critical_chance))
	print("Damage Modifier: " + str(damage_mod))
	print("Attack Power: " + str(attack_power))
	print("Speed: " + str(SPEED))
	print("Critical Damage Modifier: %.2f" % critical_damage_mod)
	print("Cooldown Reduction: %.2f" % cooldown_reduction)
	print("Main Stat Modifier: %.2f" % main_stat_mod)
	print("Normal Damage Example (Archer Q): " + str(attack_power * damage_mod * 700))
	print("Critical Damage Example (Archer Q): " + str(int(critical_damage_mod*(attack_power * damage_mod * 700))))
	print()
		
func _input(event):
	if Input.is_action_just_pressed("skill1") and animator.animation != "skill_1":
		print("yes")
		q_direction = (get_global_mouse_position() - global_position).normalized()
		q_angle = get_global_mouse_position()
	if Input.is_action_just_pressed("skill2") and animator.animation != "skill_2":
		print("yes")
		w_target = get_global_mouse_position()
	if Input.is_action_just_pressed("skill4") and animator.animation != "skill_4":
		print("yes")
		a_direction = (get_global_mouse_position() - global_position).normalized()
		a_angle = get_global_mouse_position()
	
func Skill1():
	var LTTinstance = LTT.instantiate()
	
	LTTinstance.crit_chance = critical_chance
	LTTinstance.crit_damage = critical_damage_mod
	
	LTTinstance.damage_calc = (attack_power * damage_mod * q_damage)
	
	LTTinstance.direction = q_direction
	LTTinstance.global_position = global_position
	LTTinstance.look_at(q_angle)

	get_node("/root").add_child(LTTinstance)
	
func Skill2():
	var FGinstance = FG.instantiate()
	
	FGinstance.crit_chance = critical_chance
	FGinstance.crit_damage = critical_damage_mod
	
	FGinstance.damage_calc = (attack_power * damage_mod * w_damage)
	
	FGinstance.target = w_target
	
	FGinstance.global_position = global_position
	
	get_node("/root").add_child(FGinstance)
	
func Skill3():
	e_global_timer = Timer.new()
	e_global_timer.wait_time = e_duration
	e_global_timer.autostart = true
	add_child(e_global_timer)
	e_global_timer.connect("timeout", e_timeout)
	
	e_old_ss = spell_speed
	e_old_cdr = cooldown_reduction
	
	spell_speed = spell_speed * e_spell_speed_mod
	cooldown_reduction = cooldown_reduction + e_cdr_mod
	
	print(spell_speed)
	print(cooldown_reduction)
	
func Skill4():
		var piercing_arrow = PA.instantiate()
	
		piercing_arrow.crit_chance = critical_chance
		piercing_arrow.crit_damage = critical_damage_mod
		
		piercing_arrow.damage_calc = (attack_power * damage_mod * a_damage)
		
		piercing_arrow.direction = a_direction
		piercing_arrow.global_position = global_position
		piercing_arrow.look_at(a_angle)

		get_node("/root").add_child(piercing_arrow)

func e_timeout():
	spell_speed = e_old_ss
	cooldown_reduction = e_old_cdr
	
	e_global_timer.queue_free()
	
	print(spell_speed)
	print(cooldown_reduction)

#at the end of an animation, check to see if the animation was a spell
func _on_animated_sprite_2d_animation_looped():
	CheckSpellAnim()
	
