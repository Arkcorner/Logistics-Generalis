extends Node2D


@onready var all_outposts = $".".get_children() 
var selected_outposts = []  # Tracks the selected outposts

# Called when an outpost is selected
func add_selected_outpost(outpost: TextureButton):
	selected_outposts.append(outpost)

func send_convoy():
	var convoy_scene = preload("res://Scenes/Convoy.tscn" ) # Replace with the actual path
	var convoy_instance = convoy_scene.instantiate()
	get_parent().add_child(convoy_instance)  # Add convoy to the scene
	convoy_instance.global_position = selected_outposts[0].global_position  # Start at the first outpost
	convoy_instance.start_movement(selected_outposts)  # Move through selected outposts

# Called when an outpost is deselected
func remove_selected_outpost(outpost: TextureButton):
	selected_outposts.erase(outpost)

# Validate outpost selections
func validate_selections():
	# Check if the selected outposts are valid (neighboring outposts only)
	for i in range(1, len(selected_outposts)):
		var prev_outpost = selected_outposts[i - 1]
		var current_outpost = selected_outposts[i]

		if not are_neighbors(prev_outpost, current_outpost):
			# If they are not neighbors, deselect the current outpost
			current_outpost.deselect_outpost()
			selected_outposts.erase(current_outpost)
			print("Outposts are not neighbors, deselecting %s" % current_outpost.name)

# Function to check if two outposts are neighbors
func are_neighbors(outpost1: TextureButton, outpost2: TextureButton) -> bool:
	# Check if the two outposts have neighboring relationships
	var neighbors = [outpost1.NeighboringVillage1, outpost1.NeighboringVillage2, outpost1.NeighboringVillage3, outpost1.NeighboringVillage4]
	return outpost2.Village in neighbors
