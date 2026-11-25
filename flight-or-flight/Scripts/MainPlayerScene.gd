extends Node

@onready var text_model = $TextModel
@onready var dialogue_manager = $DialogueManager
@onready var dialogue_pos = $DialoguePosition


func _ready() -> void:
	text_model.interacted.connect(_on_text_model_interacted)


func _on_text_model_interacted() -> void:
	dialogue_manager.show_message(
		["Hello World.", "This is a test message"],
		dialogue_pos.global_position
	)
