extends Node2D

func _on_Button_pressed():
	get_tree().call_group("global", "on_pressed_login", $CanvasLayer/ColorRect/Container/InputUsername.text, $CanvasLayer/ColorRect/Container/InputPassword.text)

func get_login_error_message(message):
	print('msg: ', message)
	$CanvasLayer/ColorRect/Container/ErrorMessage.text = message
