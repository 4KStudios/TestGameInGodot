extends Control

func _on_side_scroller_pressed():
	get_tree().change_scene_to_file("res://Scenes/SideScroller.tscn")


func _on_top_down_pressed():
	get_tree().change_scene_to_file("res://Scenes/TopDown.tcsn")


func _on_exit_pressed():
	get_tree().quit()
