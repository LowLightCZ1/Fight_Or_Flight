class_name PauseCalculator
extends Node

const PAUSE_PATTERN := "({p=\\d([.]\\d+)?[}])"
var _pause_regex := RegEx.new()
var _pauses := []



func _ready() -> void:
	_pause_regex.compile(PAUSE_PATTERN)

func extract_pause_from_string(source_string: String) -> String:
	_pauses = []
	_find_pause(source_string)
	return _extract_tags(source_string)

func _find_pause(from_string: String) -> void:
	var _found_pauses := _pause_regex.search_all(from_string)
	for _result in _found_pauses:
		var _tag_string := _result.get_string() as String
		var _tag_position := _result.get_start() as int
		
		var _pause = Pause.new(_tag_position, _tag_string)
		_pauses.append(_pause)
	
func _extract_tags(from_string: String) -> String:
	var _custom_regex = RegEx.new()
	_custom_regex.compile("({(.*?)})")
	return _custom_regex.sub(from_string, "", true)
	
