extends Node
var x : int = 1

func _ready():
	# Iterate through all child nodes and find their neighbors
	print("notice me senpai") # happens twoice
	for child in get_children():
		if child is Province:
			x += 1
			child.province_number = x
			print(child.province_number)
			#child.find_neighbors()
			#child.print_neighbors()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
