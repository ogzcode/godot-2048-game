extends RigidBody2D

@export var value: int = 2
signal block_landed

func _ready() -> void:
	$Label.text = str(value)
	
	update_block_color()
	
	sleeping_state_changed.connect(_on_sleeping_state_changed)

func update_block_color():
	match value:
		2: $Sprite2D.modulate = Color("e0f7fa")
		4: $Sprite2D.modulate = Color("b2ebf2")
		8: $Sprite2D.modulate = Color("80deea")
		16: $Sprite2D.modulate = Color("4dd0e1")
		32: $Sprite2D.modulate = Color("00bcd4")
		64: $Sprite2D.modulate = Color("00acc1")
		128: $Sprite2D.modulate = Color("0097a7")
		256: $Sprite2D.modulate = Color("00838f")
		512: $Sprite2D.modulate = Color("006064")
		1024: $Sprite2D.modulate = Color("263238")
		_: $Sprite2D.modulate = Color("ffffff")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_sleeping_state_changed():
	if sleeping:
		block_landed.emit()
