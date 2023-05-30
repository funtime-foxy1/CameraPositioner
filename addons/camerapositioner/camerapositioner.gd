@tool
extends EditorPlugin

const mainPanel = preload("window.tscn")
var inst

func _enter_tree():
	inst = mainPanel.instantiate()
	get_editor_interface().get_editor_main_screen().add_child(inst)
	_make_visible(false)
	
	get_editor_interface().get_selection().connect("selection_changed", selectionchanged)
	
	pass

func _process(delta):
	if inst:
		inst.currentSceneWithCamera = getOpen3DScene()

func getOpen3DScene():
	var opens = get_editor_interface().get_open_scenes()
	var open3DSpace
	for i in opens:
		var node:Node = load(i).get_local_scene()
		if node is Node3D:
			open3DSpace = node
			break
	if not open3DSpace: return null
	
	return open3DSpace

func selectionchanged():
	if get_editor_interface().get_selection().get_selected_nodes().size() == 0:
		return
	inst.on_selection_changed(get_editor_interface().get_selection().get_selected_nodes()[0])

func _exit_tree():
	if inst:
		inst.queue_free()
	pass

func _has_main_screen():
	return true

func _make_visible(visible):
	if inst:
		inst.visible = visible

func _get_plugin_name():
	return "Camera Pos."

func _get_plugin_icon():
	var gui = get_editor_interface().get_base_control()
	var load_icon = gui.get_theme_icon("Camera3D", "EditorIcons")
	return load_icon #get_editor_interface().get_base_control().get_theme_icon("Node", "EditorIcons")
