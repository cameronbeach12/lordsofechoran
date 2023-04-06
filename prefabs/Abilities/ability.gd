extends Node
class_name Ability

var timer: Timer
var instance
var cooldown
var damage
var is_on_cooldown: bool = false

func SetTimer():
	timer = Timer.new()
	timer.wait_time = cooldown
	timer.autostart = false
	add_child(timer)
	timer.connect("timeout", cd_timeout)
	
func cd_timeout():
	timer.stop()
	is_on_cooldown = false
