extends Node2D

export(NodePath) onready var _left_side = get_node(_left_side) as ColorRect
export(NodePath) onready var _right_side = get_node(_right_side) as ColorRect

export (NodePath) onready var _north_wall = get_node("NorthWall") as Node2D
export (NodePath) onready var _east_wall = get_node("EastWall") as Node2D
export (NodePath) onready var _south_wall = get_node("SouthWall") as Node2D
export (NodePath) onready var _west_wall = get_node("WestWall") as Node2D

export (NodePath) onready var _item = get_node("EastWall/Item") as Node2D

var _wall_pointer = 0
var _left_mouse_entered = false;
var _right_mouse_entered = false;
var _item_entered = false;

func _ready():
	_north_wall.visible = true;

func _on_LeftArea_mouse_entered():
	_left_side.visible = true;
	_left_mouse_entered = true;

func _on_RightArea_mouse_entered():
	_right_side.visible = true;
	_right_mouse_entered = true;

func _on_LeftArea_mouse_exited():
	_left_side.visible = false;
	_left_mouse_entered = false;

func _on_RightArea_mouse_exited():
	_right_side.visible = false;
	_right_mouse_entered = false;


func _on_Area2D_mouse_entered():
	_item_entered = true;

func _on_Area2D_mouse_exited():
	_item_entered = false;


func _input(event):
	if _left_mouse_entered and event.is_pressed() and event.button_index == BUTTON_LEFT:
		_wall_pointer = _wall_pointer - 1
		if(_wall_pointer == -1):
			_wall_pointer = 3
		update_view();
	elif _right_mouse_entered and event.is_pressed() and event.button_index == BUTTON_LEFT:
		_wall_pointer = _wall_pointer + 1
		if(_wall_pointer == 4):
			_wall_pointer = 0
		update_view();
	elif _item_entered and event.is_pressed() and event.button_index == BUTTON_LEFT:
		_item.queue_free();

func update_view():
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
