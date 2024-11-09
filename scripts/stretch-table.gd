extends Node3D

const LOWER_BOUND = 0.5
const UPPER_BOUND = 5

@onready var top = self.find_children("TableTop*") + [$StaticPin]
@onready var legs = self.find_children("Leg*")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(legs)
	print(top)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for leg in legs:
		leg.transform = leg.transform.scaled(Vector3(1, 1.001, 1))
	for node in top:
		node.transform = node.transform
		
		
	pass

func stretch(x, y, z) -> void:
	pass

func reset() -> void:
	pass
