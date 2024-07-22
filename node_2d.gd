extends Node2D

# saved message (log when launched)
var saved_message = "Hello, World!"
var last_saved_date = null

func _ready():
	# if json exists, load save data
	if ResourceLoader.exists("user://save.json"):
		var f = FileAccess.open("user://save.json", FileAccess.READ)
		var txt = f.get_as_text()
		var dict = JSON.parse_string(txt)
		if dict != null:
			saved_message = dict["message"]
			last_saved_date = dict["date"]
		else:
			print("error parsing json")
		f.close()

		# log the saved message
		print("data loaded")
		print("saved message: ", saved_message)
		print("last saved date: ", last_saved_date)
	else:
		print("no save data found")


	# save the message
	save_message()

## zero pad a number, like 1 -> 01
func zp(num):
	if num < 10:
		return "0" + str(num)
	else:
		return str(num)

func save_message():
	# save the message
	var dict = {}
	var date = Time.get_date_dict_from_system()
	var time = Time.get_time_dict_from_system()
	var date_str = str(date.year) + "-" + zp(date.month) + "-" + zp(date.day) + " " + zp(time.hour) + ":" + zp(time.minute) + ":" + zp(time.second)
	# save the message and the date
	dict["message"] = "Saved at " + date_str
	dict["date"] = date_str
	var f = FileAccess.open("user://save.json", FileAccess.WRITE)
	f.store_string(JSON.stringify(dict))
	f.close()

	print("data saved")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
