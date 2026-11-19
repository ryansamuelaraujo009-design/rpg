extends Node
## GameManager — estado global da partida e pausa.

var is_paused := false
var current_region_id := ""


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	# Teste de fumaça executado apenas quando solicitado por variável de ambiente:
	#   RPG_SMOKE_TEST=1 godot --headless --path projeto-rpg
	if OS.get_environment("RPG_SMOKE_TEST") == "1":
		_run_smoke_test.call_deferred()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		toggle_pause()
	elif event.is_action_pressed("quick_save"):
		SaveManager.save_game()
	elif event.is_action_pressed("quick_load"):
		SaveManager.load_game()


func toggle_pause() -> void:
	is_paused = not is_paused
	get_tree().paused = is_paused
	EventBus.toast_requested.emit("PAUSADO" if is_paused else "RETOMADO")


func _run_smoke_test() -> void:
	## Validações da Fase 0 (ver README). Roda em modo normal do jogo,
	## onde os autoloads existem — não funciona com --script isolado.
	await get_tree().process_frame
	await get_tree().process_frame

	var failures: Array = []
	var player := get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		failures.append("player ausente")
	else:
		for child_name in ["Health", "Stamina", "Hurtbox"]:
			if player.get_node_or_null(child_name) == null:
				failures.append("componente ausente: " + child_name)
		player.global_position = Vector2(123, 456)
		SaveManager.save_game()
		player.global_position = Vector2.ZERO
		SaveManager.load_game()
		if player.global_position != Vector2(123, 456):
			failures.append("posição não restaurada: %s" % str(player.global_position))

	var enemies: Array = get_tree().get_nodes_in_group("enemies")
	if enemies.size() < 3:
		failures.append("esperado 3 inimigos, encontrado %d" % enemies.size())

	if failures.is_empty():
		print("SMOKE TEST OK")
		get_tree().quit(0)
	else:
		for f in failures:
			print("SMOKE TEST FALHOU: ", f)
		get_tree().quit(1)
