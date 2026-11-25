extends Node
class_name DialogueManager

var DIALOGUE_SCEEN := preload("res://Scenes/text_demo.tscn")


signal message_requested()
signal message_completed()
signal finished()

var opacity_tween: Tween
var _messages := []
var _active_dialogue_offset := 0
var _is_active := false
var cur_dialogue_instance: Dialogue

func _input(event: InputEvent) -> void:
	if(
		event.is_pressed() and 
		!event.is_echo() and
		event is InputEventKey and event.keycode == KEY_ENTER or KEY_SPACE and 
		_is_active and cur_dialogue_instance.message_is_fully_visible()
	):
		if _active_dialogue_offset < _messages.size() - 1:
			_active_dialogue_offset += 1
			_show_current()
		else:
			_hide()

func show_message(message_list: Array, position: Vector2) -> void:
	if _is_active:
		return 
	_is_active = true
	
	_messages = message_list
	_active_dialogue_offset = 0
	
	var _dialogue: Dialogue = DIALOGUE_SCEEN.instantiate()
	_dialogue.message_completed.connect(_on_message_completed)
	get_tree().root.add_child(_dialogue)
	
	cur_dialogue_instance = _dialogue
	cur_dialogue_instance.position = position
	
	_show_current()
	
func _show_current() -> void:
		message_requested.emit()
		var _msg := _messages[_active_dialogue_offset] as String
		cur_dialogue_instance.update_message(_msg)

func _hide() -> void:
	cur_dialogue_instance.message_completed.disconnect(_on_message_completed)
	cur_dialogue_instance.queue_free()
	cur_dialogue_instance = null
	_is_active = false
	finished.emit()
	
	
func _fade_dialogue(target_aplha: float, duration: float = 0.3) -> void:
	if opacity_tween and opacity_tween.is_valid():
		opacity_tween.kill()
		
	opacity_tween = create_tween()
	opacity_tween.tween_property(cur_dialogue_instance, "modulate:a", target_aplha, duration)

func _on_message_completed() -> void:
	message_completed.emit()
