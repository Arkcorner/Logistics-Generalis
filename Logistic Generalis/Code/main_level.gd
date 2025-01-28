extends Node2D

@onready var CaroverView = preload("res://Scenes/carOverview.tscn")
@onready var TrainoverView = preload("res://Scenes/train_route_overview.tscn")
@onready var tile_map = $TileMap

var CarView
var TrainView
var overviewActive = false
var CaroverviewActive = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("mb_left"):
		var tile: Vector2 = tile_map.local_to_map(get_global_mouse_position())
		tile_map.set_cell(0,tile,0)
	pass


func _on_car_button_pressed():
	if CaroverviewActive:
		CarView.queue_free()
		CaroverviewActive = false
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




func _on_end_turn_button_pressed():
	
	pass # Replace with function body.
