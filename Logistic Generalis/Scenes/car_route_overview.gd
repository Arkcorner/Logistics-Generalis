extends Node2D

@onready var top_route = $"Top Route/TopRoute"
@onready var middle_route = $"Middle Route/Middle Route"
@onready var low_route = $"Top Route2/Low Route"
@onready var top_right = $"Top Route3/Top Right"
@onready var HighlightColor = Color(0.15,0.04,0.97,0.38)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	draw_colored_polygon(top_route.polygon, HighlightColor)
	draw_colored_polygon(middle_route.polygon, HighlightColor)
	draw_colored_polygon(low_route.polygon, HighlightColor)
	draw_colored_polygon(top_right.polygon, HighlightColor)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
