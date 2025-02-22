extends Node2D

# Base class for all player units (defenders)
class_name Unit

# Components
@onready var health_component = $HealthComponent
@onready var combat_component = $CombatComponent
@onready var movement_component = $MovementComponent

func _ready():
    # Initialize unit
    if not health_component or not combat_component or not movement_component:
        push_error("Unit: Missing required components")
        return
    
    # Setup visual representation
    var visual = ColorRect.new()
    visual.size = Vector2(40, 40)  # Default size
    visual.color = Color(0.6, 0.8, 0.3)  # Default green color
    add_child(visual)