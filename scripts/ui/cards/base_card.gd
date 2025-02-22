extends Control
class_name BaseCard

signal card_selected(card)
signal card_deselected(card)

# Abstract methods to be implemented by child classes
func get_unit_scene():
	push_error("BaseCard: get_unit_scene() not implemented")
	return null

func get_unit_cost():
	push_error("BaseCard: get_unit_cost() not implemented")
	return 0

func get_unit_name():
	push_error("BaseCard: get_unit_name() not implemented")
	return "Base Card"
