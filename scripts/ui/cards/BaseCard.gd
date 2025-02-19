extends Control
class_name BaseCard

func is_card():
	return true

func get_card_rect():
	return Rect2(Vector2(0,0), size) # Returns the bounding rect of the control