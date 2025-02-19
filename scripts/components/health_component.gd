extends Node
class_name HealthComponent

signal health_changed(current_health: float, max_health: float)
signal defeated()

@export var max_health: float = 100.0
var current_health: float

func _ready() -> void:
    current_health = max_health

func take_damage(amount: float) -> void:
    current_health = max(0, current_health - amount)
    emit_signal("health_changed", current_health, max_health)
    
    if current_health <= 0:
        emit_signal("defeated")

func heal(amount: float) -> void:
    current_health = min(max_health, current_health + amount)
    emit_signal("health_changed", current_health, max_health)

func is_alive() -> bool:
    return current_health > 0

func get_health_percentage() -> float:
    return current_health / max_health