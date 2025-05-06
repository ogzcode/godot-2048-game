extends RigidBody2D

@onready var color_rect: ColorRect = $ColorRect
@onready var label: Label = $Label

var default_value: int = 2048

var colors: Dictionary = {
	2: Color("red"),
	4: Color("lightsalmon"),
	8: Color("lightcoral"),
	16: Color("deeppink"),
	32: Color("gold"),
	64: Color("orange"),
	128: Color("orangered"),
	256: Color("tomato"),
	512: Color("firebrick"),
	1024: Color("darkred"),
	2048: Color("black")
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_default_value(default_value)

func set_default_value(new_value: int):
	default_value = new_value
	
	if label:
		label.text = str(default_value)
	_update_colors()

func _update_colors():
	if colors.has(default_value):
		if color_rect:
			color_rect.color = colors[default_value]
			
func _process(delta: float) -> void:
	pass
