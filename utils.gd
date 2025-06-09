class_name Utils

static func print_grid_columns_data(grid_data: Array, column_index: int) -> void:
	print(column_index, " sütunun değerleri")
	for i in grid_data:
		print(i.value)
