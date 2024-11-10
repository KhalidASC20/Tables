extends Node3D
@onready var stretcher: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stretch("z")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print($Tabletop.global_position)
	print($Tabletop/StaticPin.global_position)
	print(stretcher.is_playing())
	print("-------")
	pass

func stretch(axis) -> void:
	if axis == "x":
		stretcher.play("stretch_x")
		stretcher.advance(0)
		return
	elif axis == "y":
		stretcher.play("stretch_y")
		stretcher.advance(0)
		return
	elif axis == "z":
		stretcher.play("stretch_z")
		stretcher.advance(0)
		return

func reset() -> void:
	pass
