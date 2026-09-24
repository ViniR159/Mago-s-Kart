extends MeshInstance3D

var tempo = 2.5

func _process(delta: float) -> void:
	tempo -= delta
	if tempo <= 0:
		queue_free()
