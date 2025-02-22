extends "res://scripts/entities/base_unit.gd"

func _ready():
    super()  # Call base unit ready first
    
    if health_component:
        health_component.max_health = 150
        health_component.current_health = 150
    
    if combat_component:
        combat_component.damage = 25
        combat_component.attack_range = 3.0
        combat_component.attack_speed = 1.0
    
    if movement_component:
        movement_component.move_speed = 0  # Static unit doesn't move
    
    # Static defender is green
    $ColorRect.color = Color(0.2, 0.7, 0.3)