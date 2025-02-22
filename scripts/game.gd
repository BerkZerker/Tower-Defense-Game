extends Node2D

# Reference to the GridManager singleton
var grid_manager
# Reference to the CardManager singleton
var card_manager
# Reference to the PlacementIndicator sprite
var placement_indicator
# Reference to the CardHand node
var card_hand
# Reference to MainTower node
var main_tower
# Flag indicating if a card is being dragged
var dragging_card = false

# Enemy spawn settings
@export var spawn_interval: float = 5.0
@onready var spawn_timer: Timer = Timer.new()
@onready var spawn_points = $WaveManager/SpawnPoints

# Preload enemy scene
const EnemyScene = preload("res://scenes/entities/enemies/normal_slime.tscn")

func _ready() -> void:
	# Add this node to the "game" group for enemy targeting
	add_to_group("game")
	
	# Get reference to the GridManager
	grid_manager = get_node("/root/GridManager")
	# Get reference to the CardManager
	card_manager = get_node("/root/CardManager")
	# Get reference to the PlacementIndicator
	placement_indicator = $GridManager/PlacementIndicator
	# Get reference to MainTower
	main_tower = $MainTower
	
	# Set up the placement indicator for the grid
	grid_manager.emit_signal("placement_indicator_ready", placement_indicator)
	
	# Get reference to CardHand
	card_hand = $UIOverlay/CardHand
	
	# Set up spawn timer
	spawn_timer.wait_time = spawn_interval
	spawn_timer.connect("timeout", _spawn_enemy)
	add_child(spawn_timer)
	spawn_timer.start()

func _spawn_enemy() -> void:
	if spawn_points and spawn_points.get_child_count() > 0:
		# Get a random spawn point
		var spawn_point = spawn_points.get_children()[randi() % spawn_points.get_child_count()]
		
		# Instance new enemy
		var enemy = EnemyScene.instantiate()
		add_child(enemy)
		enemy.initialize(spawn_point.global_position)

func _try_place_unit(card_node: Node2D, position: Vector2) -> bool:
	var grid_pos = grid_manager.world_to_grid(position)
	
	if grid_manager.is_valid_cell(grid_pos) and not grid_manager.is_cell_occupied(grid_pos):
		# Get unit scene from card
		var unit_scene = card_node.get_unit_scene()
		if unit_scene:
			var unit = unit_scene.instantiate()
			add_child(unit)
			unit.global_position = grid_manager.grid_to_world(grid_pos)
			grid_manager.occupy_cell(grid_pos, unit)
			return true
	return false

func _input(event: InputEvent) -> void:
	# Handle input events
	if event is InputEventScreenTouch or event is InputEventMouseButton:
		var position = event.position
		print("Input at position: ", position)
		
		# Card selection logic
		if not dragging_card:
			for card_node in card_hand.get_children():
				if card_node.has_method("is_card") and card_node.is_card() and card_node.has_method("get_card_rect") and card_node.get_card_rect().has_point(card_hand.to_local(position)): # Assuming cards have "is_card()" and "get_card_rect()" methods
					card_manager.select_card(card_node)
					dragging_card = true
					card_node.z_index = 1 # Lift card visually
					print("Card selected: ", card_node.name)
					break # Select only one card at a time
		
		if dragging_card and (event is InputEventScreenDrag or (event is InputEventMouseMotion and event.button_mask != 0)): # Mouse drag
			if card_manager.selected_card:
				card_manager.selected_card.position = card_hand.to_local(event.position) # Move card within CardHand's local space
		
		if event is InputEventScreenTouch or (event is InputEventMouseButton and not event.pressed): # Mouse button up or touch end
			if dragging_card:
				var drop_pos = event.position
				var card_rect = Rect2(card_hand.global_position, card_hand.size)
				
				# Check if card was dropped outside the card hand area
				if not card_rect.has_point(drop_pos):
					if _try_place_unit(card_manager.selected_card, drop_pos):
						# If placement successful, remove the card
						card_manager.selected_card.queue_free()
						card_manager.selected_card = null
					else:
						# If placement failed, reset card position
						card_manager.selected_card.position = Vector2.ZERO
				
				dragging_card = false
				if card_manager.selected_card:
					card_manager.selected_card.z_index = 0 # Reset card Z-index
				card_manager.select_card(null)
				print("Card dropped")
