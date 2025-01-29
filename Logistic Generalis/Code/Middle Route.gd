extends Area2D

@onready var middle_route = $"Middle Route"
@onready var HighlightColor = Color(0.48,0.96,0.259,0.38)

func _draw():
	draw_colored_polygon(middle_route.polygon, HighlightColor)
