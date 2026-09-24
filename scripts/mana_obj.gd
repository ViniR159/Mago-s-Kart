extends MeshInstance3D

var tempo = 1
var para_cima = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if tempo >= 0 and para_cima:
		tempo -= delta
		position.y += randf_range(0.001, 0.005)
	elif tempo >= 0 and !para_cima:
		tempo -= delta
		position.y -= randf_range(0.001, 0.005)
		
	if tempo <= 0 and para_cima:
		para_cima = false
		tempo = 1
	elif tempo <= 0 and !para_cima:
		para_cima = true
		tempo = 1
	
