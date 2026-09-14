extends MeshInstance3D

const vlc = 20


func _process(delta: float) -> void:
	position += -transform.basis.z * vlc * delta
