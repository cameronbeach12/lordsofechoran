extends entity
class_name player_class

var move: Node = LoadAbility("move")
var dash: Node = LoadAbility("dash")
var skill1: Node = LoadAbility("flame_grenade")
var skill2: Node = LoadAbility("light_the_torch")
var skill3: Node
var skill4: Node
var skill5: Node
var skill6: Node

@onready var weapon : Weapon = preload("res://Scripts/Weapons/Physical/beginners_bow.tres")
@onready var head : Armor = preload("res://Scripts/Armor/beginners_helm.tres")
@onready var chest : Armor = preload("res://Scripts/Armor/beginners_chest.tres")
@onready var legs : Armor = preload("res://Scripts/Armor/beginners_legs.tres")
@onready var feet : Armor = preload("res://Scripts/Armor/beginners_feet.tres")
@onready var amulet : Accessory = preload("res://Scripts/accessory/beginners_amulet.tres")
@onready var earring : Accessory = preload("res://Scripts/accessory/beginners_earring.tres")
@onready var ring : Accessory = preload("res://Scripts/accessory/beginners_ring.tres")

func _ready():
	level = 1
	
	constitution = 400
	
	health_regen = 50
	mana_regen = 50
	
	speed = 150
	dash_distance = 75
	dash_speed = dash_distance * (speed / 30)
	dash_timer = Timer.new()
	
	endurance = 1000
	endurance_mod = 1.0
	
	main_stat = 400
	main_stat_modifier = 1.0
	critical_chance = 0 
	critical_damage = 2.0 
	cooldown_reduction = 0.0 
	spell_speed = 1.0 
	speed_modifier = 1.0 
	damage_modifier = 1.0
	healing_modifier = 1.0
	shielding_modifier = 1.0
	
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
		SetAttackPower(weapon.weapon_quality)
	
	log_stats()
		
	weapon.upgrade(self)
	level_up()
	weapon.upgrade(self)
	level_up()
	head.upgrade(self)
	log_stats()
		
func SetConstitution():
	constitution = (400 + head.constitution_increase + chest.constitution_increase \
	+ legs.constitution_increase + feet.constitution_increase + amulet.constitution_increase\
	+ earring.constitution_increase + ring.constitution_increase) * con_modifier
	
func SetMainStat():
	main_stat = (400 + head.main_stat_increase + chest.main_stat_increase \
	+ legs.main_stat_increase + feet.main_stat_increase + amulet.main_stat_increase \
	+ earring.main_stat_increase + ring.main_stat_increase) * main_stat_modifier
	
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

func level_up():
	level += 1
	
	IncreaseEndurance()
	SetConstitutionMod()
	SetConstitution()
	SetMaxHealth()
	SetMaxMana()
	
	log_stats()

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
			PerformSkill(i+1)
		
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
		if not skill1.is_on_cooldown:
			skill1.execute(self)
	if skill_num == 2:
		if not skill2.is_on_cooldown:
			skill2.execute(self)
	
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
		

	
	
		
