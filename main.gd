extends Node2D

var column_position = []
var column_width: int = 100
var fallout_block_scene = preload("res://falling-block.tscn")
var current_falling_bloc: Node2D = null

func _ready() -> void:
	for i in range(1,6):
		var column_node = get_node("Column-" + str(i))
		column_position.append(column_node.position)
	_spawn_new_block()
	
func _spawn_new_block() -> void:
	var random_column_index = randi_range(0, column_position.size - 1)
	
	
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_position = event.position
		var column_index = floor(mouse_position.x / column_width)
