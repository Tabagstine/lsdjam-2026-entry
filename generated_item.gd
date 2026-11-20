extends Resource
class_name GeneratedItem

##The scene of the generated item
@export var scene: PackedScene
##The most that can be generated
@export var maximum_amount: int = 1
##The least that can be generated
@export var minimum_amount: int = 1
##Biome the item must be generated in, leave empty for any biome
@export var biome: StringName
##Tile type the item must be generated on, leave empty for any tile
@export var tile_type: StringName
##What value the elevation should depend on
@export var elevation_value: float
##What the elevation value dictates
@export_enum("number_is_less_than","number_is_greater_than","number_is_equal_to") var elevation_requirement: String
@export_enum("greatest_number","smallest_number","closest_number") var fallback: String
