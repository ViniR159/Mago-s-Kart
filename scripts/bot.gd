extends CharacterBody3D

var categorias

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


func _physics_process(delta: float) -> void:
	pass
