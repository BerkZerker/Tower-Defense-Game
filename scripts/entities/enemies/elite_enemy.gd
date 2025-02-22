extends "res://scripts/entities/base_enemy.gd"

func setup_enemy():
    if health_component:
        health_component.max_health = 200
        health_component.current_health = 200
    
    if combat_component:
        combat_component.damage = 20
        combat_component.attack_range = 1.5
        combat_component.attack_speed = 1.2
    
    if movement_component:
        movement_component.move_speed = 80.0

    # Elite color - purple
    $ColorRect.color = Color(0.8, 0.2, 0.6)