extends BaseCard

# Unit properties
@export var unit_name: String = "Default Unit"
@export var unit_cost: int = 1
@export_file("*.tscn") var unit_scene_path: String = "res://scenes/entities/units/static_defender.tscn"

# Cache for the loaded scene
var _unit_scene = null

func _ready():
    # Load the unit scene when the card is created
    _unit_scene = load(unit_scene_path)

func get_unit_scene():
    return _unit_scene

func get_unit_cost():
    return unit_cost

func get_unit_name():
    return unit_name