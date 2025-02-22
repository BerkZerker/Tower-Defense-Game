extends Node2D

# Components
@onready var health_component = $HealthComponent
@onready var combat_component = $CombatComponent
@onready var movement_component = $MovementComponent

func _ready():
    # Initialize enemy
    if not health_component or not combat_component or not movement_component:
        push_error("Enemy: Missing required components")
        return
    
    # Setup visual representation
    var visual = ColorRect.new()
    visual.size = Vector2(40, 40)  # Default size
    visual.color = Color(0.8, 0.3, 0.3)  # Default red color
    add_child(visual)
    
    # Initialize enemy specific properties
    setup_enemy()

func setup_enemy():
    # Virtual method to be overridden by specific enemy types
    pass