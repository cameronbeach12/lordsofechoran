extends Resource
class_name Ability

@export_group("Damage")
@export var base_damage: int
@export_subgroup("Modifier") 
@export_range(1, 10, 0.00001) var damage_mod: float

@export_group("Healing")
@export_range(1, 2, 0.00001) var base_healing: float
@export_subgroup("Modifier")
@export_range(1, 10, 0.00001) var healing_mod: float

@export_group("Shielding")
@export_range(1, 2, 0.00001) var base_shielding: float
@export_subgroup("Modifier")
@export_range(1, 10, 0.00001) var shielding_mod: float

@export_group("Modifiers")
@export_range(1, 10, 0.00001) var cdr_mod: float
@export_range(1, 10, 0.00001) var speed_mod: float
@export_range(1, 10, 0.00001) var spell_speed_mod: float
@export_range(1, 10, 0.00001) var crit_mod: float
@export_range(1, 10, 0.00001) var crit_dam_mod: float
@export_range(1, 10, 0.00001) var attack_power_mod: float
@export_range(1, 10, 0.00001) var main_stat_mod: float

@export_group("Functionality Script")
@export var functionality: Resource
