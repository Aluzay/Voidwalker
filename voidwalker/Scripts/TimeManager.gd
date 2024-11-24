extends Node

var elapsed_time : float = 0.0
var is_running : bool = false

func _process(delta) -> void:
	if is_running:
		elapsed_time += delta
		#print("Elapsed time: ", elapsed_time)

func start_timer() -> void:
	is_running = true
	print("Timer started")

func stop_timer() -> void:
	is_running = false
	print("Timer stopped at: ", elapsed_time)

func reset_timer() -> void:
	elapsed_time = 0.0
	print("Timer reset")
