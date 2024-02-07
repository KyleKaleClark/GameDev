
extends CharacterBody2D 

var player = load("res://player/rabbit.tscn")



func _physics_process(delta):
	var motion = Vector2()

	#position += (player.position - position)/50
	#look_at(player.position)
	#move_and_collide(motion)
	pass
