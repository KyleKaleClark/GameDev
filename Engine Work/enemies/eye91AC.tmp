extends CharacterBody2D
#extends KinematicsBody2D

#@onready var world = $Overworld
#@onready var playerpos = get_node("Rabbit").position()
@onready var animations = $AnimationPlayer
@export var speed = 60
var player_pos
var target_pos
@onready var player = get_parent().get_node("Rabbit")
var time: float = 0
var attack_timer
var attack_delta = 1
var flight_time = 2
var set_attack = true
var idled = false
var health = 2
#var velocity = Vector2()
var x = position.x; var y = position.y;
var Inv = false
var Invstart = false
@export var Invtimer = 0.75
var timeInv = 0
func _physics_process(delta):
	
	if (time == 0):
		attack_timer = randf_range(5,10)
		idled = false
		set_attack = false
		print('time to attack', attack_timer)
		
	time = time + delta
	
	
	if (time > attack_timer/2 and not idled):
		animations.play('idle')
		idled = true
	#print('time', time)
	if (time > attack_timer and not set_attack):
		if get_parent().get_node("Rabbit"):
			velocity.x =  round(player.position[0] - global_position[0])
			velocity.y =  round(player.position[1] - global_position[1])
		
		

		
		animations.stop()
		animations.play('fly')
		set_attack = true
			
	if (time > attack_timer+flight_time):
		print('STOPTIME')
		velocity.x = 0; velocity.y = 0;
		animations.stop()
		time = 0
	
	#move_and_slide()
	velocity = round(velocity.normalized() * speed)
	#print("Velocity", velocity)
	if Invstart:
		Inv = true
		Invstart = false
		timeInv = 0
		print("Inv start: ", timeInv)
	timeInv = timeInv + delta
	
	if timeInv > Invtimer and Inv:
		print('Inv still off')
		Inv = false
		velocity = velocity * -1
	
	move_and_slide()
	check_death()
	
	pass
	
	

func check_death():
	print('bat health', health)
	if health <= 0:
		queue_free()
#func jittercheck():
#	if old_vector != input_vector:
#		old_vector = input_vector
#	if input_vector != Vector2.ZERO:
#		position.x = round(position.x)
#		position.y = round(position.y)
	#var speed: float = 0.01 # put wanted speed here	
	#look_at(playerpos)	
	#self.position = lerp(self.position,playerpos,speed)	
	#move_and_slide()


func _on_hurtbox_area_entered(area):
	
	if (area.get_parent().name == 'item' or area.name == 'attack1') and not Inv:
		print('hit!')
		health -= area.get_damage()
		velocity = velocity * -1
		Invstart = true
		print("Vel post hit", velocity)
		#$Sprite2D.color
	pass # Replace with function body.
