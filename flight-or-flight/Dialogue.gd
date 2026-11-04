class_name Dialogue
extends Control


@onready var content := get_node("Content") as RichTextLabel
@onready var type_timer := get_node("TypeTyper") as Timer
@onready var pause_timer := get_node("PauseTimer") as Timer

@onready var voice_player := get_node("DialogueStreamPlayer") as AudioStreamPlayer
var _playing_voice := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	update_message("Hello World. This is my first text in this demo.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update_message(message: String) -> void:
	content.text = message
	content.visible_characters = 0
	type_timer.start()
	_playing_voice = true
	voice_player.play(0)
	

func _on_type_typer_timeout() -> void:
	#print(content.visible_characters, " / ", content.get_total_character_count())
	if content.visible_characters < content.text.length():
		content.visible_characters += 1
	else:
		type_timer.stop()
		_playing_voice = false
		voice_player.stop()



func _on_dialogue_stream_player_finished() -> void:
		if _playing_voice:
			voice_player.play(0)
