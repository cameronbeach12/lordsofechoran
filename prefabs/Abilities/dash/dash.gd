extends Ability	

func _ready():
	cooldown = 8.0
	
	SetTimer()

func execute(s, speed):
	s.velocity = s.velocity.normalized() * s.dash_speed
	
func CooldownTimeout():
	timer.stop()
	is_on_cooldown = false
