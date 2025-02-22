extends "res://scripts/entities/base_enemy.gd"

func setup_enemy():
    if health_component:
        health_component.max_health = 100
        health_component.current_health = 100
    
    if combat_component:
        combat_component.damage = 10
        combat_component.attack_range = 1.0
        combat_component.attack_speed = 1.0
    
    if movement_component:
        movement_component.move_speed = 100.0

    # Basic mob color
    $ColorRect.color = Color(0.3, 0.8, 0.3)