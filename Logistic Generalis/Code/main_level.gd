extends Node2D

@onready var CaroverView = preload("res://Scenes/outpostOverview.tscn")
@onready var TrainoverView = preload("res://Scenes/train_route_overview.tscn")
@onready var tile_map = $TileMap
@onready var medical_label = $MedicalLabel
@onready var ammo_label = $AmmoLabel
@onready var gun_label = $GunLabel
@onready var fuel_label = $FuelLabel
@onready var ProvinceList = $Provinces.get_children()
@onready var loss = $Loss
@onready var turn_count = $TurnCount

var supplycount = 100
var tunCount = 0
var CarView
var TrainView
var overviewActive = false
var CaroverviewActive = false
var turn = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	for province in ProvinceList:
		province.tile_map = tile_map
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()  # Quits the game
	pass


func _on_car_button_pressed():
	if CaroverviewActive:
		CaroverviewActive = false
		if CarView != null:
			CarView.queue_free()
	else:
		CarView = CaroverView.instantiate()
		add_child(CarView)
		CaroverviewActive = true
	pass # Replace with function body.


func _on_train_button_pressed():
	if overviewActive:
		TrainView.queue_free()
		overviewActive = false
	else:
		TrainView = TrainoverView.instantiate()
		add_child(TrainView)
		overviewActive = true
	pass # Replace with function body.

func _loss(): get_tree().change_scene_to_file("res://Scenes/end_screen.tscn")

func _on_end_turn_button_pressed():
	tunCount += 1
	turn_count.set_text("Current Turn: %d" %tunCount)
	if supplycount >= 1000:
		supplycount -= 10
	for province in ProvinceList:
		province.perform_attacks()
		province.clear_icons()
		province.check_neighboring_provinces()
		if province.is_enemy == true:
			province.receive_supplies(+50)
	medical_label.set_text(str(supplycount))
	ammo_label.set_text(str(supplycount))
	gun_label.set_text(str(supplycount))
	fuel_label.set_text(str(supplycount))
	pass # Replace with function body.


func _on_medical_sups_pressed():
	pass # Replace with function body.


func _on_ammo_sups_pressed():
	pass # Replace with function body.


func _on_gun_sups_pressed():
	pass # Replace with function body.


func _on_fuel_sups_pressed():
	pass # Replace with function body.
