extends Node 



@onready var outposts = $".."

@export var Village : int = 0
@export var NeighboringVillage1 : int = 0
@export var NeighboringVillage2 : int = 0
@export var NeighboringVillage3 : int = 0
@export var NeighboringVillage4 : int = 0
@export var NextToBase : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# hide texture when load
	get_tree().current_scene.hide()
	# show texture when car button
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_button_pressed():
	var outpost_children = outposts.get_children()
	for child in outpost_children: # I am sorry my dear coding senpais
		if child.Village == NeighboringVillage1:
			child.draw()
		if child.Village == NeighboringVillage2:
			child.draw()
		if child.Village == NeighboringVillage3:
			child.draw()
		if child.Village == NeighboringVillage4:
			child.draw()
	pass # Replace with function body.
