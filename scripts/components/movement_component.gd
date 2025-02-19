extends Node
class_name MovementComponent

signal reached_target()
signal path_completed()

@export var speed: float = 100.0
@export var rotation_speed: float = 5.0
@export var target_threshold: float = 5.0

var current_path: Array[Vector2] = []
var current_target: Vector2
var path_index: int = 0
var is_moving: bool = false

@onready var parent: Node2D = get_parent()

func _physics_process(delta: float) -> void:
    if not is_moving or not parent:
        return
    
    if current_path.size() > 0:
        _follow_path(delta)

func move_along_path(path: Array[Vector2]) -> void:
    if path.size() == 0:
        return
        
    current_path = path
    path_index = 0
    current_target = current_path[0]
    is_moving = true

func stop_moving() -> void:
    is_moving = false
    current_path.clear()
    path_index = 0

func _follow_path(delta: float) -> void:
    var direction = current_target - parent.position
    var distance = direction.length()
    
    if distance < target_threshold:
        emit_signal("reached_target")
        
        # Move to next point in path
        path_index += 1
        if path_index >= current_path.size():
            _complete_path()
            return
        
        current_target = current_path[path_index]
        return
    
    # Move towards target
    direction = direction.normalized()
    parent.position += direction * speed * delta
    
    # Rotate towards movement direction
    var target_angle = atan2(direction.y, direction.x)
    var current_angle = parent.rotation
    var new_angle = lerp_angle(current_angle, target_angle, rotation_speed * delta)
    parent.rotation = new_angle

func _complete_path() -> void:
    stop_moving()
    emit_signal("path_completed")

func is_path_completed() -> bool:
    return not is_moving and current_path.is_empty()