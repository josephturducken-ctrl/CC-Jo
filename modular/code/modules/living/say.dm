/mob/proc/check_subtler(message, forced)
	if((forced_psay && !absorbed) || copytext_char(message, 1, 2) == "@") //Caustic Edit - Attempting to add Forced Psay using our subtle system
		if(message == "@")
			return
		emote("subtle", message = copytext_char(message, 2), intentional = !forced, custom_me = TRUE)
		return 1
