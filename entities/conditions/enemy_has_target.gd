extends ConditionLeaf

func tick(actor: Node, blackboard: Blackboard) -> int:
	if !actor.has_target():
		return SUCCESS
	else:
		return FAILURE
