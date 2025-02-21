extends CharacterBody2D
class_name BaseEnemy

# Component class imports
const HealthComponent = preload("res://scripts/components/health_component.gd")
const MovementComponent = preload("res://scripts/components/movement_component.gd")
const CombatComponent = preload("res://scripts/components/combat_component.gd")

signal defeated()

@export var enemy_name: String = "Base Enemy"
@export var score_value: int = 100

# Component references
@onready var health_component: HealthComponent = $HealthComponent
@onready var movement_component: MovementComponent = $MovementComponent
@onready var combat_component: CombatComponent = $CombatComponent
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

# Get GridManager singleton reference
@onready var grid_manager = get_node("/root/GridManager")

@export var detection_radius: float = 150.0  # Detection radius for nearby defenders

# Enemy state
var target: Node2D = null
var main_tower: Node2D = null  # Reference to the main tower
var current_speed: float = 100.0  # Movement speed

func _ready() -> void:
    # Connect component signals
    if health_component:
        health_component.defeated.connect(_on_defeated)
    
    if combat_component:
        combat_component.attack_finished.connect(_on_attack_finished)
    
    # Find main tower reference
    var game_node = get_tree().get_first_node_in_group("game")
    if game_node:
        main_tower = game_node.get_node_or_null("MainTower")
        if main_tower:
            set_target(main_tower)

func _physics_process(delta: float) -> void:
    _update_behavior(delta)

func set_target(new_target: Node2D) -> void:
    target = new_target

func take_damage(amount: float) -> void:
    if health_component:
        health_component.take_damage(amount)

func _update_behavior(delta: float) -> void:
    if not target:
        if main_tower:
            set_target(main_tower)
        return
    
    # Check for nearby defenders
    var closest_defender = _find_closest_defender()
    if closest_defender:
        set_target(closest_defender)
    elif target != main_tower and main_tower:
        set_target(main_tower)
    
    if combat_component and combat_component.can_attack_target(target):
        movement_component.stop_moving()
        combat_component.start_attack(target)
    elif not combat_component.is_attacking():
        # Move directly towards target using movement component
        var direction = grid_manager.get_direction_to_target(global_position, target.global_position)
        movement_component.move_in_direction(direction, delta)

func _find_closest_defender() -> Node2D:
    var defenders = get_tree().get_nodes_in_group("defenders")
    var closest_defender = null
    var closest_distance = detection_radius
    
    for defender in defenders:
        var distance = grid_manager.get_distance_to_target(global_position, defender.global_position)
        if distance < closest_distance:
            closest_distance = distance
            closest_defender = defender
    
    return closest_defender

func _on_defeated() -> void:
    movement_component.stop_moving()
    combat_component.stop_attack()
    emit_signal("defeated")
    queue_free()

func _on_path_completed() -> void:
    # Request new path if target still exists
    if target:
        set_target(target)

func _on_reached_target() -> void:
    if combat_component and target:
        combat_component.start_attack(target)

func _on_attack_finished(_target: Node2D) -> void:
    # Check if we need to move again
    if target and not combat_component.can_attack_target(target):
        set_target(target)

# Override these in specific enemy types
func initialize(spawn_position: Vector2) -> void:
    position = spawn_position

func get_enemy_type() -> String:
    return enemy_name

func get_score_value() -> int:
    return score_value