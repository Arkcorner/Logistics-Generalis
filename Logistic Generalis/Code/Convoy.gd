extends Node2D

@export var speed: float = 100.0  # Speed of the convoy movement
var selected_outposts = []  # List of outposts to move through
var current_target_index = 0  # Index of the next outpost to move to
var is_moving = false  # Tracks if the convoy is currently moving

# Called when the convoy is deployed
func start_movement(outposts: Array):
	if outposts.size() < 2:
		print("Not enough outposts selected for movement!")
		return
	
	selected_outposts = outposts.duplicate()
	current_target_index = 0
	is_moving = true

	# Move towards the first outpost immediately
	move_to_next_outpost()

# Moves the convoy to the next outpost in the list
func move_to_next_outpost():
	if current_target_index >= selected_outposts.size():
		# Reached the final outpost, remove or hide the convoy
		queue_free()  # Destroys the convoy instance
		return

	var target_outpost = selected_outposts[current_target_index]
	if target_outpost:
		# Start moving toward the next outpost
		var target_position = target_outpost.global_position
		moveTo(target_position)

# Moves toward a given position
func moveTo(target_position: Vector2):
	var direction = (target_position - global_position).normalized()
	var distance = global_position.distance_to(target_position)

	if distance > 5:  # A small threshold to prevent over-moving
		global_position += direction * speed * get_process_delta_time()
	else:
		# Arrived at the target outpost
		current_target_index += 1
		move_to_next_outpost()

# Called every frame
func _process(delta):
	if is_moving and current_target_index < selected_outposts.size():
		moveTo(selected_outposts[current_target_index].global_position)
