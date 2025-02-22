extends "res://scripts/entities/base_unit.gd"

func _ready():
    super()  # Call base unit ready first
    
    if health_component:
        health_component.max_health = 100
        health_component.current_health = 100
    
    if combat_component:
        combat_component.damage = 15
        combat_component.attack_range = 1.5
        combat_component.attack_speed = 1.5
    
    if movement_component:
        movement_component.move_speed = 150  # Fast moving unit
    
    # Mobile defender is blue
    $ColorRect.color = Color(0.3, 0.5, 0.8)