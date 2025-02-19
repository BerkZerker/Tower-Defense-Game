extends Node2D

var grid_manager
var tilemap
var placement_indicator

func _ready() -> void:
	grid_manager = $GridManager
	tilemap = $GridManager/TileMap
	placement_indicator = $GridManager/PlacementIndicator
	
	grid_manager.set_tilemap(tilemap)
	grid_manager.set_placement_indicator(placement_indicator)