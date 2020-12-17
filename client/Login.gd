extends Node2D

func _on_Button_pressed():
	get_tree().call_group("global", "on_pressed_login", $CanvasLayer/ColorRect/Container/InputUsername.text, $CanvasLayer/ColorRect/Container/InputPassword.text)

func get_login_error_message(message):
	$CanvasLayer/ColorRect/Message.modulate = Color(0.46, 0.14, 0.14, 1)
	$CanvasLayer/ColorRect/Message.text = message
	
func get_login_success_message(message):
	$CanvasLayer/ColorRect/Message.modulate = Color(0.50, 0.70, 0.30, 1)
	$CanvasLayer/ColorRect/Message.text = message


func _on_Register_pressed():
	get_tree().call_group("global", "on_pressed_register", $CanvasLayer/ColorRect/Container/InputUsername.text, $CanvasLayer/ColorRect/Container/InputPassword.text)
