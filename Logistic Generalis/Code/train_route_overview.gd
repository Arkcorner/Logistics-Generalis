extends Node2D

@onready var top = $Top/Top
@onready var middle = $Middle/Middle
@onready var bottom = $Bottom/Bottom
@onready var HighlightColor = Color(0.15,0.04,0.97,0.38)



func _draw():
	draw_colored_polygon(top.polygon, HighlightColor)
	draw_colored_polygon(middle.polygon, HighlightColor)
	draw_colored_polygon(bottom.polygon, HighlightColor)
