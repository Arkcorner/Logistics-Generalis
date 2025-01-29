extends Node2D


class_name Province

@export var province_number: int = 0
var neighbors: Array = [] 
var enemy_neighbors: Array = []
var friendly_neighbors: Array = []
var icon_instance
@export var province_name: int = 1
@export var supply_level: int = 100
@export var defense_power: int = 50
@export var attack_power: int = 50
@export var is_enemy: bool = false

@onready var defense_icon = preload("res://Scenes/defense_icon.tscn") 
@onready var attack_icon = preload("res://Scenes/attack_icon.tscn")   

var tile_map: TileMap 
var attack_targets: Array = [] 
var active_icons: Array = [] 


func receive_supplies(amount: int):
	supply_level += amount
	update_stats()

func update_stats():
	defense_power = supply_level * 0.8
	attack_power = supply_level * 0.5

func perform_attacks():
	for target in attack_targets:
		attack(target)
	attack_targets.clear() 

func attack(target: Province):
	if attack_power > target.defense_power:
		print(province_name, "conquers", target.province_name)
		target.is_enemy = is_enemy
		target.receive_supplies(-20)
		change_tile_map(target.global_position, "enemy" if is_enemy else "friendly") # Update the TileMap
		target.find_neighbors() # Recalculate neighbors for the conquered province
		find_neighbors() # Recalculate neighbors for this province as well
	else:
		print(province_name, "failed to conquer", target.province_name)

# Remove all active icons if neighboring provinces are no longer enemies
func clear_icons():
	for icon in active_icons:
		if icon and icon.is_inside_tree():
			icon.queue_free() # Remove the icon from the scene
	active_icons.clear() # Clear the list of active icons

# Check neighboring provinces and display icons
func check_neighboring_provinces():
	attack_targets.clear() # Clear previous attack targets
	for neighbor in neighbors:
		if neighbor.is_enemy != is_enemy: # Opposing provinces only
			if attack_power > neighbor.defense_power:
				display_attack_icon(neighbor)
				attack_targets.append(neighbor) # Remember this province for an attack
			elif neighbor.attack_power >= defense_power:
				display_defense_icon(neighbor)

# Display an attack icon on the attacking province
func display_attack_icon(target: Province):
	var icon_instance = attack_icon.instantiate()
	icon_instance.position = position.lerp(target.position, 0.5) # Position icon between provinces
	get_parent().add_child(icon_instance)
	active_icons.append(icon_instance) # Track the icon for future removal

# Display a defense icon between provinces
func display_defense_icon(target: Province):
	var icon_instance = defense_icon.instantiate()
	icon_instance.position = position.lerp(target.position, 0.5) # Position icon between provinces
	get_parent().add_child(icon_instance)
	active_icons.append(icon_instance) # Track the icon for future removal

# Find neighbors as before
func find_neighbors():
	var provinces_parent = get_parent()
	neighbors.clear()

	var potential_neighbors = [
		province_number + 1,
		province_number - 1,
		province_number + 6,
		province_number - 6
	]

	for neighbor_num in potential_neighbors:
		if neighbor_num >= 1 and neighbor_num <= 72: # Valid province range
			if neighbor_num == province_number + 1 and (province_number % 6 == 0):
				continue
			if neighbor_num == province_number - 1 and (province_number % 6 == 1):
				continue

			var neighbor_node = provinces_parent.get_node_or_null("Province" + str(neighbor_num))
			if neighbor_node:
				neighbors.append(neighbor_node)

	categorize_neighbors()

# Categorize neighbors into allies and enemies
func categorize_neighbors():
	enemy_neighbors.clear()
	friendly_neighbors.clear()

	for neighbor in neighbors:
		if neighbor.is_enemy != is_enemy:
			enemy_neighbors.append(neighbor)
		else:
			friendly_neighbors.append(neighbor)

# Change the tile on the TileMap after a successful attack
func change_tile_map(province_position: Vector2, tile_type: String):
	if tile_map:
		var tile: Vector2 = tile_map.local_to_map(province_position)
		match tile_type:
			"friendly":
				tile_map.set_cell(0, tile, 1, Vector2i(0,0)) # Use tile ID 1 for friendly tiles
			"enemy":
				tile_map.set_cell(0, tile, 0, Vector2i(1,1)) # Use tile ID 2 for enemy tiles

# Debugging function
func print_neighbors():
	print("Province", province_number, "Neighbors:", neighbors)
	print("  Allies:", friendly_neighbors)
	print("  Enemies:", enemy_neighbors)
