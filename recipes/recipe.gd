extends Resource
class_name Recipe

@export_enum("None","Chopping") var minigame = "None"
@export var recipe_name: String = "recipe_name"
@export var ingredients: Dictionary[String,int]
