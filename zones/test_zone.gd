extends Node2D
class_name Zone

@export var map_size:=Vector2(64,64)
@export_range(-0.5,1) var sea_level: float = 0
@export var terrain_scale: float
@export var terrain_noise: FastNoiseLite
@export var biome_noise: FastNoiseLite

@onready var terrain_tiles: TileMapLayer = $TerrainTiles

func _ready() -> void:
	biome_noise.seed=randi()
	terrain_noise.seed=randi()
	
	for x in map_size.x:
		for y in map_size.y:
			if terrain_noise.get_noise_2d(x,y)>sea_level:
				#Land generation
				if biome_noise.get_noise_2d(x,y)>0:
					terrain_tiles.set_cell(Vector2i(x,y),0,Vector2i(0,0))
				else:
					terrain_tiles.set_cell(Vector2i(x,y),0,Vector2i(1,0))
				if terrain_noise.get_noise_2d(x,y)<sea_level+0.1:
					terrain_tiles.set_cell(Vector2i(x,y),0,Vector2i(2,0))
			else:
				#Water generation
					terrain_tiles.set_cell(Vector2i(x,y),0,Vector2i(3,0))
