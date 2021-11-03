extends Node2D

var exit_arrow = load("res://1x/Exit Arrow.png");
var exit_area :bool;

export (NodePath) onready var _north_wall = get_node("NorthWall") as Node2D
export (NodePath) onready var _east_wall = get_node("EastWall") as Node2D
export (NodePath) onready var _south_wall = get_node("SouthWall") as Node2D
export (NodePath) onready var _west_wall = get_node("WestWall") as Node2D

func _ready():
	GameEvents.connect("update_view",self,"update_view")

func update_view(_wall_pointer):
	if _wall_pointer == 0:
		_north_wall.visible = true;
		_west_wall.visible = false;
		_east_wall.visible = false;
	elif _wall_pointer == 1:
		_north_wall.visible = false;
		_south_wall.visible = false;
		_east_wall.visible = true;
	elif _wall_pointer == 2:
		_south_wall.visible = true;
		_west_wall.visible = false;
		_east_wall.visible = false;
	else:
		_north_wall.visible = false;
		_west_wall.visible = true;
		_south_wall.visible = false;


func _on_Area2D_mouse_entered():
	exit_area = true;
	Input.set_custom_mouse_cursor(exit_arrow)


func _on_Area2D_mouse_exited():
	exit_area = false;
	Input.set_custom_mouse_cursor(null)

func _input(event):
	if exit_area and event.is_pressed() and event.button_index == BUTTON_LEFT:
		if _north_wall.visible:
			GameEvents.emit_signal("change_rooms",1)
		elif _east_wall.visible:
			GameEvents.emit_signal("change_rooms",2)
		elif _south_wall.visible:
			GameEvents.emit_signal("change_rooms",3)
		elif _west_wall.visible:
			GameEvents.emit_signal("change_rooms",4)
