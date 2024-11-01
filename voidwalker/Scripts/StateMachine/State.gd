extends Node
class_name State

signal Transitioned
signal interrupt_state(new_state_name : String)

func Handle_Input(_event: InputEvent):
	pass

func Enter():
	pass
	
func Exit():
	pass

func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	pass
