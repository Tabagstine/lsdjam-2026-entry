extends Resource
class_name GeneratedItem

##The scene of the generated item
@export_group("Item Information")
@export var scene: PackedScene
##What value the elevation should depend on
@export_group("Terrain Information")
##Biome the item must be generated in, leave empty for any biome
@export var biome: StringName
##Tile type the item must be generated on, leave empty for any tile
@export var tile_type: StringName
@export_subgroup("Elevation Information")
@export var elevation_value: float
##What the elevation value dictates
@export_enum("number_is_less_than","number_is_greater_than","number_is_equal_to") var elevation_requirement: String
@export_enum("greatest_number","smallest_number") var fallback: String
@export_group("Noise Spawning")
@export var use_noise_generation: bool
@export var noise_generation: FastNoiseLite
@export var noise_requirement: float
@export_group("Misc Spawning")
##If the item has to be spawned or not
@export var force_spawn: bool = false
##The most that can be generated
@export var maximum_amount: int = 1
##Chance for spawning to be cancelled
@export var not_spawn_chance: int
