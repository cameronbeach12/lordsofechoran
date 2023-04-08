extends Node
class_name Ability

var timer: Timer
var instance
var max_cooldown
var cooldown
var damage
var is_on_cooldown: bool = false
var player_instance

var buff_duration
var buff_timer

func SetBuffTimer():
	buff_timer = Timer.new()
	buff_timer.wait_time = buff_duration
	buff_timer.autostart = false
	add_child(buff_timer)
	buff_timer.connect("timeout", buff_timeout)

func SetTimer():
	timer = Timer.new()
	timer.wait_time = cooldown
	timer.autostart = false
	add_child(timer)
	timer.connect("timeout", cd_timeout)
	
func cd_timeout():
	timer.stop()
	is_on_cooldown = false
	
	print(self.name + (" => Cooldown Off"))
	
func reset_stats():
	#defined by ability
	pass
	
func buff_timeout():
	buff_timer.stop()
	
	reset_stats()
