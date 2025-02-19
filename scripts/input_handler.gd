extends Node

# Since GridManager is an autoload, we can type hint it for better code completion
@onready var grid_manager = get_node("/root/GridManager")

func _ready() -> void:
    # Start listening for input events
    set_process_input(true)

func _input(event: InputEvent) -> void:
    if event is InputEventMouseMotion:
        _handle_mouse_motion(event)
    elif event is InputEventMouseButton:
        _handle_mouse_button(event)
    elif event is InputEventScreenTouch:
        _handle_touch(event)
    elif event is InputEventScreenDrag:
        _handle_drag(event)

func _handle_mouse_motion(event: InputEventMouseMotion) -> void:
    # Update placement indicator
    if grid_manager:
        grid_manager.update_placement_indicator(event.position)

func _handle_mouse_button(event: InputEventMouseButton) -> void:
    if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
        _try_place_unit(event.position)

func _handle_touch(event: InputEventScreenTouch) -> void:
    if event.pressed:
        _try_place_unit(event.position)
    grid_manager.update_placement_indicator(event.position)

func _handle_drag(event: InputEventScreenDrag) -> void:
    grid_manager.update_placement_indicator(event.position)

func _try_place_unit(pos: Vector2) -> void:
    if not grid_manager:
        return
        
    var grid_pos = grid_manager.world_to_grid(pos)
    if grid_manager.is_valid_cell(grid_pos) and not grid_manager.is_cell_occupied(grid_pos):
        # TODO: Signal to card system that placement is valid
        # For now, just print for debugging
        print("Valid placement at grid position: ", grid_pos)