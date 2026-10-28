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
	if !player.foods_carried.is_empty():
		for recipe_num in possible_recipes.size():
			recipe_passed=player.foods_carried==possible_recipes[recipe_num].ingredients
			if recipe_passed:
				food_result=possible_recipes[recipe_num]
	print(food_result.recipe_name)
	return food_result
func remove_food_from_stack(ingredient):
	var player: Player=get_tree().get_first_node_in_group("player")
	var ingredient_stack=player.bowl.find_child("Stack")
	if player.food_stack_order.has(ingredient):
		#Find which ingredient to delete
		var ingredient_number=0 #Number to be deleted in array
		for i in player.food_stack_order.size():
			if player.food_stack_order[i]==ingredient: ingredient_number=i
		#Remove ingredient from stack
		player.food_stack_order.remove_at(ingredient_number)
		ingredient_stack.get_child(ingredient_number).remove()
		#Food Dictionary Manager
		player.foods_carried[ingredient]-=1
		if player.foods_carried[ingredient]<=0:
			player.foods_carried.erase(ingredient)
		print(player.food_stack_order)
func add_food_to_stack(food):
	var player: Player=get_tree().get_first_node_in_group("player")
	var ingredient_display=preload("res://food/food_stack/ingredient_stack_display.tscn")
	var ingredient_stack=player.bowl.find_child("Stack")
	var food_type: Food = load("res://food/foods/"+str(food)+".tscn").instantiate()
	
	var new_ingredient_display=ingredient_display.instantiate()
	ingredient_stack.add_child(new_ingredient_display)
	new_ingredient_display.stack_number=ingredient_stack.get_child_count()
	new_ingredient_display.height=food_type.stack_sprite.texture.get_height()*food_type.stack_sprite.scale.y
	food_type.stack_sprite.reparent(new_ingredient_display)
	food_type.stack_sprite.position=Vector2(0,-(food_type.stack_sprite.texture.get_height()*food_type.stack_sprite.scale.y)/2)
	food_type.stack_sprite.rotation=0
	
	player.food_stack_order.insert(player.food_stack_order.size(),food)
	if player.foods_carried.has(food):
		player.foods_carried[food]+=1
	else:
		player.foods_carried[food]=1
func add_recipe(recipe: String):
	return load("res://recipes/"+recipe+".tres")
func add_time(seconds,minutes):
	time_left+=seconds+(minutes*60)
