extends Node
class_name CombatComponent

signal attack_started(target: Node2D)
signal attack_finished(target: Node2D)
signal damage_dealt(target: Node2D, amount: float)

@export var damage: float = 10.0
@export var attack_range: float = 100.0
@export var attack_speed: float = 1.0  # Attacks per second

var can_attack: bool = true
var current_target: Node2D = null

@onready var parent: Node2D = get_parent()
@onready var attack_timer: Timer = Timer.new()

func _ready() -> void:
	# Setup attack timer
	attack_timer.wait_time = 1.0 / attack_speed
	attack_timer.one_shot = true
	add_child(attack_timer)
	attack_timer.connect("timeout", _on_attack_timer_timeout)

func can_attack_target(target: Node2D) -> bool:
	if not target or not can_attack:
		return false
		
	var distance = parent.position.distance_to(target.position)
	return distance <= attack_range

func start_attack(target: Node2D) -> void:
	if not can_attack_target(target):
		return
		
	current_target = target
	can_attack = false
	attack_timer.start()
	
	emit_signal("attack_started", target)

func _on_attack_timer_timeout() -> void:
	if current_target and current_target.has_node("HealthComponent"):
		var health_component = current_target.get_node("HealthComponent")
		health_component.take_damage(damage)
		emit_signal("damage_dealt", current_target, damage)
	
	emit_signal("attack_finished", current_target)
	can_attack = true
	current_target = null

func stop_attack() -> void:
	attack_timer.stop()
	current_target = null
	can_attack = true

func get_attack_range() -> float:
	return attack_range

func is_attacking() -> bool:
	return current_target != null
