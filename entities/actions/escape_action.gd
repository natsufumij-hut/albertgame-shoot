extends ActionLeaf

func tick(actor: Node, blackboard: Blackboard) -> int:
	var target = actor.get_target()
	if target==null:
		actor.set_escape_direct(Vector2.ZERO)
		return SUCCESS
	
	print("escape action")
	var direction: Vector2 = (target.position - actor.position).normalized()
	actor.set_escape_direct(-direction)
	return RUNNING
