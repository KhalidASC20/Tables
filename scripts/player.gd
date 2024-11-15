extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
#mouse
var sensitivity = 0.5
var min_angle = -80
var max_angle = 90
#pickup
var picked_obj
var pull_power = 4
var rotation_power = 3
var locked = false
#scroll picked object
var scroll_sensitivity := 0.5

#min and max distance for scroll
var min_scroll_distance:= 2.0
var max_scroll_distance:= 10.0

#reference to head
@onready var head: Node3D = $Head
@onready var interact_ray: RayCast3D = $Head/Camera3D/interact_ray
@onready var hand: Marker3D = $Head/Camera3D/hand
#hand stuff
@onready var joint: Generic6DOFJoint3D = $Head/Camera3D/Generic6DOFJoint3D
@onready var staticbody: StaticBody3D = $Head/Camera3D/StaticBody3D

var distance := 5.0
var look_rot : Vector2

const INTERAC_TABLE = "Tabletop"

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func rotate_head(event):
	if event is InputEventMouseMotion:
		look_rot.y -= (event.relative.x * sensitivity)
		look_rot.x -= (event.relative.y * sensitivity)
		look_rot.x = clamp(look_rot.x, min_angle, max_angle)
		
func rotate_obj(event):
	if picked_obj != null:
		if event is InputEventMouseMotion:
			#create rotation based on the mouse
			var mouse_delta = Vector2(event.relative.x, event.relative.y) * rotation_power
			var axis = Vector3(0,1,0)
			staticbody.rotate_x(deg_to_rad(event.relative.y * rotation_power))
			staticbody.rotate_y(deg_to_rad(event.relative.x * rotation_power))

func interact_obj():
	var collider = interact_ray.get_collider()
	if collider != null and collider.is_in_group("pickups"):
		print("PICKED UP")
		picked_obj = collider
		joint.set_node_b(picked_obj.get_path())
		#picked_obj.set_collision_mask_value(2, false)
		#picked_obj.set_collision_mask_value(1, false)
	#check if object is part of a parent obejct
		#var parent_node = collider.get_parent()
		#if parent_node.is_in_group("pickups"):
			#picked_obj = parent_node
			#joint.set_node_b(picked_obj.get_path())
		
func remove_obj():
	if picked_obj != null:
		#picked_obj.set_collision_mask_value(2, true)
		#picked_obj.set_collision_mask_value(1, false)
		picked_obj = null
		joint.set_node_b(joint.get_path())
		


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	

	move_and_slide()
	
	head.rotation_degrees.x = look_rot.x
	rotation_degrees.y = look_rot.y
	
	#place obj in hand
	if picked_obj != null:
		var a = picked_obj.global_transform.origin
		var b = hand.global_transform.origin
		if picked_obj is RigidBody3D:
			picked_obj.set_linear_velocity((b-a)*pull_power)
		elif picked_obj is Node3D:
			picked_obj.global_transform.origin = b
		
func _input(event):
	if !locked:
		rotate_head(event)
	if Input.is_action_pressed("Lmouse") and picked_obj != null:
		locked = true
		rotate_obj(event)
	if Input.is_action_just_released("Lmouse"):
		locked = false
		
	if Input.is_action_just_pressed("pickup"):
		if picked_obj == null:
			interact_obj()
		elif picked_obj != null:
			remove_obj()
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			#move object further
			joint.translate_object_local(Vector3(0,0,1))
			joint.translate_object_local(Vector3(0,0,1))
			staticbody.translate(Vector3(0,0,1))
			print("IM GETTING FURTHER")
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			#move object closer
			#picked_obj = scroll_sensitivity
			print("GET OVER HERE")
	if picked_obj:
		_update_object_position()
		

		
	
	if picked_obj and picked_obj.get_name() == INTERAC_TABLE:
		if Input.is_action_just_pressed("stretch_x"):
			picked_obj.get_parent().stretch("x")
		if Input.is_action_just_pressed("stretch_y"):
			picked_obj.get_parent().stretch("y")
		if Input.is_action_just_pressed("stretch_z"):
			picked_obj.get_parent().stretch("z")
			
	if Input.is_action_just_pressed("quit"):
		self.get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
		self.get_tree().quit()
		
func _update_object_position():
	var forward_direction = -global_transform.basis.z
	var new_position = global_transform.origin + forward_direction * distance
		
	picked_obj.global_transform.origin = new_position
	joint.global_transform.origin = new_position
	staticbody.global_transform.origin = new_position
