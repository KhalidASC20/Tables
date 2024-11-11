extends Area3D


#@onready var win_scene: Label = $Label
@onready var win_scene: Control = $platform_table/StaticTable17/Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Replace with function body.
	if win_scene:
		win_scene.visible = false
	else:
		print("ERROR")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_win_platform_body_entered(body: Node3D) -> void:
	# Replace with function body.
	if body.is_in_group("player"):
		#var win_screen = win_scene.instantiate()
		win_scene.visible = true
		#get_tree().root.add_child(win_screen)
