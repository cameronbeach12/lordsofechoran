extends Resource
class_name perk

@export_group("Perk Information")
@export var _name: String
@export var p_description: String

@export_group("Damage")
@export_range(0, 1, 0.00001) var damage_modifier : float
@export_range(0, 1, 0.00001) var damage_mod_increase_per_level: float

@export_group("Critical Damage")
@export_range(0, 1, 0.00001) var critical_dam_modifier: float
@export_range(0, 1, 0.00001) var critical_dam_mod_increase_per_level: float

@export_group("Cooldown Reduction")
@export_range(0, 1, 0.00001) var cdr_modifier: float
@export_range(0, 1, 0.00001) var cdr_mod_increase_per_level: float

@export_group("Main Stat")
@export_range(0, 1, 0.00001) var main_stat_modifier: float
@export_range(0, 1, 0.00001) var main_stat_mod_increase_per_level: float

@export_group("Healing")
@export_range(0, 1, 0.00001) var healing_modifier: float
@export_range(0, 1, 0.00001) var healing_mod_increase_per_level: float

@export_group("Shielding")
@export_range(0, 1, 0.00001) var shielding_modifier: float
@export_range(0, 1, 0.00001) var shielding_mod_increase_per_level: float

@export_group("Critical Chance")
@export_range(0, 1, 0.00001) var critical_modifier: float
@export_range(0, 1, 0.00001) var critical_mod_increase_per_level: float

@export_group("Spell Speed")
@export_range(0, 1, 0.00001) var spell_speed_modifier: float
@export_range(0, 1, 0.00001) var spell_speed_increase_per_level: float

@export_group("Conditions")
@export var has_condition: bool
