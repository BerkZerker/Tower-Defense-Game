extends BaseCard

# These variables will show up in the Inspector panel when the script is attached to a node
#   unit_name: Name of the unit this card creates
#   unit_cost: Resource cost to play this card
#   unit_scene_path: Which unit scene this card will place (.tscn file)
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