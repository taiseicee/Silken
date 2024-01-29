extends DialogForced

func _ready():
	dialog = [
		"Oh? You're a young Silk Given aren't you? I find your presence reassuing.",
		
		"You have collected ",
		
		"While you are but a newborn, I ask of you to please help your Silk-kin"
	]
	
	if globals.cocoon_count == 1: 
		dialog[1] += "1 cocoon so far..."
	else:
		dialog[1] += str(globals.cocoon_count) + " of my cocoons so far... "
	
	if globals.cocoon_count <= 0:
		dialog[1] += "Hmm. Well I guess your survival is what is most important."
	elif globals.cocoon_count < 3:
		dialog[1] += "Good Work, Silken Warrior!"
	else:
		dialog[1] += "Excellent Work, Silken Warrior! Your skills are very promising indeed."
