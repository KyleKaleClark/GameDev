extends Node2D

@onready var FrogheartsContainer = $GUI/FrogHeartsContainer
@onready var RabbitheartContainer = $GUI/RabbitHeartContainer

@onready var Rabbit = $Rabbit
@onready var Frog = $Frog
# Called when the node enters the scene tree for the first time.
func _ready():
	FrogheartsContainer.setMaxHearts(Frog.maxhealth)
	RabbitheartContainer.setMaxHearts(Rabbit.maxhealth)
	
	RabbitheartContainer.updateHearts(Rabbit.health)
	FrogheartsContainer.updateHearts(Frog.health)
	
	Rabbit.healthChanged.connect(RabbitheartContainer.updateHearts)
	Frog.healthChanged.connect(FrogheartsContainer.updateHearts)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
