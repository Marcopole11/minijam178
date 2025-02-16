extends Node2D

signal solved
signal wrong

@onready var question: Label = $Container/MarginContainer/Question
@onready var answer_1: Label = $Container/Answer1/MarginContainer2/MarginContainer/Label
@onready var answer_2: Label = $Container/Answer2/MarginContainer2/MarginContainer/Label
@onready var answer_3: Label = $Container/Answer3/MarginContainer2/MarginContainer/Label


var operators = ["+", "-", "*"]
var valuerandomness: int = 20
var rightanswer

func generate_operation():
	
	var operator = operators[randi() % operators.size()]
	var num1 = randi() % valuerandomness * GlobalVariables.dificulty
	var num2 = randi() % valuerandomness * GlobalVariables.dificulty

	var problem = str(num1)+operator+str(num2)
	var expression = Expression.new()
	var error = expression.parse(problem)
	
	if error != OK:
		push_error("error to solve" + problem)
		return null

	var answer = expression.execute()
	var wronganswer1 = answer + randi_range(-10,25)
	var wronganswer2 = answer + wronganswer1 + randi_range(-10,25)
	while wronganswer1 == answer:
		wronganswer1 = answer + randi_range(-10, 25)
	while wronganswer2 == answer or wronganswer2 == wronganswer1:
		wronganswer2 = answer + randi_range(-10, 25)
	
	return {
		"problem": problem,
		"answers": [answer, wronganswer1, wronganswer2]
	}


func _ready() -> void:
	var operation = generate_operation()
	rightanswer = operation["answers"][0]
	
	
	var shuffled_answers = operation["answers"]
	shuffled_answers.shuffle()
	
	question.text = str(operation["problem"])
	answer_1.text = str(shuffled_answers[0])
	answer_2.text = str(shuffled_answers[1])
	answer_3.text = str(shuffled_answers[2])


func _on_answer_1_area_entered(area: Area2D) -> void:
	if area.is_in_group("punch"):
		if answer_1.text == str(rightanswer):
			solved.emit()
			queue_free()
		else:
			wrong.emit()

func _on_answer_2_area_entered(area: Area2D) -> void:
	if area.is_in_group("punch"):
		if answer_2.text == str(rightanswer):
			solved.emit()
			queue_free()
		else:
			wrong.emit()

func _on_answer_3_area_entered(area: Area2D) -> void:
	if area.is_in_group("punch"):
		if answer_3.text == str(rightanswer):
			solved.emit()
			queue_free()
		else:
			wrong.emit()
