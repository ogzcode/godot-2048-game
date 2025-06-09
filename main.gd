extends Node2D

@onready var block_scene = preload("res://block.tscn")

var columns_group = []
var current_block: CharacterBody2D = null
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
		current_column_index = index
	
func spawn_random_block():
	if is_control_block_active:
		print("Yeni block oluşturulamadı", is_control_block_active)
		return
	
	var random_column_index = randi() % columns_group.size()
	current_column_index = random_column_index
	var target_column = columns_group[random_column_index]
	current_block = block_scene.instantiate()
	current_block.global_position = Vector2(target_column.global_position.x + 45, -50)
	
	var possible_values = [2, 4, 8, 16]
	var random_value = possible_values[randi() % possible_values.size()]
	current_block.value = random_value
	
	add_child(current_block)
	current_block.set_physics_process(true)
	current_block.block_landed.connect(Callable(self, "_on_block_landed").bind(current_block))
	is_control_block_active = true
	
func _on_block_landed(landed_block: CharacterBody2D):
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
			game_grid[landed_column_index].sort_custom(func(a, b): return a.global_position.y < b.global_position.y)
			#Utils.print_grid_columns_data(game_grid[landed_column_index], landed_column_index)
			call_deferred("check_for_merges", landed_block, landed_column_index)
			
		current_block = null
		is_control_block_active = false
		call_deferred("spawn_random_block")
	

func check_for_merges(current_checked_block: CharacterBody2D, column_index: int) -> bool:
	var merged = false
	var column_blocks = game_grid[column_index]
	
	if column_blocks.size() > 1:
		var block_below = column_blocks[1]
		
		if current_checked_block.value == block_below.value:
			merge_blocks(block_below, current_checked_block, column_index)
			merged = true
			
	return merged
	
func merge_blocks(block_below: CharacterBody2D, block_on_top: CharacterBody2D, column_index: int):
	var new_value = block_below.value * 2
	
	game_grid[column_index].erase(block_below)
	game_grid[column_index].erase(block_on_top)
	
	block_below.queue_free()
	block_on_top.queue_free()
	
	var new_merged_block = block_scene.instantiate()
	new_merged_block.value = new_value
	new_merged_block.global_position = block_below.global_position
	add_child(new_merged_block)
	
	game_grid[column_index].append(new_merged_block)
	
	game_grid[column_index].sort_custom(func(a, b): return a.global_position.y < b.global_position.y)
	
	call_deferred("check_for_merges", new_merged_block, column_index)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
