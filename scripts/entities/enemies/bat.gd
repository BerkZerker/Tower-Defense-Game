@tool
extends "res://scripts/entities/enemies/base_enemy.gd"

# Properties specific to bat
@export var bat_name: String = "Bat"
@export var bat_score: int = 150

# Component references inherited from BaseEnemy:
# health_component
# movement_component
# combat_component
# sprite
# collision_shape

func _ready() -> void:
	# Set bat properties
	enemy_name = bat_name
	score_value = bat_score
	
	# Call parent ready
	super._ready()
	
	# Configure components for this enemy type
	if health_component:
		health_component.max_health = 35.0  # Lower health than slime but faster
	
	if movement_component:
		movement_component.speed = 100.0  # Faster than slime
		movement_component.rotation_speed = 4.0  # More agile
	
	if combat_component:
		combat_component.damage = 8.0  # More damage than slime
		combat_component.attack_range = 24.0  # Shorter range
		combat_component.attack_speed = 1.5  # Faster attacks

func initialize(spawn_position: Vector2) -> void:
	super.initialize(spawn_position)
	# Add any bat-specific initialization here

func get_enemy_type() -> String:
	return "bat"
