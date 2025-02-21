extends Node
class_name MovementComponent

signal reached_target()

@export var speed: float = 100.0
@export var rotation_speed: float = 5.0
@export var target_threshold: float = 5.0

@onready var parent: Node2D = get_parent()
var current_direction: Vector2 = Vector2.ZERO

func move_in_direction(direction: Vector2, delta: float) -> void:
    if not parent or direction == Vector2.ZERO:
        return
    
    # Move in the given direction
    current_direction = direction.normalized()
    parent.position += current_direction * speed * delta
    
    # Rotate towards movement direction
    var target_angle = atan2(current_direction.y, current_direction.x)
    var current_angle = parent.rotation
    var new_angle = lerp_angle(current_angle, target_angle, rotation_speed * delta)
    parent.rotation = new_angle

func stop_moving() -> void:
    current_direction = Vector2.ZERO

func get_current_direction() -> Vector2:
    return current_direction

func is_moving() -> bool:
    return current_direction != Vector2.ZERO