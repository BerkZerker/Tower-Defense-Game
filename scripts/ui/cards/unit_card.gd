extends Control

# These variables will show up in the Inspector panel when the script is attached to a node
#   unit_name: Name of the unit this card creates
#   unit_cost: Resource cost to play this card
#   unit_scene_path: Which unit scene this card will place (.tscn file)
@export var unit_name: String = "Default Unit"
@export var unit_cost: int = 1
@export_file("*.tscn") var unit_scene_path: String = "res://scenes/entities/units/static_defender.tscn"

signal card_selected(card)
signal card_deselected(card)

# Cache for the loaded scene
var _unit_scene = null
var _selected = false

func _ready():
	# Load the unit scene when the card is created
	_unit_scene = load(unit_scene_path)
	$Content/UnitName.text = unit_name
	# Make card clickable
	connect("gui_input", _on_gui_input)

func get_unit_scene():
	return _unit_scene

func get_unit_cost():
	return unit_cost

func get_unit_name():
	return unit_name

func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			select()

func select():
	_selected = true
	$Selected.show()
	# Notify parent/manager that this card was selected
	card_selected.emit(self)
	# Deselect other cards
	if get_parent():
		for card in get_parent().get_children():
			if card != self and card.has_method("deselect"):
				card.deselect()

func deselect():
	_selected = false
	$Selected.hide()
	card_deselected.emit(self)
