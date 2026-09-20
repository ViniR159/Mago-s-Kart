extends Camera3D

@export var alvo: Node3D

@export var distancia := 2.0
@export var altura := 1.5

@export var suavidade_posicao := 5.0

@export var deslocamento_drift := 1.0

var posicao_drift := 0.0


func _ready():
	if alvo == null:
		alvo = get_parent().get_parent()


func _process(delta):
	if alvo == null:
		return
		
	if alvo.vlc >= 10:
		distancia = 2.2
		altura = 1.7
	else:
		distancia = 1.5
		altura = 1

	if alvo.driftatv:
		posicao_drift = alvo.direcao_kart.x * deslocamento_drift
	else:
		posicao_drift = 0.0

	var posicao_desejada = (
		alvo.global_position
		+ alvo.global_transform.basis.z * distancia
		+ alvo.global_transform.basis.x * posicao_drift
		+ Vector3.UP * altura
	)

	global_position = global_position.lerp(
		posicao_desejada,
		suavidade_posicao * delta
	)

	var ponto_olhar = alvo.global_position + Vector3.UP * 0.5

	look_at(ponto_olhar, Vector3.UP)
