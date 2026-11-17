extends Button

# Původní cílové měřítko pro hover (můžeš si upravit, např. 1.2)
var hover_scale: Vector2 = Vector2(1.15, 1.15)
var normal_scale: Vector2 = Vector2(1.0, 1.0)

func _ready() -> void:
	# Propojení signálů pro myš a pro stisknutí tlačítka
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)

func _on_mouse_entered() -> void:
	pivot_offset = size / 2
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "scale", hover_scale, 0.1)

func _on_mouse_exited() -> void:
	pivot_offset = size / 2
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "scale", normal_scale, 0.1)

func _on_pressed() -> void:
	pivot_offset = size / 2
	# Efekt stisknutí: Rychle se zmenší (zmáčkne se) a hned zase skočí zpět na hover/normal velikost
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0.9, 0.9), 0.05)
	tween.tween_property(self, "scale", hover_scale, 0.08)
