class_name DialogueStreamPlayer
extends AudioStreamPlayer


var _random_number_gen := RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_random_number_gen.randomize()

func play_randomized(from_position := 0.0) -> void:
	pitch_scale = _random_number_gen.randf_range(0.95, 1.08)
	super.play(from_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
