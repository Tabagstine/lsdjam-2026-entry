extends Node
var seconds_left: float = 0
var possible_recipes: Array[Recipe] = [preload("res://recipes/testing_recipe.tres")]

func get_food_result():
	var player: Player=get_tree().get_first_node_in_group("player")
	var food_result: String = "none"
	var recipe_passed: bool = true
	if !player.foods_carried.is_empty():
		for recipe_num in possible_recipes.size():
			if !recipe_passed: break
			#Cycle through all recipes
			for ingredient_num in possible_recipes[recipe_num].ingredients.size():
				#Cycle through all ingredients in recipe
				var current_ingredient = possible_recipes[recipe_num].ingredients.keys()[ingredient_num]
				var current_ingredient_requirement=possible_recipes[recipe_num].ingredients.get(current_ingredient)
				recipe_passed=false
				if player.foods_carried.has(current_ingredient):
					if player.foods_carried.get(current_ingredient)==current_ingredient_requirement:
						recipe_passed=true
					
			if recipe_passed:
				food_result=possible_recipes[recipe_num].recipe_name
	print(recipe_passed)
	print(food_result)
	return food_result
func remove_food_from_stack(food):
	var player: Player =get_tree().get_first_node_in_group("player")
	if player.food_stack_order.has(food):
		var food_number=0
		for i in player.food_stack_order.size()-1:
			if player.food_stack_order[player.food_stack_order.size()-(i+1)]==food:
				food_number=player.food_stack_order.size()-(i+1)
		player.food_stack_order.remove_at(food_number)
		player.foods_carried[food]-=1
		print(player.food_stack_order)
