extends Node

signal grid_manager_ready()
signal tilemap_ready(tilemap: TileMap)
signal placement_indicator_ready(placement_indicator: Sprite2D)

# Grid properties
var cell_size: Vector2 = Vector2(64, 64)  # Size of each cell in pixels
var grid_width: int = 16  # Number of cells horizontally (landscape mode - 1280/64 = 20, using 16 for margin)
var grid_height: int = 9  # Number of cells vertically (landscape mode - 720/64 = 11.25, using 9 for margin)

# Reference to game nodes
var tilemap: TileMap
var placement_indicator: Sprite2D

# Grid state tracking
var _occupied_cells: Dictionary = {}  # Tracks which cells are occupied

func _ready() -> void:
	# Wait for scene tree to be ready before getting node references
	await get_tree().root.ready

	# Wait for tilemap and placement indicator to be ready
	await _wait_for_tilemap()
	await _wait_for_placement_indicator()

	if tilemap and placement_indicator:
		_setup_grid()

	emit_signal("grid_manager_ready")

func _wait_for_tilemap() -> void:
	await tilemap_ready
	
func _wait_for_placement_indicator() -> void:
	await placement_indicator_ready

func set_tilemap(new_tilemap: TileMap) -> void:
	tilemap = new_tilemap

func set_placement_indicator(new_placement_indicator: Sprite2D) -> void:
	placement_indicator = new_placement_indicator

func _setup_grid() -> void:
	# Initialize grid properties
	tilemap.cell_size = cell_size

	# Set up grid bounds
	var viewport_size = get_viewport().get_visible_rect().size
	var grid_position = Vector2(
		(viewport_size.x - (grid_width * cell_size.x)) / 2,
		(viewport_size.y - (grid_height * cell_size.y)) / 2
	)
	tilemap.position = grid_position

	# Fill grid with basic tiles
	for x in range(grid_width):
		for y in range(grid_height):
			tilemap.set_cell(0, Vector2i(x, y), 0, Vector2i(0, 0))

func world_to_grid(world_pos: Vector2) -> Vector2i:
	# Convert world position to grid coordinates
	var local_pos = world_pos - tilemap.position
	return Vector2i(
		floor(local_pos.x / cell_size.x),
		floor(local_pos.y / cell_size.y)
	)

func grid_to_world(grid_pos: Vector2i) -> Vector2:
	# Convert grid coordinates to world position (cell center)
	return tilemap.position + Vector2(
		grid_pos.x * cell_size.x + cell_size.x / 2,
		grid_pos.y * cell_size.y + cell_size.y / 2
	)

func is_valid_cell(grid_pos: Vector2i) -> bool:
	# Check if the given grid position is within bounds and is a valid placement cell
	if not (grid_pos.x >= 0 and grid_pos.x < grid_width and \
		   grid_pos.y >= 0 and grid_pos.y < grid_height):
		return false

	# Check if the tile is a valid placement tile (using custom data layer)
	var tile_data = tilemap.get_cell_tile_data(0, grid_pos) # Assuming tile layer 0
	if tile_data:
		if tile_data.get_custom_data_by_name("valid_placement") == true:
			return true

	return false

func is_cell_occupied(grid_pos: Vector2i) -> bool:
	# Check if a cell is already occupied
	return _occupied_cells.has(grid_pos)

func occupy_cell(grid_pos: Vector2i, unit: Node2D) -> bool:
	# Try to occupy a cell with a unit
	if not is_valid_cell(grid_pos) or is_cell_occupied(grid_pos):
		return false

	_occupied_cells[grid_pos] = unit
	return true

func free_cell(grid_pos: Vector2i) -> void:
	# Free up a cell
	_occupied_cells.erase(grid_pos)

func get_cell_center(world_pos: Vector2) -> Vector2:
	# Get the center position of the cell that contains the given world position
	var grid_pos = world_to_grid(world_pos)
	return grid_to_world(grid_pos)

func update_placement_indicator(world_pos: Vector2) -> void:
	# Update the placement indicator position and appearance
	if placement_indicator:
		var grid_pos = world_to_grid(world_pos)
		var is_valid = is_valid_cell(grid_pos) and not is_cell_occupied(grid_pos)

		placement_indicator.position = grid_to_world(grid_pos)
		placement_indicator.modulate = Color.GREEN if is_valid else Color.RED
