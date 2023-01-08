extends Node2D


var tutorial_text = "Fact checkers will check info in its area.\nAfter a while, they will be flagged\n as VALID or FAKE NEWS.\nFAKE NEWS will be destroyed (aka. refuted)"


func _ready():
	$fake_news.speed = 0
	$fake_news/verified_fake.visible = true

	$valid_news.speed = 0
	$valid_news/verified_valid.visible = true
