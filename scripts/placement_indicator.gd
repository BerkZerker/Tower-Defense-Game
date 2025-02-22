extends Sprite2D

func _ready() -> void:
	# Create a simple visual indicator
	var image = Image.create(64, 64, false, Image.FORMAT_RGBA8)
	image.fill(Color(1, 1, 1, 0.5))  # Semi-transparent white
	
	# Draw border
	for x in range(64):
		image.set_pixel(x, 0, Color.WHITE)
		image.set_pixel(x, 63, Color.WHITE)
		image.set_pixel(0, x, Color.WHITE)
		image.set_pixel(63, x, Color.WHITE)
	
	# Create and set texture from image
	var indicator_texture = ImageTexture.create_from_image(image)
	self.texture = indicator_texture
	
	# Set initial properties
	self.modulate = Color.GREEN  # Start with green (valid placement)
	self.visible = false  # Hide initially
