/// @description Play Delayed sounds for what is picked up or put down

if (speakWord != noone && instance_exists(speakWord)) {
	//destroy the item
	audio_play_sound(speakWord,1,0);
	speakWord = noone;
} 
