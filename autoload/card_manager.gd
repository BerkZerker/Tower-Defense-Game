extends Node

signal card_selected(card)

var selected_card: Node = null  # Currently selected card

func select_card(card: Node) -> void:
    selected_card = card
    emit_signal("card_selected", card)