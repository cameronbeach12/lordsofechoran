extends player_class
class_name Archer

func _ready():
	skill1 = LoadAbility("light_the_torch")
	skill2 = LoadAbility("flame_grenade")
	skill3 = LoadAbility("ready_up")
	skill4 = LoadAbility("piercing_arrow")
	skill5 = LoadAbility("light_feet")
	
	weapon = LoadWeapon("beginners_bow")
	head = LoadArmor("beginners_helm")
	chest = LoadArmor("beginners_chest")
	legs = LoadArmor("beginners_legs")
	feet = LoadArmor("beginners_feet")
	amulet = LoadAccessory("beginners_amulet")
	earring = LoadAccessory("beginners_earring")
	ring = LoadAccessory("beginners_ring")
	
	GetReady()
	
	for i in range(59): level_up()
	
	for i in range(19):
		for j in range(8):
			inventory[j].upgrade(self)
	
	log_stats()
	
func SetStats():
	constitution = 400
	
	health_regen = 50
	mana_regen = 50
	
	speed = 150
	dash_distance = 75
	dash_speed = dash_distance * (speed / 30)
	dash_timer = Timer.new()
	
	endurance = 800
	endurance_mod = 0.8
	
	main_stat = 400
	main_stat_modifier = 1.0
	critical_chance = 0.0
	critical_damage = 2.0 
	cooldown_reduction = 0.0 
	spell_speed = 1.0 
	speed_modifier = 1.0 
	damage_modifier = 1.0
	healing_modifier = 1.0
	shielding_modifier = 1.0
