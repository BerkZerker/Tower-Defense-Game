@tool
extends "res://scripts/entities/enemies/base_enemy.gd"

# Properties specific to normal slime
@export var slime_name: String = "Normal Slime"
@export var slime_score: int = 100

# Component references inherited from BaseEnemy:
# health_component
# movement_component
# combat_component
# sprite
# collision_shape

func _ready() -> void:
	# Set slime properties
	enemy_name = slime_name
	score_value = slime_score
	
	# Call parent ready
	super._ready()
	
	# Configure components for this enemy type
	if health_component:
		health_component.max_health = 50.0
	
	if movement_component:
		movement_component.speed = 75.0
		movement_component.rotation_speed = 3.0
	
	if combat_component:
		combat_component.damage = 5.0
		combat_component.attack_range = 32.0
		combat_component.attack_speed = 1.0  # 1 attack per second

	# Slime color - blue
	for child in get_children():
		if child is ColorRect:
			child.color = Color(0.3, 0.3, 0.8)

func initialize(spawn_position: Vector2) -> void:
	super.initialize(spawn_position)
	# Add any slime-specific initialization here

func get_enemy_type() -> String:
	return "normal_slime"
