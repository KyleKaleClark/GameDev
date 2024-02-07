extends Area2D

@onready var Frog = get_parent()

@onready var animations = $Sprite2D/AnimationPlayer
# Called when the node enters the scene tree for the first time.

@export var damage = 2
func get_damage():
	return damage
	
	
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#velocity = Frog.direction*200
	position.x += 1
	updateAnimation()
	pass


func updateAnimation():
	animations.play('loop')
	pass
	


func _on_area_entered(area):
	queue_free()
