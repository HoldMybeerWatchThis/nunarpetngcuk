/// @description Player Movement

// Check keys for movement
if (global.playerControl) {
	moveRight = keyboard_check(vk_right);
	moveLeft = keyboard_check(vk_left);
	moveUp = keyboard_check(vk_up);
	moveDown = keyboard_check(vk_down);
}

if (!global.playerControl) {
	moveRight = 0;
	moveLeft = 0;
	moveUp = 0;
	moveDown = 0;
}

// Run with shift key
running = keyboard_check(vk_shift);

// Speed up if running
if (running) {
	// Ramp up 
	if (runSpeed < runMax) {
		runSpeed += 2;	
	}
	// Start Creating Dust
	if (startDust == 0) {
		alarm[0] = 2;
		startDust = 1;
	}
}
// Slow down if no longer running
if (!running) {
	// Ramp down
	if (runSpeed > 0) {
		runSpeed -= 1;	
	}
	startDust = 0;
}

// Calculate Movement 
vx = ((moveRight - moveLeft) * (walkSpeed+runSpeed) * (1-carryLimit));
vy = ((moveDown - moveUp) * (walkSpeed+runSpeed) * (1-carryLimit));

// If Idle
if (vx == 0 && vy == 0) {
	// If i'm not picking up or putting down an item
	if (myState != playerState.pickingUp && myState != playerState.puttingDown) {
		// If i don't have an item
		if (hasItem == noone) {
			myState = playerState.idle;
		}
		// If i'm carrying an item.
		else {
			myState = playerState.carryIdle;
		}
	}
}

// Change direction based on movement.
if (vx != 0 || vy != 0) {
	
	if !collision_point(x+vx,y,obj_par_environment,true,true) {
		x += vx;	
	}
	if !collision_point(x,y+vy,obj_par_environment,true,true) {
		y += vy;	
	}
	
	if (vx > 0) {
		dir = 0;
	}
	if (vx < 0) {
		dir = 2;
	}
	if (vy > 0) {
		dir = 3;
	}
	if (vy < 0) {
		dir = 1;
	}
	
	// Set state.
	// If we don't have an item.
	if (hasItem == noone) {
		myState = playerState.walking;	
	}
	else {
		myState = playerState.carrying;	
	}
}

if (instance_exists(obj_control) && obj_control.sequenceState == seqState.playing) {
	
	// Set Sequence to centre of Camera view
	var _camX = camera_get_view_x(view_camera[0])+floor(camera_get_view_width(view_camera[0])*0.5);
	var _camY = camera_get_view_y(view_camera[0])+floor(camera_get_view_height(view_camera[0])*0.5);
	
	audio_listener_set_position(0,_camX,_camY,0);
}
else {
	audio_listener_set_position(0,x,y,0);
}
	

// Check for Collisions with NPCs
nearbyNPC = collision_rectangle(x-lookRange,y-lookRange,x+lookRange,y+lookRange,obj_par_npc,false,true);
if nearbyNPC {
	if !hasGreeted {
		// Play greeting sound
		audio_play_sound(snd_greeting01,1,0);
		hasGreeted = true;
	}
	// Pop up Prompt
	if (npcPrompt == noone || npcPrompt == undefined) {
		npcPrompt = scr_showPrompt(nearbyNPC,nearbyNPC.x,nearbyNPC.y-460);	
	}
	// do something
	show_debug_message("obj_player has found an NPC");
}
if !nearbyNPC {
	// Reset Greeting
	if hasGreeted {
		hasGreeted = false;	
	}
	// Get rid of prompt
	scr_dismissPrompt(npcPrompt,0);
	
	// do something
	show_debug_message("obj_player hasn't found anything");
}

// Check for Collisions with itemss
nearbyItem = collision_rectangle(x-lookRange,y-lookRange,x+lookRange,y+lookRange,obj_par_item,false,true);
if (nearbyItem && !nearbyNPC) {
	// Pop up Prompt
	if (itemPrompt == noone || itemPrompt == undefined) {
		show_debug_message("obj_player has found an item");
		itemPrompt = scr_showPrompt(nearbyItem,nearbyItem.x,nearbyItem.y-300);	
	}
}
if (!nearbyItem || nearbyNPC) {
	// Get rid of prompt
	scr_dismissPrompt(itemPrompt,1);
}

// If picking up an item
if (myState = playerState.pickingUp) {
	// this checks the current frame number that the animation is playing and whether we are at the end of the animation
	if (image_index >= image_number-1) { 
		myState = playerState.carrying;
		global.playerControl = true;
		image_index = 0;
	}
}

// If putting down an item
if (myState = playerState.puttingDown) {
	// Reset weight
	carryLimit = 0;
	// this checks the current frame number that the animation is playing and whether we are at the end of the animation
	if (image_index >= image_number-1) { 
		myState = playerState.idle;
		global.playerControl = true;
	}
}

// Depth Sorting
depth = -y;

// Auto-choose Sprite based on state and direction
sprite_index = playerSpr[myState][dir];