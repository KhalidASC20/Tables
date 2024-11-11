extends Node3D
@onready var stretcher: AnimationPlayer = $AnimationPlayer

var stretched: bool = false
var last_played: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func stretch(axis) -> void:
	if stretcher.is_playing():
		return
	
	if stretched:
		stretcher.play_backwards(last_played)
		stretched = false
	else:
		match axis:
			"x":
				last_played = "stretch_x"
			"y":
				last_played = "stretch_y"
			"z":
				last_played = "stretch_z"
		
		stretched = true
		stretcher.play(last_played)

	stretcher.advance(0)
	
