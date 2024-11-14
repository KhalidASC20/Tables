extends Area3D


#@onready var win_scene: Label = $Label
@onready var win_scene = preload("res://scenes//Menus//win_scene.tscn")

#@onready var win_scene: Control = $platform_table/StaticTable17/Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Replace with function body.
	if not is_in_group('win_platform'):
		add_to_group("win_platform")
		print("Win_floor is ready")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_win_platform_body_entered(body: Node3D) -> void:
	# Replace with function body.
	if body.is_in_group("player") and is_in_group("win_platform"):
		print("YOU WIN")
		show_win_scene()

		
func show_win_scene():
		var win_screen = win_scene.instantiate()
		get_tree().root.add_child(win_screen)
		win_screen.visible = true	
	
