extends Node


func _ready():
	# Iterate through all child nodes and find their neighbors
	for child in get_children():
		if child is Province:
			child.find_neighbors()
			child.print_neighbors()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
