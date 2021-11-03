extends Node2D

class_name Item

export var _mergeable :bool;
export var _name :String;
var selected = false;
var _initial_position :Vector2;

var _mouse_over = false;

func _ready():
	_initial_position = self.position

func _on_Area2D_mouse_entered():
	_mouse_over = true;

func _on_Area2D_mouse_exited():
	_mouse_over = false;

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		if _mergeable:
			selected = true
		else:
			GameEvents.emit_signal("item_gathered", _name)
			self.queue_free()

func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false
			self.position = _initial_position


func _on_Area2D_area_entered(area):
	if self._name == "Pick Head" and area.get_parent()._name == "Wood Handle":
		area.get_parent().queue_free()
		self.queue_free()
		GameEvents.emit_signal("reduce_count", 2)
		GameEvents.emit_signal("item_gathered", "Pick Axe")
