extends TextureButton

@onready var outposts = $".."
@onready var selection_sound = preload("res://sounds/invalid_selection_sound.wav")  # Invalid selection sound
@onready var highlight_texture = preload("res://Art/Highlighted.png")  # Texture for highlighting the outpost
@onready var normal_texture = preload("res://Art/normalTexture.png")  # Normal texture for outposts

@export var Village : int = 0
@export var NeighboringVillage1 : int = 0
@export var NeighboringVillage2 : int = 0
@export var NeighboringVillage3 : int = 0
@export var NeighboringVillage4 : int = 0
@export var NextToBase : bool = false

var selectable = 5
var friendly_outposts: Array = []
var is_selected = false  # Tracks if this outpost is selected
var can_be_selected = true  # Tracks if the outpost is selectable

# Called when the node enters the scene tree for the first time.
func _ready():
	# Hide all connection lines initially
	var outpost_children = outposts.get_children()
	for child in outpost_children:
		if child.name.begins_with("connection"):
			child.hide()
	# Initially, set the texture to normal
	self.texture_normal = normal_texture


# Set the friendly outposts from an external source
func set_friendly_outposts(friendly: Array):
	friendly_outposts = friendly


# Called when the button is pressed
func _on_pressed():
	# If the outpost is already selected, play invalid sound and return
	if is_selected:
		var player = AudioStreamPlayer.new()
		player.set_stream(selection_sound)  
		add_child(player)
		player.play()# Play invalid selection sound
		return  # Do nothing if already selected
	# Check if this outpost can be selected
	if not can_be_selected:
		var player = AudioStreamPlayer.new()
		player.set_stream(selection_sound)  
		add_child(player)
		player.play()# Play invalid selection sound
		return  # If it's not allowed, do nothing
	# Select the current outpost
	select_outpost()
	# Show friendly neighboring outposts
	var outpost_children = outposts.get_children()
	# Show only friendly-controlled neighboring outposts
	for neighbor in [NeighboringVillage1, NeighboringVillage2, NeighboringVillage3, NeighboringVillage4]:
		if neighbor in friendly_outposts:
			for child in outpost_children:
				if child.name == "%dDorf" % neighbor:
					child.show()
	# Reveal corresponding connection lines
	for neighbor in [NeighboringVillage1, NeighboringVillage2, NeighboringVillage3, NeighboringVillage4]:
		for child in outpost_children:
			if child.name == "connection%d%d" % [Village, neighbor]:
				child.show()


# Function to highlight the outpost and mark it as selected
func select_outpost():
	if Village <= selectable:
		is_selected = true
		self.texture_normal = highlight_texture  # Set highlighted texture
	# Disable higher-numbered outposts if this one is selected
	for i in range(Village + 1, 10):  # Assuming a total of 10 outposts, adjust if needed
		var higher_outpost = get_outpost_by_number(i)
		if higher_outpost and higher_outpost.is_selected:
			higher_outpost.deselect_outpost()  # Deselect higher-numbered outposts
	# Mark this outpost as selectable for future interactions
	(get_parent()).add_selected_outpost(self)


# Function to deselect the outpost and reset to normal state
func deselect_outpost():
	is_selected = false
	self.texture_normal = normal_texture  # Reset to normal texture
	# Mark the outpost as deselected in the parent node
	(get_parent()).remove_selected_outpost(self)  


# Function to get an outpost by its number
func get_outpost_by_number(number: int) -> TextureButton:
	# Iterate through outposts to find the one with the matching number
	for child in outposts.get_children():
		if child is TextureButton and child.Village == number:
			return child
	return null


# Function to enable or disable the selection of outposts
func enable_selection(enable: bool):
	# Enable or disable the selection based on the argument
	can_be_selected = enable
	self.disabled = not enable  # Disable button if can't be selected
