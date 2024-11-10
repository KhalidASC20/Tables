extends RayCast3D
var obj =null
#@onready var point = $"../hold"
@onready var prompt = $prompt
#@onready var hold: Node3D = $"../../hold"


func _physics_process(_delta):
	prompt.text = ""
	
	if is_colliding():
		var collider = get_collider()
		
		if collider is Interactable:
			prompt.text = collider.prompt_message

	
