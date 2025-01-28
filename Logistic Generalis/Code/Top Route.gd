extends Area2D

@onready var top_route = $"TopRoute"
@onready var HighlightColor = Color(0.15,0.04,0.97,0.38)

func _draw():
	draw_colored_polygon(top_route.polygon, HighlightColor)
