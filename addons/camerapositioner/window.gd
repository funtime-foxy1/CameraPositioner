@tool
extends MarginContainer

var currentNode

var selectedNode

var shouldCameraFollow = false
var currentSceneWithCamera:Node3D

var shouldPrint = true

func on_selection_changed(node:Node):
	currentNode = node

func _process(delta):
	if selectedNode:
		$TabContainer/General/shouldStart.disabled = false
	else:
		$TabContainer/General/shouldStart.disabled = true
		$TabContainer/General/shouldStart.button_pressed = false
	
	if shouldCameraFollow:
		var childs = currentSceneWithCamera.get_children()
		var cam:Camera3D
		for i in childs:
			if i is Camera3D:
				cam = i
				break
		
		cam.transform = selectedNode.transform

func _on_follow_sellect_toggled(button_pressed):
	if not currentNode is Node3D:
		if shouldPrint:
			push_error("Node " + currentNode.name + " isn't 3D!")
		return
	
	$TabContainer/General/Name.text = "The node " + currentNode.name + " has been selected!"
	selectedNode = currentNode


func _on_should_start_toggled(button_pressed):
	shouldCameraFollow = button_pressed


func _on_check_button_toggled(button_pressed):
	shouldPrint = button_pressed


func _on_rich_text_label_meta_clicked(meta):
	OS.shell_open(meta)
