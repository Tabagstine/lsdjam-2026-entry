extends Node2D
class_name Zone

##If disabled, the zone will be pre-made and NOT generated.
@export var use_world_generation: bool = true
@export_group("World Generation")
##How large the map will be in width and height
@export var map_size:=Vector2(64,64)
##How much of the map will be sea
@export_range(-0.5,1) var sea_level: float = 0
@export_range(0,1) var sand_amount: float =0.04
##Noise patterns for elevation, temperature, and humidity
@export var noises: Dictionary [StringName,FastNoiseLite] ={"elevation":preload("res://default_noise.tres"),"temperature":preload("res://default_noise.tres"),"moisture":preload("res://default_noise.tres")}
@export var biomes: Array[Biome]
@export var defualt_biome: StringName
##Changes the priorty for biomes. Items higher up override lower biomes.
@export_group("Item Generation")
@export var kitchen_counter: PackedScene = preload("res://kitchen/kitchen_counter.tscn")
@export var monster: PackedScene = preload("res://monster/monster.tscn")

@onready var terrain_tiles: TileMapLayer = $TerrainTiles
##Items that have been generated get added to the array
var generated_items: Array

func _process(_delta: float) -> void:
	var local_to_map=terrain_tiles.local_to_map(Globals.player.position)
	var tile_moisture=noises.moisture.get_noise_2d(local_to_map.x,local_to_map.y)
	var tile_temperature=noises.temperature.get_noise_2d(local_to_map.x,local_to_map.y)
	print("Moisture: "+str(tile_moisture)+" | Temperature: "+str(tile_temperature)+" | Biome: "+str(get_cell_biome(local_to_map.x,local_to_map.y)))
func _ready() -> void:
	if use_world_generation:
		generate_terrain()
		add_post_terrain_items()
func generate_terrain():
	terrain_tiles.z_index=-4096
	for i in noises.keys().size():
		noises.get(noises.keys()[i]).seed=randi()
	
	for x:int in map_size.x:
		for y:int in map_size.y:
			var elevation=noises.elevation.get_noise_2d(x,y)
			if elevation>sea_level:
				#Land generation
				match get_cell_biome(x,y):
					"Forest": terrain_tiles.set_cell(Vector2i(x,y),0,Vector2i(0,0))
					"Desert": terrain_tiles.set_cell(Vector2i(x,y),0,Vector2i(2,0))
					_:terrain_tiles.set_cell(Vector2i(x,y),0,Vector2i(1,0))
				if elevation<sea_level+sand_amount:
					terrain_tiles.set_cell(Vector2i(x,y),0,Vector2i(2,0))
			else:
				#Water generation
					terrain_tiles.set_cell(Vector2i(x,y),0,Vector2i(3,0))
func add_post_terrain_items():
	for x:int in map_size.x:
		for y:int in map_size.y:
			var elevation=noises.elevation.get_noise_2d(x,y)
			var iterated_tile=terrain_tiles.get_cell_tile_data(Vector2i(x,y))
			match iterated_tile.get_custom_data("Tile Type"):
				"Grass":
					if elevation>0.3 and x>map_size.x/3: #Player spawner
						if !generated_items.has("Player"):
							generated_items.append("Player")
							var spawned_player: Player = load("res://player/player.tscn").instantiate()
							spawned_player.position=Vector2(x,y)*32
							add_child(spawned_player)
					if elevation<0.3 and elevation>0.2 and x>map_size.x/2 and y>map_size.y/2: #Kitchen counter spawner
						if !generated_items.has("KitchenCounter"):
							print(Vector2(x,y))
							generated_items.append("KitchenCounter")
							var new_kitchen_counter=kitchen_counter.instantiate()
							new_kitchen_counter.position=Vector2(x,y+1)*32
							add_child(new_kitchen_counter)
					if elevation>0.38: #Monster spawner
						if !generated_items.has("Monster"):
							generated_items.append("Monster")
							var new_monster=monster.instantiate()
							new_monster.position=Vector2(x,y)*32
							add_child(new_monster)
					if elevation>0.2 and randi_range(0,50)==0: #Temporary food spawning
						if iterated_tile.get_custom_data("Tile Biome")=="Forest":
							spawn_food("apple",Vector2(x,y+0.8)*32)
						else:
							spawn_food("kiwi",Vector2(x,y+0.8)*32)
func spawn_food(food,spawn_position):	
	var new_food:Food=load("res://food/foods/"+str(food)+".tscn").instantiate()
	new_food.position=spawn_position
	add_child(new_food)
func get_cell_biome(cell_x,cell_y):
	var biome_gotten: String = defualt_biome
	if noises.elevation.get_noise_2d(cell_x,cell_y)<sea_level:
		biome_gotten="Plains Ocean"
	for i in biomes.size():
		if see_if_biome_requirement_met(i,cell_x,cell_y):
			biome_gotten=biomes[i].biome_name
			if noises.elevation.get_noise_2d(cell_x,cell_y)<sea_level:
				biome_gotten=biome_gotten+" Ocean"
			return biome_gotten
	return biome_gotten
func see_if_biome_requirement_met(biome_number:int,cell_x:int,cell_y:int):
	var requirments_met: Array[String]
	var given_biome=biomes[biome_number]
	var requirement=Callable(self,given_biome.temperature_requirement)
	if requirement.call(noises.temperature.get_noise_2d(cell_x,cell_y),given_biome.temperature_value):
		requirments_met.append("temperature")
	requirement=Callable(self,given_biome.moisture_requirement)
	if requirement.call(noises.moisture.get_noise_2d(cell_x,cell_y),given_biome.moisture_value):
		requirments_met.append("moisture")
	if requirments_met.has("temperature") and requirments_met.has("moisture"):
		return true
	else:
		return false
func number_is_less_than(x,y):
	if x<y:
		return true
	else:
		return false
func number_is_greater_than(x,y):
	if x>y:
		return true
	else:
		return false
func number_is_equal_to(x,y):
	if x==y:
		return true
	else:
		return false
