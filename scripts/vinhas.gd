extends MeshInstance3D

@onready var  player: CharacterBody3D = $"../Player" as CharacterBody3D

var tempo = 4.5
var atv = false
var tempo_planado = 15
var tempo_lancamento = 0.02

	
func _process(delta: float) -> void:
	if tempo_lancamento >= 0:
		position.y -= 0.1
		tempo_lancamento -= delta
		
	if atv:
		tempo -= delta

	tempo_planado -= delta
	if tempo_planado <= 0:
		queue_free()
	
	if tempo <= 0:
		queue_free()


func _on_area_3d_area_entered(area: Area3D)-> void:
	if area.is_in_group("Player") and tempo_lancamento <= 0:
		if player.effect == "":
			atv = true
			player.vlc = 0
			player.effect = "paralizado"
			player.tempo_effect = 4.5
			position.y += 0.09
	if area.is_in_group("def") and tempo_lancamento <= 0:
		queue_free()
		area.get_parent().queue_free()
		
