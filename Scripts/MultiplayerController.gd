extends Control

@export var Address = "127.0.0.1"
@export var port = 8910
var peer
var gameReady = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
	if "--server" in OS.get_cmdline_args():
		host_game()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Called on the server and client
func peer_connected(id):
	gameReady = true
	print("Player Connected " + str(id))

# Called on the server and client
func peer_disconnected(id):
	gameReady = false
	print("Player Disconnected " + str(id))
	GameManager.Players.erase(id)
	var players = get_tree().get_nodes_in_group("Player")
	for i in players:
		if i.name == str(id):
			i.queue_free()

# Called only from client
func connected_to_server():
	print("Connected to Server!")
	SendPlayerInformation.rpc_id(1, $LineEdit.text, multiplayer.get_unique_id())

# Called only from client
func connection_failed():
	print("Couldn't Connect!")

@rpc("any_peer")
func SendPlayerInformation(name, id):
	var player_exists = false
	if GameManager.get_player_by_id(id):
		player_exists = true

	if !player_exists:
		GameManager.add_player(name, id)

	if multiplayer.is_server():
		for player in GameManager.Players:
			SendPlayerInformation.rpc(player.name, player.id)


@rpc("any_peer","call_local")
func StartGame():
	var scene = load("res://testscene.tscn").instantiate()
	get_tree().root.add_child(scene)
	self.hide()

func host_game():
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, 2)
	if error != OK:
		print("Cannot host: " + error)
		return
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)

	multiplayer.set_multiplayer_peer(peer)
	print("Waiting for Players!")

func _on_host_button_down() -> void:
	$Feed.text = "Hosting Session"
	AudioLoader.play_sound("save")
	host_game()
	SendPlayerInformation($LineEdit.text, multiplayer.get_unique_id())
	pass # Replace with function body.


func _on_join_button_down() -> void:
	$Feed.text = "Joining Session"
	AudioLoader.play_sound("btn")
	peer = ENetMultiplayerPeer.new()
	peer.create_client(Address, port)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)
	
	pass # Replace with function body.


func _on_start_game_button_down() -> void:
	if gameReady:
		AudioLoader.play_sound("btn")
		StartGame.rpc()
	pass # Replace with function body.
