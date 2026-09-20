extends CharacterBody3D

@onready var mapa = $"../Mapa/colisoes"
@onready var vlc_linhgas = $"$effectSpeed/ColorRect"

var gravidade = 15

var vlc = 0.0
var vlcMax = 15.0
var aceleracao = 5.0
var freiagem = 15.0

var direcao_kart = Vector3.ZERO
var direcao_movimento = Vector3.ZERO

var drift = 0.5
var driftatv = false
var tempo_drift = 0
var boost = false
var boot_forca = 20

var combo = []
var tempo_combo = 3
var mana = 100

func _physics_process(delta):
	
	var posicao = global_position + Vector3.DOWN * 0.5
	var posicao_local = mapa.to_local(posicao)
	var celula = mapa.local_to_map(posicao_local)
	celula.y = 0
	var tile = mapa.get_cell_item(celula)

	if tile == 0:
		vlcMax = 15.0
	
	if tile == 2:
		vlcMax = 7.0
	
	if not is_on_floor():
		velocity.y -= gravidade * delta
	
	if not boost:
		
		driftatv = Input.is_action_pressed("drift")
		
		if Input.is_action_pressed("frente"):

			vlc = move_toward(vlc, vlcMax, aceleracao * delta)

		elif Input.is_action_pressed("tras"):

			vlc = move_toward(vlc, -vlcMax, aceleracao * delta)

		else:

			vlc = move_toward(
				vlc,
				0,
				freiagem * delta
			)

		if Input.is_action_pressed("esquerda"):
			if not driftatv:
				rotation.y += 1 * delta
			else:
				rotation.y += 2 * delta

		if Input.is_action_pressed("direita"):
			if not driftatv:
				rotation.y -= 1 * delta
			else:
				rotation.y -= 2 * delta

	if Input.is_action_just_pressed("drift") and is_on_floor():
		vlcMax = 10.0
		velocity.y = 2.5
		
	direcao_kart = -transform.basis.z

	if driftatv and vlc > 0:
		direcao_movimento = direcao_movimento.lerp(
			direcao_kart,
			drift * delta
		)
		tempo_drift += delta
		#print(tempo_drift)

	else:
		direcao_movimento = direcao_kart
		
	if tempo_drift > 3 and not driftatv:
		boost = true
		vlc = move_toward(boot_forca, boot_forca, 20)
		vlc = move_toward(vlc, vlcMax, aceleracao * delta)
		tempo_drift = 0
		boost = false
	elif drift > 0 and not driftatv:
		tempo_drift = 0
		vlcMax = 15.0
		
	velocity.z = direcao_movimento.z * vlc
	velocity.x = direcao_movimento.x * vlc

		
	move_and_slide()
	
	if Input.is_action_just_pressed("botao1"):
		combo.append("A")
		tempo_combo = 3
		
	if Input.is_action_just_pressed("botao2"):
		combo.append("B")
		tempo_combo = 3
		
	if Input.is_action_just_pressed("botao3"):
		combo.append("C")
		tempo_combo = 3
		
	if Input.is_action_just_pressed("botao4"):
		combo.append("D")
		tempo_combo = 3
				
	if combo == ["A", "B", "C", "D"] and mana >= 30:
		mana -= 30
		spawn("res://cenas_obj/magia_gelo.tscn")
		combo.clear()
	
	if combo != []:
		tempo_combo -= delta
		if tempo_combo <= 0:
			combo.clear()
			print("limpou")
		

func spawn(magias) -> void:
	var magia = load(magias).instantiate()
	get_parent().add_child(magia)
	magia.global_position = global_position
	magia.global_rotation = global_rotation
	
func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("Mana"):
		mana += 30
		area.get_parent().queue_free()
