extends Node3D

const LOWER_BOUND = 0.5
const UPPER_BOUND = 5

@onready var tabletop = $Tabletop.find_children("*")
@onready var legs = $Legs.find_children("*")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(legs)
	print(tabletop)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var scale_factor = 1.001
	
	for leg: Node3D in legs:
		var leg_height = leg.scale.y
		leg.transform = leg.transform.scaled(Vector3(1, scale_factor, 1))
		leg.transform = leg.transform.translated(Vector3(0, abs(leg_height - leg.scale.y) / 2, 0))
		#print("-----")
		
	for top:Node3D in tabletop:
		top.transform = top.transform.translated()
	##print(delta * Vector3(0,1,0))
	#$Tabletop.transform = $Tabletop.transform.scaled_local(Vector3(1,1,1.5))
	#print($Tabletop.scale)
	
	
	#for node: Node3D in top:
		##print(node.transform.origin.y)
		##print(scale_factor - 1)
		#print(diff_y)
		#print("------")
		#node.transform = node.transform.translated_local(Vector3(0, diff_y, 0) * delta)
		#print(node.position.y)
	
		
	pass

func stretch(x, y, z) -> void:
	pass

func reset() -> void:
	pass
