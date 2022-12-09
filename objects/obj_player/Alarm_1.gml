/// @description deal with objects and NPC states

// Remove Object
if (hasItem != noone && instance_exists(hasItem)) {
	//destroy the item
	with (hasItem) {
		instance_destroy();	
	}
	// Reset my item variables
	hasItem = noone;
	carryLimit=0;
}

// Mark NPC as done
if (nearbyNPC != noone && instance_exists(nearbyNPC)) {
	// Set NPC as done
	with (nearbyNPC) {
		myState = npcState.done;	
	}
}