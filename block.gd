extends CharacterBody2D

signal block_landed
@export var value: int = 2
@export var falling_speed = 200

func _ready() -> void:
	$Label.text = str(value)
	update_block_color()

func update_block_color():
	match value:
		2: $Sprite2D.texture = load("res://assets/blue.png")
		4: $Sprite2D.texture = load("res://assets/green.png")
		8: $Sprite2D.texture = load("res://assets/grey.png")
		16: $Sprite2D.texture = load("res://assets/purple.png")
		32: $Sprite2D.texture = load("res://assets/red.png")
		64: $Sprite2D.texture = load("res://assets/yellow.png")

func _process(delta: float) -> void:
	velocity.y = falling_speed
	
	move_and_slide()
	
	if is_on_floor():
		block_landed.emit()
		set_physics_process(false)
		velocity = Vector2.ZERO
