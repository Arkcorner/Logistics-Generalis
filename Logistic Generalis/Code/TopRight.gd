extends Area2D

@onready var top_right = $"Top Right"
@onready var HighlightColor = Color(0.96,0.259,0.34,0.38)
# Called when the node enters the scene tree for the first time.

func _draw():
	draw_colored_polygon(top_right.polygon, HighlightColor)
