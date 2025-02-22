extends Node

# Since GridManager is an autoload, we can type hint it for better code completion
@onready var grid_manager = get_node("/root/GridManager")
@onready var card_manager = get_node("/root/CardManager")

func _ready() -> void:
	# Start listening for input events
	set_process_input(true)
	
	# Connect to the CardManager's card_selected signal
	card_manager.connect("card_selected", _on_card_selected)

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
		# Check if we have a selected card
		if card_manager and card_manager.selected_card:
			var unit_scene = card_manager.selected_card.get_unit_scene()
			if unit_scene:
				var unit = unit_scene.instantiate()
				get_parent().add_child(unit)
				unit.global_position = grid_manager.grid_to_world(grid_pos)
				grid_manager.occupy_cell(grid_pos, unit)
				# Remove the card
				card_manager.selected_card.queue_free()
				card_manager.selected_card = null
			else:
				print("No unit scene found on card")
		else:
			print("No card selected")

func _on_card_selected(card: Node) -> void:
	print("Card selected: ", card)
