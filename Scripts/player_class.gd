extends entity
class_name player_class

var move: Node = LoadAbility("move")
var dash: Node = LoadAbility("dash")
var skill1: Node
var skill2: Node
var skill3: Node
var skill4: Node
var skill5: Node
var skill6: Node

var inventory = [Weapon, Armor, Armor, Armor, Armor, Accessory, Accessory, Accessory]

@onready var weapon : Weapon
@onready var head : Armor
@onready var chest : Armor
@onready var legs : Armor
@onready var feet : Armor
@onready var amulet : Accessory
@onready var earring : Accessory
@onready var ring : Accessory

func LoadWeapon(weapon_name):
	return load("res://Scripts/Weapons/" + weapon_name + ".tres")

func LoadArmor(armor_name):
	return load("res://Scripts/Armor/" + armor_name + ".tres")

func LoadAccessory(acc_name):
	return load("res://Scripts/accessory/" + acc_name + ".tres")

func GetReady():
	inventory[0] = weapon
	inventory[1] = head
	inventory[2] = chest
	inventory[3] = legs
	inventory[4] = feet
	inventory[5] = amulet
	inventory[6] = earring
	inventory[7] = ring
	
	level = 1
	
	SetStats()
	
	is_busy = false
	is_dashing = false
	is_casting = false
		
	dash_timer.autostart = false
	dash_timer.wait_time = float(dash_distance)/dash_speed
	add_child(dash_timer)
	dash_timer.connect("timeout", DashTimeout)
	
	SetConstitutionMod()
	SetConstitution()
	SetMainStat()
	SetMaxHealth()
	SetMaxMana()
	if weapon == null:
		SetAttackPower(400)
	else:
		SetAttackPower(inventory[0].weapon_quality)
	perks()

func SetStats():
	#done by class
	pass
	
func SetConstitution():
	constitution = (400 + inventory[1].constitution_increase + inventory[2].constitution_increase \
	+ inventory[3].constitution_increase + inventory[4].constitution_increase + inventory[5].constitution_increase\
	+ inventory[6].constitution_increase + inventory[7].constitution_increase) * con_modifier
	
func SetMainStat():
	main_stat = (400 + inventory[1].main_stat_increase + inventory[2].main_stat_increase \
	+ inventory[3].main_stat_increase + inventory[4].main_stat_increase + inventory[5].main_stat_increase \
	+ inventory[6].main_stat_increase + inventory[7].main_stat_increase) * main_stat_modifier
	
func log_stats():
	print("Level -> %d" % level)
	print("Constitution -> %d" % constitution)
	print("Constitution Modifier -> %0.2f" % con_modifier)
	print("Endurance -> %d" % endurance)
	print("Endurance Modifier -> %0.2f" % endurance_mod)
	print("Health -> %d" % health)
	print("Maximum Health -> %d" % max_health)
	print("Health Regeneration -> %d" % health_regen)
	print("Mana -> %d" % mana)
	print("Maximum Mana -> %d" % max_mana)
	print("Mana Regeneration -> %d" % mana_regen)
	print("Attack Power -> %d" % attack_power)
	print("Main Stat -> %d" % main_stat)
	print("Damage Modifier -> %0.2f" % damage_modifier)
	print("Cooldown Reduction -> %0.2f" % cooldown_reduction)
	print("Critical Chance -> %0.2f" % critical_chance)
	print("Critical Damage -> %0.2f" % critical_damage)
	print("Movement Speed -> %d" % speed)
	print("Dash Distance -> %d" % dash_distance)
	print("Dash Speed -> %d" % dash_speed)
	print("Healing Modifier -> %0.2f" % healing_modifier)
	print("Shielding Modifier -> %0.2f" % shielding_modifier)
	print("Spell Speed -> %0.2f\n" % spell_speed)
	
