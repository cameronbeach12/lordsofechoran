extends CharacterBody2D

var max_health = 2000000000
var health = max_health
var time_alive: float
var can_accumulate: bool = false
@onready var healthbar = $EnemyHealthBar

func _ready():	
	healthbar._on_max_health_updated(max_health)
	healthbar._on_health_updated(health)

func _process(delta):
	if can_accumulate:
		time_alive += delta
	
	if health <= 0:
		death()
	
func death():
	print(time_alive)
	
	print("DPS %.1f" % (max_health/time_alive))
	
	queue_free()

func damage(dam):
	can_accumulate = true
	
	health -= dam
	
	healthbar._on_health_updated(health)
