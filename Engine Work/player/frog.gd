extends CharacterBody2D

signal healthChanged

@export var speed: int = 35
@onready var animations = $AnimationPlayer
@onready var item = $item
var inAnim: bool = false
var direction = 'down'
var health = 3
var maxhealth = 3


@onready var basicmagic = preload("res://enemies/basicmagic.tscn")

func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#this just forces analog sticks to default to 1s instead of slight movement
	moveDirection[0] = floor(moveDirection[0] + 0.5)
	moveDirection[1] = floor(moveDirection[1] + 0.5)
	velocity = moveDirection.normalized()*speed
	#print('vel0', velocity[0], ' | vel1', velocity[1])
	animations.speed_scale = 1
	
	#print(direction)
	
	if Input.is_action_pressed("run") and (abs(velocity[0])>0 or abs(velocity[1]) > 0) and not inAnim:
		velocity = moveDirection.normalized()*speed*2
		animations.speed_scale = 2
		
	if Input.is_action_just_pressed("attack"):
		item.visible = true
		#item.disable()
		inAnim = true
		animations.play("swing_"+direction)
		await animations.animation_finished
		var magic = basicmagic.instantiate()
		add_child(magic)
		inAnim = false
		#item.monitorable = false
	
	#print("input vector: ", velocity)
	
	
func updateAnimation():
	if not inAnim:
		if velocity.length() == 0:
			animations.stop()
		else:
			direction = "down"
			if velocity.x < 0: direction = "left"
			elif velocity.x > 0: direction = "right"
			elif velocity.y < 0: direction = "up"
			
			animations.play("walk"+direction)
			
	
		#animations.speed_scale = 2
		#log("walk"+direction)


func check_death():
	if health <= 0:
		queue_free()

func knockback(enemyVel):
	var knockbackDirection = (enemyVel-velocity).normalized()*500
	velocity = knockbackDirection
	move_and_slide()

func _physics_process(delta):
	handleInput()
	move_and_slide()
	updateAnimation()
	check_death()

func _on_hurtbox_area_entered(area):
	#print('AREA: ', area.name)
	if area.name == "Hitbox_lv1":
		health = health -1
		knockback(area.get_parent().velocity)
		healthChanged.emit(health)
		#print('health', health)
	pass # Replace with function body.
