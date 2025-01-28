extends Area2D

@onready var low_route = $"Low Route"
@onready var HighlightColor = Color(0.15,0.04,0.97,0.38)

# Called when the node enters the scene tree for the first time.
func _draw():
	draw_colored_polygon(low_route.polygon, HighlightColor)
