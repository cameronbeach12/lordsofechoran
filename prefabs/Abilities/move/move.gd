extends Node

func execute(s, dir):
	if dir == "up":
		s.velocity.y -= 1 
	if dir == "down":
		s.velocity.y += 1
	if dir == "left":
		s.velocity.x -= 1 
	if dir == "right":
		s.velocity.x += 1
