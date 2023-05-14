extends Sprite

var health = 15
var max_health = 15
var attack = 40
var defense = 20

var number = 0
var turn = false
onready var Combat = get_node('/root/Game/Combat')
var actions = ['attack', 'use webs']
var skip = false

func _ready():
	randomize()
	position = Vector2(800,100)

func choose_action():
	var odds = int(randf()*2)
	if odds == 0:
		return 'atk up punch'
	else :
		return 'attack'

func take_action():
	if health > 0 :
		skip = false
		var action = choose_action()
		if action == 'base_attack':
			Global.stats['health'] -= attack/Global.stats['defense']
		elif action == 'atk up punch':
			pass
		print('enemy chose to ' + action)

func damage(d):
	health -= d
	if health <= 0:
		Combat.win = true
