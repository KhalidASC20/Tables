extends Control

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_controls_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Menus/controls_scene.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
