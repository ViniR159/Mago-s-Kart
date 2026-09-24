extends MeshInstance3D

@onready var player: CharacterBody3D = $"../../Player" as CharacterBody3D
var tempo = 5

func _process(delta: float) -> void:
	if player.effect == "":
		player.effect = "cristal"
		tempo -= delta
		if tempo <= 0:
			queue_free()
