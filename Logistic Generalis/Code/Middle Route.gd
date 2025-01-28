extends Area2D

@onready var middle_route = $"Middle Route"
@onready var HighlightColor = Color(0.15,0.04,0.97,0.38)

func _draw():
	draw_colored_polygon(middle_route.polygon, HighlightColor)
