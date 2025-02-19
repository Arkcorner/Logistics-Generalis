extends Node

func _ready():
	launch_renpy_vn()  

# Function to launch the Ren'Py visual novel
func launch_renpy_vn():
	var renpy_path = "C:/Users/ASid-kun/Desktop/Uni Stuff/Logistics Generalis/Logistics-Generalis/Logistic Generalis/VN/LG/LogisticsGeneralis.exe"
	var arguments = []  # No arguments passed to Ren'Py for now
	var blocking = true  # Block until the Ren'Py game finishes

	# Execute the Ren'Py game and wait for it to finish
	var result = OS.execute(renpy_path, arguments, blocking)

	if result == OK:
		print("Ren'Py visual novel finished.")
		# Transition to the main game or the next scene in your game
		get_tree().change_scene("res://main_level.tscn")  # Update with the correct scene path
	else:
		print("Failed to launch Ren'Py visual novel.")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass  # Not necessary unless you need to update something each frame
