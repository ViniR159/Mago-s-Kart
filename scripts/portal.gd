extends MeshInstance3D

@onready var  player: CharacterBody3D = $"../Player" as CharacterBody3D
const vlc = 20
var tempo = 15
var tempo_lancamento = 0.3

func _ready() -> void:
	$AnimatedSprite3D.play()
	
func _process(delta: float) -> void:
	if tempo_lancamento >= 0:
		position += -transform.basis.z * vlc * delta
		position.y += 0.02
		tempo_lancamento -= delta

		
	tempo -= delta
	if tempo <= 0:
		queue_free()


func _on_area_3d_area_entered(area: Area3D) -> void:
	if player.effect == "":
		if area.is_in_group("Player") and tempo_lancamento <= 0:
			player.effect = "confusao"
			player.tempo_effect = 5
	if area.is_in_group("def") and tempo_lancamento <= 0:
		queue_free()
		area.get_parent().queue_free()
			
