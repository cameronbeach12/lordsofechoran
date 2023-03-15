extends CharacterBody2D

var max_health = 1000000000
var health = max_health
@onready var healthbar = $EnemyHealthBar

func _ready():
	healthbar._on_max_health_updated(max_health)
	healthbar._on_health_updated(health)

func damage(dam):
	health -= dam
	
	healthbar._on_health_updated(health)
