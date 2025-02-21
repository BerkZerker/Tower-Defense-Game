extends Node

signal grid_manager_ready()
signal grid_ready(grid: Node2D)
signal placement_indicator_ready(placement_indicator: Sprite2D)

# Grid properties
var cell_size: Vector2 = Vector2(64, 64)  # Size of each cell in pixels
var grid_width: int = 16  # Number of cells horizontally (landscape mode - 1280/64 = 20, using 16 for margin)
var grid_height: int = 9  # Number of cells vertically (landscape mode - 720/64 = 11.25, using 9 for margin)

# Reference to game nodes
var grid: Node2D  # The node that represents the grid
var placement_indicator: Sprite2D  # The sprite that indicates where a unit can be placed
var grid_position: Vector2  # The position of the grid in the world

# Grid state tracking
var _occupied_cells: Dictionary = {}  # Tracks which cells are occupied
var _grid_cells: Array = []  # Stores grid cell data

func _ready() -> void:
	# Initialize grid cells array first
	_initialize_grid_cells()
	
	# Wait for scene tree to be ready before getting node references
	await get_tree().root.ready
	
	# Create grid node
	grid = Node2D.new()
	add_child(grid)
	
	# Wait for placement indicator to be ready
	await _wait_for_placement_indicator()
	
	if grid and placement_indicator:
		_setup_grid()
		emit_signal("grid_manager_ready")

# Initializes the grid cells array with default values
func _initialize_grid_cells() -> void:
	_grid_cells.clear()
	for y in range(grid_height):
		var row = []
		for x in range(grid_width):
			row.append({
				"valid_placement": true,
				"position": Vector2(x * cell_size.x, y * cell_size.y)
			})
		_grid_cells.append(row)

func _wait_for_placement_indicator() -> void:
	await placement_indicator_ready

func set_placement_indicator(new_placement_indicator: Sprite2D) -> void:
	placement_indicator = new_placement_indicator

func _setup_grid() -> void:
	# Set up grid bounds and position
	var viewport_size = get_viewport().get_visible_rect().size
	grid_position = Vector2(
		(viewport_size.x - (grid_width * cell_size.x)) / 2,
		(viewport_size.y - (grid_height * cell_size.y)) / 2
	)
	grid.position = grid_position
	
	# Draw grid lines
	_draw_grid()

func _draw_grid() -> void:
	var line_2d = Line2D.new()
	line_2d.width = 1.0
	line_2d.default_color = Color(0.5, 0.5, 0.5, 0.3)  # Subtle grid lines
	
	# Draw vertical lines
	for x in range(grid_width + 1):
		var start = Vector2(x * cell_size.x, 0)
		var end = Vector2(x * cell_size.x, grid_height * cell_size.y)
		line_2d.add_point(start)
		line_2d.add_point(end)
		line_2d.add_point(end)  # Double point to create discontinuity
	
	# Draw horizontal lines
	for y in range(grid_height + 1):
		var start = Vector2(0, y * cell_size.y)
		var end = Vector2(grid_width * cell_size.x, y * cell_size.y)
		line_2d.add_point(start)
		line_2d.add_point(end)
		line_2d.add_point(end)  # Double point to create discontinuity
	
	grid.add_child(line_2d)

# Converts world position to grid coordinates
func world_to_grid(world_pos: Vector2) -> Vector2i:
	# Convert world position to grid coordinates
	var local_pos = world_pos - grid_position
	return Vector2i(
		floor(local_pos.x / cell_size.x),
		floor(local_pos.y / cell_size.y)
	)

# Converts grid coordinates to world position
func grid_to_world(grid_pos: Vector2i) -> Vector2:
	# Convert grid coordinates to world position (cell center)
	return grid_position + Vector2(
		grid_pos.x * cell_size.x + cell_size.x / 2,
		grid_pos.y * cell_size.y + cell_size.y / 2
	)

# Checks if a cell is valid for placement
func is_valid_cell(grid_pos: Vector2i) -> bool:
	# First check bounds to prevent array access errors
	if not (grid_pos.x >= 0 and grid_pos.x < grid_width and
		grid_pos.y >= 0 and grid_pos.y < grid_height):
		return false
	
	# Now safely access the grid cells array
	if _grid_cells.size() > grid_pos.y and _grid_cells[grid_pos.y].size() > grid_pos.x:
		return _grid_cells[grid_pos.y][grid_pos.x]["valid_placement"]
	return false

# Checks if a cell is occupied
func is_cell_occupied(grid_pos: Vector2i) -> bool:
	# Check if a cell is already occupied
	return _occupied_cells.has(grid_pos)

# Occupies a cell with a unit
func occupy_cell(grid_pos: Vector2i, unit: Node2D) -> bool:
	# Try to occupy a cell with a unit
	if not is_valid_cell(grid_pos) or is_cell_occupied(grid_pos):
		return false
	
	_occupied_cells[grid_pos] = unit
	return true

# Frees a cell
func free_cell(grid_pos: Vector2i) -> void:
	# Free up a cell
	_occupied_cells.erase(grid_pos)

# Gets the center position of a cell
func get_cell_center(world_pos: Vector2) -> Vector2:
	# Get the center position of the cell that contains the given world position
	var grid_pos = world_to_grid(world_pos)
	return grid_to_world(grid_pos)

# Updates the placement indicator
func update_placement_indicator(world_pos: Vector2) -> void:
	# Update the placement indicator position and appearance
	if placement_indicator:
		var grid_pos = world_to_grid(world_pos)
		var is_valid = is_valid_cell(grid_pos) and not is_cell_occupied(grid_pos)
		
		placement_indicator.position = grid_to_world(grid_pos)
		placement_indicator.modulate = Color.GREEN if is_valid else Color.RED

# Sets whether a cell is valid for placement
func set_cell_valid_placement(grid_pos: Vector2i, valid: bool) -> void:
	# First check bounds to prevent array access errors
	if not (grid_pos.x >= 0 and grid_pos.x < grid_width and
		grid_pos.y >= 0 and grid_pos.y < grid_height):
		return
	
	# Now safely access the grid cells array
	if _grid_cells.size() > grid_pos.y and _grid_cells[grid_pos.y].size() > grid_pos.x:
		_grid_cells[grid_pos.y][grid_pos.x]["valid_placement"] = valid
