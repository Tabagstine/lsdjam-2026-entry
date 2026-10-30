extends Node
var time_left: float = 300
var time_paused: bool = false
var possible_recipes: Array[Recipe]

func _process(delta: float) -> void:
	if !time_paused:
		time_left-=delta
func _ready():
	possible_recipes = [add_recipe("failed"),add_recipe("fruit_salad"),add_recipe("kiwis")]
func get_food_result():
	var player: Player=get_tree().get_first_node_in_group("player")
	var food_result: Recipe = possible_recipes[0]
	var recipe_passed: bool = true
	for recipe_num in possible_recipes.size():
		recipe_passed=player.get_food_stack_dictionary()==possible_recipes[recipe_num].ingredients
		if recipe_passed:
			food_result=possible_recipes[recipe_num]
	print(food_result.recipe_name)
	return food_result
func remove_specific_food_from_stack(ingredient):
	var player: Player=get_tree().get_first_node_in_group("player")
	for i in player.get_stacked_ingredients().size():
		if player.get_stacked_ingredients()[i].food_name==ingredient:
			player.stack.remove_child(player.get_stacked_ingredients()[i])
			break
func add_food_to_stack(food,quality:float=1):
	var player: Player=get_tree().get_first_node_in_group("player")
	var stacked_ingredient=preload("res://food/food_stack/stacked_ingredient.tscn")
	var ingredient_stack=player.bowl.find_child("Stack")
	var food_type: Food = load("res://food/foods/"+str(food)+".tscn").instantiate()
	
	var new_stacked_ingredient: StackedIngredient =stacked_ingredient.instantiate()
	ingredient_stack.add_child(new_stacked_ingredient)
	
	new_stacked_ingredient.stack_number=ingredient_stack.get_child_count()
	new_stacked_ingredient.height=food_type.stack_sprite.texture.get_height()*food_type.stack_sprite.scale.y
	new_stacked_ingredient.food_quality=quality
	new_stacked_ingredient.food_name=food
	food_type.stack_sprite.reparent(new_stacked_ingredient)
	food_type.stack_sprite.position=Vector2(0,-(food_type.stack_sprite.texture.get_height()*food_type.stack_sprite.scale.y)/2)
	food_type.stack_sprite.rotation=0
func add_recipe(recipe: String):
	return load("res://recipes/"+recipe+".tres")
func add_time(seconds,minutes):
	time_left+=seconds+(minutes*60)
	
