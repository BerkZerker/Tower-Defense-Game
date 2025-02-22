extends "res://scripts/entities/base_enemy.gd"

func setup_enemy():
    if health_component:
        health_component.max_health = 500
        health_component.current_health = 500
    
    if combat_component:
        combat_component.damage = 40
        combat_component.attack_range = 2.0
        combat_component.attack_speed = 0.8
    
    if movement_component:
        movement_component.move_speed = 60.0
    
    # Boss color - dark red
    $ColorRect.color = Color(0.8, 0.1, 0.1)
    # Boss is bigger
    $ColorRect.size = Vector2(60, 60)  # 1.5x normal size
    $ColorRect.position = Vector2(-30, -30)  # Center the larger rect