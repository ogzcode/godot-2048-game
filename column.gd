extends Area2D

signal column_clicked(column_index: int)
@export var column_index = 0

func _ready() -> void:
	input_event.connect(_on_input_event)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			column_clicked.emit(column_index)
		
