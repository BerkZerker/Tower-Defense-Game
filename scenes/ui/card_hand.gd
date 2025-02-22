extends CanvasLayer

var _selected_card = null

func _ready():
    # Connect to card manager if needed
    pass

func on_card_selected(card):
    # Deselect previous card if any
    if _selected_card and _selected_card != card:
        _selected_card.deselect()
    
    _selected_card = card