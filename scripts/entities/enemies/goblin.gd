@tool
extends "res://scripts/entities/base_enemy.gd"

# Properties specific to goblin
@export var goblin_name: String = "Goblin"
@export var goblin_score: int = 200

# Component references inherited from BaseEnemy:
# health_component
# movement_component
# combat_component
# sprite
# collision_shape

func _ready() -> void:
    # Set goblin properties
    enemy_name = goblin_name
    score_value = goblin_score
    
    # Call parent ready
    super._ready()
    
    # Configure components for this enemy type
    if health_component:
        health_component.max_health = 75.0  # Tougher than slime and bat
    
    if movement_component:
        movement_component.speed = 85.0  # Faster than slime, slower than bat
        movement_component.rotation_speed = 3.5  # More agile than slime
    
    if combat_component:
        combat_component.damage = 12.0  # Highest damage
        combat_component.attack_range = 40.0  # Longer range
        combat_component.attack_speed = 0.8  # Slower but harder hitting

func initialize(spawn_position: Vector2) -> void:
    super.initialize(spawn_position)
    # Add any goblin-specific initialization here

func get_enemy_type() -> String:
    return "goblin"