func perks():
	for i in range(2):
		damage_modifier = 1.0 + inventory[0].perks[i].damage_modifier + (inventory[0].perks[i].damage_mod_increase_per_level * level)
	
	for i in range(2):
		critical_damage = 2.0 + inventory[0].perks[i].critical_dam_modifier + (inventory[0].perks[i].critical_dam_mod_increase_per_level * level)
	
	for i in range(2):
		cooldown_reduction = 0.0 + inventory[0].perks[i].cdr_modifier + (inventory[0].perks[i].cdr_mod_increase_per_level * level)
		
	for i in range(2):
		main_stat_modifier = 1.0 + inventory[0].perks[i].main_stat_modifier + (inventory[0].perks[i].main_stat_mod_increase_per_level * level)
		
	for i in range(2):
		critical_chance = 0.0 + inventory[0].perks[i].critical_modifier + (inventory[0].perks[i].critical_mod_increase_per_level * level)

	for i in range(2):
		spell_speed = 1.0 + inventory[0].perks[i].spell_speed_modifier + (inventory[0].perks[i].spell_speed_increase_per_level * level)
		
	for i in range(4):
		damage_modifier += inventory[i+1].perks.damage_modifier + (inventory[i+1].perks.damage_mod_increase_per_level * level)
		critical_damage += inventory[i+1].perks.critical_dam_modifier + (inventory[i+1].perks.critical_dam_mod_increase_per_level * level)
		cooldown_reduction += inventory[i+1].perks.cdr_modifier + (inventory[i+1].perks.cdr_mod_increase_per_level * level)
		main_stat_modifier += inventory[i+1].perks.main_stat_modifier + (inventory[i+1].perks.main_stat_mod_increase_per_level * level)
		critical_chance += inventory[i+1].perks.critical_modifier + (inventory[i+1].perks.critical_mod_increase_per_level * level)
		spell_speed += inventory[i+1].perks.spell_speed_modifier + (inventory[i+1].perks.spell_speed_increase_per_level * level)
		
	for i in range(3):
		for j in range(2):
			damage_modifier += inventory[i+5].perks[j].damage_modifier + (inventory[i+5].perks[j].damage_mod_increase_per_level * level)
		
		for j in range(2):
			critical_damage += inventory[i+5].perks[j].critical_dam_modifier + (inventory[i+5].perks[j].critical_dam_mod_increase_per_level * level)
		
		for j in range(2):
			cooldown_reduction += inventory[i+5].perks[j].cdr_modifier + (inventory[i+5].perks[j].cdr_mod_increase_per_level * level)
			
		for j in range(2):
			main_stat_modifier += inventory[i+5].perks[j].main_stat_modifier + (inventory[i+5].perks[j].main_stat_mod_increase_per_level * level)
			
		for j in range(2):
			critical_chance += inventory[i+5].perks[j].critical_modifier + (inventory[i+5].perks[j].critical_mod_increase_per_level * level)

		for j in range(2):
			spell_speed += inventory[i+5].perks[j].spell_speed_modifier + (inventory[i+5].perks[j].spell_speed_increase_per_level * level)

func level_up():
	level += 1
	
	IncreaseEndurance()
	SetConstitutionMod()
	SetConstitution()
	SetMaxHealth()
	SetMaxMana()
	perks()
	
	#log_stats()

func check_input():
	#movement code
	if Input.is_action_pressed("move_up"):
		move.execute(self, "up")
	if Input.is_action_pressed("move_down"):
		move.execute(self, "down")
	if Input.is_action_pressed("move_left"):
		facing = FACING.LEFT
		move.execute(self, "left")
	if Input.is_action_pressed("move_right"):
		facing = FACING.RIGHT
		move.execute(self, "right")
	
	#dashing code
	if not dash.is_on_cooldown:
		if Input.is_action_just_pressed("dash"):
			if velocity == Vector2.ZERO:
				if facing == FACING.LEFT:
					move.execute(self,"left")
				else:
					move.execute(self, "right")
				SetDashing()
			else:
				SetDashing()
				
	#skills detection
	for i in range(6):
		if Input.is_action_just_pressed("skill" + str(i+1)):
			is_casting = true
			Animate(i+1)
			PerformSkill(i+1)

func Animate(skill_num):
	#written by class
	pass
	
func _physics_process(delta):
	if (!is_dashing):
		velocity = Vector2()
		
		check_input()
		
		velocity = velocity.normalized() * speed
	else:
		dash.execute(self, dash_speed)
	
	move_and_slide()
	
func PerformSkill(skill_num: int):
	if skill_num == 1:
		if skill1 != null:
			if not skill1.is_on_cooldown:
				skill1.execute(self)
	if skill_num == 2:
		if skill2 != null:
			if not skill2.is_on_cooldown:
				skill2.execute(self)
	if skill_num == 3:
		if skill3 != null:
			if not skill3.is_on_cooldown:
				skill3.execute(self)
	if skill_num == 4:
		if skill4 != null:
			if not skill4.is_on_cooldown:
				skill4.execute(self)
	if skill_num == 5:
		if skill5 != null:
			if not skill5.is_on_cooldown:
				skill5.execute(self)
	if skill_num == 6:
		if skill6 != null:
			if not skill6.is_on_cooldown:
				skill6.execute(self)
	
func SetDashing():
	#dash object timer start
	dash.is_on_cooldown = true
	dash.timer.start()
	
	#dash execute, timer start
	dash.execute(self, dash_speed)
	is_dashing = true
	dash_timer.start()
	
func DashTimeout():
	is_dashing = false
	
	dash_timer.stop()
	
func TakeDamage(amount: int):
	health -= amount
	
	print(health)
