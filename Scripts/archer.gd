extends "res://Scripts/Player.gd"

func perks_management():	
	for i in range(inventory.size()):
		if i == 0:
			for j in range(2):
				if inventory[i].perks[j].p_name == "Critical Prowess":
					critical_chance += inventory[i].perks[j].critical_modifier + (level*\
					inventory[i].perks[j].critical_mod_increase_per_level)
					perks_list.append(inventory[i].perks[j].p_name)
				elif inventory[i].perks[j].p_name == "Quickened Spell":
					spell_speed += inventory[i].perks[j].spell_speed_modifier + (level*\
					inventory[i].perks[j].spell_speed_increase_per_level)
					damage_mod *= inventory[i].perks[j].damage_modifier + (level*\
					inventory[i].perks[j].damage_mod_increase_per_level)
					perks_list.append(inventory[i].perks[j].p_name)
		elif i >= 1 and i <= 4:
			if inventory[i].perks.p_name == "Critical Prowess":
				critical_chance += inventory[i].perks.critical_modifier + (level*\
				inventory[i].perks.critical_mod_increase_per_level)
				perks_list.append(inventory[i].perks.p_name)
			elif inventory[i].perks.p_name == "Precise Spells":
				critical_damage_mod += inventory[i].perks.critical_dam_modifier + (level*\
				inventory[i].perks.critical_dam_mod_increase_per_level)
				perks_list.append(inventory[i].perks.p_name)
		else:
			for j in range(2):
				if inventory[i].perks[j].p_name == "Swift Reload":
					cooldown_reduction += inventory[i].perks[j].cdr_modifier + (level*\
					inventory[i].perks[j].cdr_mod_increase_per_level)
					perks_list.append(inventory[i].perks[j].p_name)
				elif inventory[i].perks[j].p_name == "Expertise":
					main_stat_mod += inventory[i].perks[j].main_stat_modifier + (level*\
					inventory[i].perks[j].main_stat_mod_increase_per_level)
					perks_list.append(inventory[i].perks[j].p_name)
				
func verify_stats():
	critical_chance = 0.0
	critical_damage_mod = 2.0
	spell_speed = 1.0
	damage_mod = 1.0
	perks_list = []
	con_mod = 0.8
	max_con_mod = 4.2
	main_stat_mod = 1.0
	damage_stat = DAMAGE_STAT.DEXTERITY
	healing_stat = HEALING_STAT.WISDOM
	cooldown_reduction = 0.0
	
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

	attack_power = inventory[0].weapon_quality * sqrt(main_stat) / 15
	
	print("Level: " + str(level))
	print("Constitution: " + str(constitution))
	print("Health: " + str(health))
	print("Main Stat: " + str(main_stat))
	print("Spell Speed: %.2f" % spell_speed)
	print("Critical Chance: " + str(critical_chance))
	print("Damage Modifier: " + str(damage_mod))
	print("Attack Power: " + str(attack_power))
	print("Critical Damage Modifier: %.2f" % critical_damage_mod)
	print("Cooldown Reduction: %.2f" % cooldown_reduction)
	print("Main Stat Modifier: %.2f" % main_stat_mod)
	print("Normal Damage Example (Archer Q): " + str(attack_power * damage_mod * 700))
	print("Critical Damage Example (Archer Q): " + str(int(critical_damage_mod*(attack_power * damage_mod * 700))))
	print()
	
func level_up():
	level += 1
	
	verify_stats()

func _ready():
	max_cooldowns = [12.0, 16.0, 0, 0, 0, 0, 8]
	level = 1
	critical_chance = 0.0
	critical_damage_mod = 2.0
	spell_speed = 1.0
	damage_mod = 1.0
	perks_list = []
	con_mod = 0.8
	max_con_mod = 4.2
	cooldown_reduction = 0.0
	main_stat_mod = 1.0
	damage_stat = DAMAGE_STAT.DEXTERITY
	healing_stat = HEALING_STAT.WISDOM
	#this will eventually be read in
	#0 weapon 1 helm 2 chest 3 legs 4 feet 5 acc1 6 acc2 7 acc3
	inventory = [beginners_bow.new(), beginners_helm.new(), beginners_chest.new(), beginners_legs.new(),\
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

#at the end of an animation, check to see if the animation was a spell
func _on_animated_sprite_2d_animation_looped():
	CheckSpellAnim()
	
