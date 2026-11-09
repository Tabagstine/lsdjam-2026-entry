extends Node2D
class_name Zone

@export_group("World Generation")
@export var map_size:=Vector2(64,64)
@export_range(-0.5,1) var sea_level: float = 0
@export_range(0,1) var sand_amount: float
@export var terrain_scale: float
@export var terrain_noise: FastNoiseLite
@export var biome_noise: FastNoiseLite
@export_group("Item Generation")
@export var kitchen_counter: PackedScene
@export var monster: PackedScene

@onready var terrain_tiles: TileMapLayer = $TerrainTiles

var generated_items: Array


func _ready() -> void:
	generate_terrain()
	add_post_terrain_items()
func generate_terrain():
	terrain_tiles.z_index=-4096
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
				if terrain_noise.get_noise_2d(x,y)<sea_level+sand_amount:
					terrain_tiles.set_cell(Vector2i(x,y),0,Vector2i(2,0))
			else:
				#Water generation
					terrain_tiles.set_cell(Vector2i(x,y),0,Vector2i(3,0))
func add_post_terrain_items():
	for x in map_size.x:
		for y in map_size.y:
			var iterated_tile=terrain_tiles.get_cell_tile_data(Vector2i(x,y))
			match iterated_tile.get_custom_data("Tile Type"):
				"Grass":
					var player_spawn_pos: Vector2
					if terrain_noise.get_noise_2d(x,y)>0.3 and x>map_size.x/3: #Player spawner
						if !generated_items.has("Player"):
							generated_items.append("Player")
							var player: Player = load("res://player/player.tscn").instantiate()
							player.position=Vector2(x,y)*32
							add_child(player)
					if terrain_noise.get_noise_2d(x,y)>0.3: #Kitchen counter spawner
						if !generated_items.has("KitchenCounter"):
							print(Vector2(x,y))
							generated_items.append("KitchenCounter")
							var new_kitchen_counter=kitchen_counter.instantiate()
							new_kitchen_counter.position=Vector2(x,y+1)*32
							add_child(new_kitchen_counter)
					if terrain_noise.get_noise_2d(x,y)>0.38: #Monster spawner
						if !generated_items.has("Monster"):
							generated_items.append("Monster")
							var new_monster=monster.instantiate()
							new_monster.position=Vector2(x,y)*32
							add_child(new_monster)
					if terrain_noise.get_noise_2d(x,y)>0.2 and randi_range(0,50)==0:
						if iterated_tile.get_custom_data("Tile Biome")=="Forest":
							spawn_food("apple",Vector2(x,y+0.8)*32)
						else:
							spawn_food("kiwi",Vector2(x,y+0.8)*32)
func spawn_food(food,spawn_position):	
	var new_food:Food=load("res://food/foods/"+str(food)+".tscn").instantiate()
	new_food.position=spawn_position
	add_child(new_food)
