extends Area2D

signal interacted

var player_in_range := false

@onready var label : Label = $Label


func _ready() -> void:
	label.hide()



func _unhandled_input(event: InputEvent) -> void:
	if player_in_range and event.is_action_pressed("interact"):
		interacted.emit()
		get_viewport().set_input_as_handled()


func _on_area_entered(area: Area2D) -> void:
	print("area entered: ", area.name, " groups: ", area.get_groups())
	if area.is_in_group("player"):
		player_in_range = true
		label.show()


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		player_in_range = false	
		label.hide()
