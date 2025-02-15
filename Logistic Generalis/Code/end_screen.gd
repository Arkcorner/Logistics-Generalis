extends Node2D

@onready var Story = $Label
@onready var Thanks = $Label2

# Called when the node enters the scene tree for the first time.
func _ready():
	var newtween = get_tree().create_tween()
	newtween.tween_property($Label2, "modulate:a", 0, 0.1).set_trans(Tween.TRANS_SINE)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var tween = get_tree().create_tween()
	tween.tween_property($Label, "modulate:a", 0, 1).set_trans(Tween.TRANS_SINE)
	tween.tween_callback($Label.queue_free)
	pass # Replace with function body.


func _on_timer_2_timeout():
	var newtween = get_tree().create_tween()
	newtween.tween_property($Label2, "modulate:a", 1, 1).set_trans(Tween.TRANS_SINE)
	pass # Replace with function body.
