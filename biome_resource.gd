extends Resource
class_name Biome

@export var biome_name: StringName
@export_enum("number_is_greater_than","number_is_less_than","number_is_equal_to") var temperature_requirement:String = "number_is_greater_than"
@export_range(-1,1) var temperature_value: float
@export_enum("number_is_greater_than","number_is_less_than","number_is_equal_to") var moisture_requirement:String = "number_is_greater_than"
@export_range(-1,1) var moisture_value: float
