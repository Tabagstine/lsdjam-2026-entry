extends Marker2D
var desired_order: Array[int]

func _process(_delta: float) -> void:
	fix_ordering_issues()
	set_ingredient_positions()
func fix_ordering_issues():
	desired_order=[]
	for i in get_child_count():
		desired_order.insert(0,i+1)
	desired_order.reverse()
	for i in get_child_count():
		if get_children()[i].stack_number!=desired_order[i]:
			get_children()[i].stack_number=desired_order[i]
func set_ingredient_positions():
	for i in get_child_count():
		var child=get_child(i)
		var previous_child=get_child(i-1)
		var final_y=0
		if i!=0:
			final_y=previous_child.position.y-previous_child.height
		child.position.y=lerpf(child.position.y,final_y,0.3)
