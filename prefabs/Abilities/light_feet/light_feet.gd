extends Ability

var old_speed
var old_critical_chance
var old_dash_speed

var buff_critical_chance: float
var buff_speed: float

var dash_distance: int

var dash_timer: Timer

func _ready():
	max_cooldown = 12.0
	cooldown = max_cooldown
	damage = 0
	
	buff_duration = 8.0 
	SetBuffTimer()
	
	buff_critical_chance = 0.20
	buff_speed = 1.5
	
	SetTimer()
	
	dash_distance = 25
	
	dash_timer = Timer.new()
	dash_timer.autostart = false
	add_child(dash_timer)
	dash_timer.connect("timeout", dash_timeout)

func execute(s):
	player_instance = s
	
	is_on_cooldown = true
	timer.wait_time = max_cooldown * (1 - s.cooldown_reduction)
	timer.start()
	
	buff_timer.start()
	
	dash_timer.wait_time = float(dash_distance)/s.dash_speed
	
	dash_timer.start()
	
	if old_speed != null and old_critical_chance != null:
		print(old_speed)
		reset_stats()
	
	old_critical_chance = s.critical_chance
	old_speed = s.speed
	old_dash_speed = s.dash_speed
	
	s.critical_chance += buff_critical_chance
	s.speed *= buff_speed
	s.dash_speed *= buff_speed
	
	if s.velocity == Vector2.ZERO:
		if s.facing == s.FACING.LEFT:
			s.move.execute(s,"left")
		else:
			s.move.execute(s, "right")
	
	s.is_dashing = true

func reset_stats():
	player_instance.critical_chance = old_critical_chance
	player_instance.speed = old_speed
	
	print("RAN")

func dash_timeout():
	dash_timer.stop()
	
	player_instance.dash_speed = old_dash_speed

	player_instance.is_dashing = false
