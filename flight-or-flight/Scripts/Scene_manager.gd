extends Node

# Zásobník (historie) navštívených scén
var history: Array[String] = []

# Funkce pro bezpečné přepnutí scény se zapamatováním historie
func change_scene(target_path: String) -> void:
	# Uložíme aktuální scénu do historie předtím, než odejdeme
	var current_scene = get_tree().current_scene.scene_file_path
	if current_scene and current_scene != target_path:
		history.append(current_scene)
	
	get_tree().change_scene_to_file(target_path)

# Funkce pro návrat o krok zpět
func go_back() -> void:
	if history.size() > 0:
		var previous_scene = history.pop_back()
		get_tree().change_scene_to_file(previous_scene)
	else:
		# Pojistka, kdyby historie byla prázdná (vrátí do hlavního menu)
		get_tree().change_scene_to_file("res://Scenes/Main_menu.tscn")
