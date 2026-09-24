extends MeshInstance3D

@onready var player: CharacterBody3D = $"../../Player" as CharacterBody3D

var tempo = 5.0
var tempo_rastro = 0
var vlcMax = 0
var aceleracao = 0

func _ready() -> void:
	vlcMax = player.vlcMax + 4
	aceleracao = player.aceleracao + 4
	player.boost_tempo = 5.0

func _process(delta: float) -> void:
	tempo -= delta
	tempo_rastro += delta
	
	player.vlcMax = vlcMax
	player.aceleracao = aceleracao
	player.boost = true
	
	if tempo_rastro >= 0.2:
		tempo_rastro = 0
		var rastro = load("res://cenas_obj/mini_fogo.tscn").instantiate()
	
		get_parent().get_parent().add_child(rastro)
		

		rastro.global_position = global_position
		rastro.global_rotation = global_rotation
	
	
	if tempo <= 0:
		player.vlcMax -= 4
		player.aceleracao -= 4
		queue_free()
