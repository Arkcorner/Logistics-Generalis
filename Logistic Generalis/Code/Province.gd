extends Node2D


class_name Province

@export var province_number: int = 0
var neighbors: Array = [] # Neighboring provinces
var enemy_neighbors: Array = [] # Enemies among neighbors
var friendly_neighbors: Array = [] # Allies among neighbors
@export var province_name: int = 1
@export var supply_level: int = 100
@export var defense_power: int = 50
@export var attack_power: int = 50
@export var is_enemy: bool = false

func receive_supplies(amount: int):
	supply_level += amount
	update_stats()

func update_stats():
	# Increase defense/attack based on supplies
	defense_power = supply_level * 0.8
	attack_power = supply_level * 0.5

func attack(target: Province):
	if attack_power > target.defense_power:
		print(province_name)
		print(" conquers ") 
		print(target.province_name)
		print(supply_level)
		target.is_enemy = false
	else:
		print(province_name)
		print(" failed to conquer ") 
		print(target.province_name)

func Checkneighboringprovinces():
	get_tree()
	pass

func find_neighbors():
	"""
	Find and store neighboring provinces based on the rules:
	+1, -1, +6, -6 as long as the province number stays within valid bounds.
	"""
	var provinces_parent = get_parent() # Assuming all provinces are under the same parent
	neighbors.clear()
	
	var potential_neighbors = [
		province_number + 1,
		province_number - 1,
		province_number + 6,
		province_number - 6
	]
	
	# Check each potential neighbor and see if it's valid
	for neighbor_num in potential_neighbors:
		if neighbor_num >= 1 and neighbor_num <= 72: # Valid province range
			# Ensure no wrapping around rows (e.g., 6 and 7 are not neighbors)
			if neighbor_num == province_number + 1 and (province_number % 6 == 0):
				continue # Skip wrapping right
			if neighbor_num == province_number - 1 and (province_number % 6 == 1):
				continue # Skip wrapping left
			
			# Get the neighbor node and add to the list
			var neighbor_node = provinces_parent.get_node_or_null("Province" + str(neighbor_num))
			if neighbor_node:
				neighbors.append(neighbor_node)

	# Categorize neighbors into allies or enemies
	categorize_neighbors()

func categorize_neighbors():
	"""
	Categorize neighbors into allies or enemies based on their `is_enemy` status.
	"""
	enemy_neighbors.clear()
	friendly_neighbors.clear()
	
	for neighbor in neighbors:
		if neighbor.is_enemy != is_enemy:
			enemy_neighbors.append(neighbor)
		else:
			friendly_neighbors.append(neighbor)

func print_neighbors():
	"""
	Debugging function to print neighbors, enemies, and allies.
	"""
	print("Province", province_number, "Neighbors:", neighbors)
	print("  Allies:", friendly_neighbors)
	print("  Enemies:", enemy_neighbors)
