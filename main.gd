extends Node2D

@onready var block_scene = preload("res://block.tscn")

var columns_group = []
var current_block: RigidBody2D = null
var current_column_index: int = 0
var is_control_block_active: bool = false
var game_grid: Array[Array] = []

func _ready() -> void:
	columns_group = get_tree().get_nodes_in_group("columns")
	
	for i in range(columns_group.size()):
		game_grid.append([])
	
	for col in columns_group:
		if col is Area2D and col.has_signal("column_clicked"):
			col.column_clicked.connect(_on_column_clicked)
	
	spawn_random_block()
	
func _on_column_clicked(index: int):
	if current_block != null && is_control_block_active:
		var target_column = columns_group[index]
		current_block.global_position.x = target_column.global_position.x + 45
		current_block.linear_velocity = Vector2.ZERO
		current_block.angular_velocity = 0.0
		current_block.freeze = false
	
func spawn_random_block():
	if is_control_block_active:
		print("Yeni block oluşturulamadı", is_control_block_active)
		return
	
	var random_column_index = randi() % columns_group.size()
	var target_column = columns_group[random_column_index]
	current_block = block_scene.instantiate()
	current_block.global_position = Vector2(target_column.global_position.x + 45, -50)
	
	var possible_values = [2, 4, 8, 16]
	var random_value = possible_values[randi() % possible_values.size()]
	current_block.value = random_value
	
	add_child(current_block)
	current_block.freeze = false
	current_block.block_landed.connect(Callable(self, "_on_block_landed").bind(current_block))
	is_control_block_active = true
	
func _on_block_landed(landed_block: RigidBody2D):
	if current_block == landed_block:
		var landed_column_index = -1
		var min_distance = INF
		
		for i in range(columns_group.size()):
			var column_center_x = columns_group[i].global_position.x + 45
			var distance = abs(landed_block.global_position.x - column_center_x)
			
			if distance < min_distance:
				min_distance = distance
				landed_column_index = i
			
		if landed_column_index != -1:
			game_grid[landed_column_index].append(landed_block)
			
		current_block = null
		is_control_block_active = false
		call_deferred("spawn_random_block")
	
	
