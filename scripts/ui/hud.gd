extends CanvasLayer
## HUD mínimo da Fase 0: barras de vida/fôlego + toast.

@onready var _hp_bar: ProgressBar = $Margin/VBox/HPBar
@onready var _st_bar: ProgressBar = $Margin/VBox/StaminaBar
@onready var _toast: Label = $ToastLabel
@onready var _hint: Label = $HintLabel

var _toast_tween: Tween


func _ready() -> void:
	EventBus.player_health_changed.connect(_on_hp)
	EventBus.player_stamina_changed.connect(_on_st)
	EventBus.toast_requested.connect(show_toast)
	_toast.modulate.a = 0.0


func _on_hp(current: float, max_value: float) -> void:
	_hp_bar.max_value = max_value
	_hp_bar.value = current


func _on_st(current: float, max_value: float) -> void:
	_st_bar.max_value = max_value
	_st_bar.value = current


func show_toast(text: String) -> void:
	_toast.text = text
	if _toast_tween and _toast_tween.is_valid():
		_toast_tween.kill()
	_toast.modulate.a = 1.0
	_toast_tween = create_tween()
	_toast_tween.tween_interval(1.4)
	_toast_tween.tween_property(_toast, "modulate:a", 0.0, 0.5)
