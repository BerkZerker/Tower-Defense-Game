extends "res://scripts/entities/base_unit.gd"

func _ready():
    super()  # Call base unit ready first
    
    if health_component:
        health_component.max_health = 80
        health_component.current_health = 80
    
    if combat_component:
        combat_component.damage = 5  # Low direct damage
        combat_component.attack_range = 4.0  # Long range support
        combat_component.attack_speed = 2.0  # Fast attacks for support effects
    
    if movement_component:
        movement_component.move_speed = 50  # Moderate speed
    
    # Support defender is yellow
    $ColorRect.color = Color(0.9, 0.8, 0.2)