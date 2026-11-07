extends Node2D
class_name Zone

@export var map_size:=Vector2(64,64)
@export_range(-1,1) var sea_level: float = 0
@export var terrain_scale: float
@export var noise: FastNoiseLite



var terrain: Array

func _ready() -> void:
	for x in map_size.x:
		for y in map_size.y:
			if noise.get_noise_2d(x,y)>sea_level:
				terrain.append(Vector2(x*terrain_scale,y*terrain_scale))
func _draw() -> void:
	for i in terrain.size():
		draw_circle(terrain[i],terrain_scale,Color())
