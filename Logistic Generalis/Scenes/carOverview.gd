extends Node2D

@onready var top_route_2 = $"Top Route2"
@onready var middle_route = $"Middle Route"
@onready var top_route_3 = $"Top Route3"
@onready var top_route = $"Top Route"



func hideOtherRoutes():
	top_route.hide()
	top_route_3.hide()
