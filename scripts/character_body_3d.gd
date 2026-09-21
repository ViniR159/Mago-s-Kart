extends CharacterBody3D

var categorias

@onready var mapa = $"../Mapa/colisoes"
@onready var vlc_linhas =  $effectSpeed/ColorRect
@onready var sprites = $AnimatedSprite3D

var gravidade = 15
var categoria = "drift"

var vlc = 0.0
var vlcMax
var aceleracao
var freiagem

var direcao_kart = Vector3.ZERO
var direcao_movimento = Vector3.ZERO

var drift
var driftatv = false
var tempo_drift = 0
var boost = false
var boost_tempo
var boost_forca

var combo = []
var tempo_combo = 3
var mana = 100

var volta_atual = 1
var ponto = false

func carregar_categorias():
	var arquivo = FileAccess.open(
		"res://atributos.json",
		FileAccess.READ
	)

	var texto = arquivo.get_as_text()
	var dados = JSON.parse_string(texto)

	return dados


func _ready():
	categorias = carregar_categorias()

	var cat = categorias[categoria]

	vlcMax = cat["vlcMax"]
	aceleracao = cat["aceleracao"]
	freiagem = cat["freiagem"]
	drift = cat["drift"]
	boost_forca = cat["boost_forca"]

func _physics_process(delta):
	
	var posicao = global_position + Vector3.DOWN * 0.5
	var posicao_local = mapa.to_local(posicao)
	var celula = mapa.local_to_map(posicao_local)
	celula.y = 0
	var tile = mapa.get_cell_item(celula)
	
	if tile == 1:
		vlcMax -= 7.0
	
	if not is_on_floor():
		velocity.y -= gravidade * delta
	
	
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
			sprites.frame = 2
	elif Input.is_action_pressed("direita"):
		if not driftatv:
			rotation.y -= 1 * delta
		else:
			rotation.y -= 2 * delta
			sprites.frame = 1
	elif not driftatv:
		sprites.frame = 0
				
	if Input.is_action_just_pressed("drift") and is_on_floor():
		velocity.y = 2.5
		
	direcao_kart = -transform.basis.z

	if driftatv and vlc > 0:
		direcao_movimento = direcao_movimento.lerp(
			direcao_kart,
			drift * delta
		)
		tempo_drift += delta

	else:
		direcao_movimento = direcao_kart
		
	if tempo_drift > 3 and not driftatv:
		boost = true
		boost_tempo = 1.0
		vlc = move_toward(boost_forca, boost_forca, 20)
		vlc = move_toward(vlc, vlcMax, aceleracao * delta)
		tempo_drift = 0
	elif drift > 0 and not driftatv:
		tempo_drift = 0
		vlcMax = 15.0
		
	if boost:
		boost_tempo -= delta
		vlc_linhas.visible = true
		if boost_tempo <= 0:
			vlc_linhas.visible = false
			boost = false
	else:
		vlc_linhas.visible = false
		
	velocity.z = direcao_movimento.z * vlc
	velocity.x = direcao_movimento.x * vlc

		
	move_and_slide()
	
	if Input.is_action_just_pressed("botao1"):
		combo.append("A")
		tempo_combo = 1.5
		
	if Input.is_action_just_pressed("botao2"):
		combo.append("B")
		tempo_combo = 1.5
		
	if Input.is_action_just_pressed("botao3"):
		combo.append("C")
		tempo_combo = 1.5
		
	if Input.is_action_just_pressed("botao4"):
		combo.append("D")
		tempo_combo = 1.5
				
	if combo == ["A", "B", "C", "D"] and mana >= 30:
		mana -= 30
		spawn("res://cenas_obj/magia_gelo.tscn", "atk")
		combo.clear()
	if combo == ["D", "C", "B", "A"] and mana >= 30:
		mana -= 20
		spawn("res://cenas_obj/cristal.tscn", "def")
		combo.clear()
		
	if combo != []:
		tempo_combo -= delta
		if tempo_combo <= 0:
			combo.clear()
			print("limpou")
			
	if tile == 6:
		ponto = true
	if ponto and tile == 5:
		volta_atual += 1
		ponto = false
		
	if volta_atual == 3:
		pass
		
func spawn(magias, tipo) -> void:
	var magia = load(magias).instantiate()
	
	if tipo == "atk":
		get_parent().add_child(magia)
	else:
		add_child(magia)

	magia.global_position = global_position
	magia.global_rotation = global_rotation
	
	
func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("Mana"):
		mana += 30
		area.get_parent().queue_free()
