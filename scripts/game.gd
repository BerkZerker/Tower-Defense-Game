extends Node2D

# Reference to the GridManager singleton
var grid_manager
# Reference to the PlacementIndicator sprite
var placement_indicator
# Reference to the CardHand node
var card_hand
# Currently selected card
var selected_card = null
# Flag indicating if a card is being dragged
var dragging_card = false

func _ready() -> void:
    # Get reference to the GridManager
    grid_manager = $GridManager
    # Get reference to the PlacementIndicator
    placement_indicator = $GridManager/PlacementIndicator
    
    # Set up the placement indicator for the grid
    grid_manager.set_placement_indicator(placement_indicator)
    
    # Get reference to CardHand
    card_hand = $UIOverlay/CardHand # Assuming UIOverlay and CardHand are direct children

func _input(event: InputEvent) -> void:
    # Handle input events
    if event is InputEventScreenTouch or event is InputEventMouseButton:
        var position = event.position
        print("Input at position: ", position)
        
        # Card selection logic
        if not dragging_card:
            for card_node in card_hand.get_children():
                if card_node.has_method("is_card") and card_node.is_card() and card_node.has_method("get_card_rect") and card_node.get_card_rect().has_point(card_hand.to_local(position)): # Assuming cards have "is_card()" and "get_card_rect()" methods
                    selected_card = card_node
                    dragging_card = true
                    selected_card.z_index = 1 # Lift card visually
                    print("Card selected: ", selected_card.name)
                    break # Select only one card at a time
        
        if dragging_card and (event is InputEventScreenDrag or (event is InputEventMouseMotion and event.button_mask != 0)): # Mouse drag
            if selected_card:
                selected_card.position = card_hand.to_local(event.position) # Move card within CardHand's local space
        
        if event is InputEventScreenTouch or event is InputEventMouseButton: # Mouse button up or touch end
            if dragging_card:
                dragging_card = false
                selected_card.z_index = 0 # Reset card Z-index
                selected_card = null
                print("Card dropped")
