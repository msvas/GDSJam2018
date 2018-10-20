extends CanvasLayer

export(NodePath) var _ifrit = @"../Ifrit"
export(NodePath) var _window_manager = @"../../manager"

onready var window_manager = get_node(_window_manager)
onready var ifrit = get_node(_ifrit)

var humans_to_kill = 0
var humans_killed = 0

func _ready():
	var humankind = get_tree().get_nodes_in_group("human")
	
	for human in humankind:
		human.connect("dead", self, "human_died")
	
	humans_to_kill = humankind.size()
	

func _process(delta):
	update_HUD()
	decrease_fuel(delta)

func decrease_fuel(delta):
	var fuel_decrease = ifrit.get_attribute("fuel_consumption")
	var actual_fuel = ifrit.get_attribute("fuel")
	
	actual_fuel -= fuel_decrease * delta
	
	ifrit.set_attribute("fuel", actual_fuel)
	
	if actual_fuel <= 0:
		window_manager.game_over()

func update_HUD():
	$"FireMeter".value = ifrit.get_attribute("fuel")
	$"humans_killed".text = str(humans_killed) + "/" + str(humans_to_kill)

func human_died():
	humans_killed += 1
	
	if humans_killed == humans_to_kill:
		window_manager.game_won()
