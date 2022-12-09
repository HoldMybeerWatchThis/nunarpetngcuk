/// @description Destroy me and do things

// Return control to player if no Sequence to load
if (sequenceToShow == noone) {
	global.playerControl = true;
	}
	
// Create Sequence if appropriate
if (sequenceToShow != noone) {
	// Play NPC sequence
	scr_playSequence(sequenceToShow);
	}
	
// Destroy me
instance_destroy();