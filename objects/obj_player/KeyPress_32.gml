/// @description TextBox test

var _text, _seq;

// Create a Textbox if NPC is nearby
if (global.playerControl = true) {
	if (nearbyNPC) {
		// If NPC is still available
		if (nearbyNPC.myState = npcState.normal) {
			if (hasItem == noone || hasItem == undefined) {
				_text = nearbyNPC.myText;
				if(!instance_exists(obj_textbox)) {
					iii = instance_create_depth(nearbyNPC.x,nearbyNPC.y-400, -10000, obj_textbox);
					iii.textToShow = _text;
				}
			}
			if (hasItem != noone && instance_exists(hasItem)) {
				// If a player has correct item
				if (hasItem.object_index == nearbyNPC.myItem) {
					audio_play_sound(snd_iGiveYou,1,0);
					speakWord = hasItem.mekSound;
					alarm[2] = hasItem.lengthMekSound;
					_text = nearbyNPC.itemTextHappy;
					_seq = nearbyNPC.sequenceHappy;
					
					// Remove the correct item and mark NPC as donoe
					alarm[1] = 10;
				}
				// Or if player has incorrect item
				else {
					_text = nearbyNPC.itemTextSad;
					_seq = nearbyNPC.sequenceSad;
				}
				if (!instance_exists(obj_textbox)) {
					// Create Textbox
					iii = instance_create_depth(nearbyNPC.x,nearbyNPC.y-400, -10000, obj_textbox);
					iii.textToShow = _text;
					iii.sequenceToShow = _seq;
				}
			}
		}
		if (nearbyNPC.myState == npcState.done) {
			_text = nearbyNPC.itemTextDone;
			if(!instance_exists(obj_textbox)) {
				iii = instance_create_depth(nearbyNPC.x,nearbyNPC.y-400, -10000, obj_textbox);
				iii.textToShow = _text;
			}
		}
	}
	// If near an item
	if(nearbyItem && !nearbyNPC) {
		if (hasItem == noone || hasItem == undefined) {
			global.playerControl = false;
			myState = playerState.pickingUp;
			image_index = 0;
			hasItem = nearbyItem;
			//take into account the weight of the item we are picking up.
			carryLimit = hasItem.itemWeight * 0.1;
			with (hasItem) {
				myState = itemState.taken;
			}
			audio_play_sound(snd_takePickup,1,0);
			speakWord = nearbyItem.alutiiqSound;
			alarm[2] = nearbyItem.lengthSound;
			
		}
	}
	// If not near NPC or item, put thing down
	if(!nearbyItem && !nearbyNPC) {
		// Put down
		if (hasItem != noone) {
			myState = playerState.puttingDown;
			image_index = 0;
			global.playerControl = false;
			//Change state of item we are carrying
			with (hasItem) {
				putDownY = obj_player.y+5;
				myState = itemState.puttingBack;
			}
			// Play down sound
			audio_play_sound(snd_putDown,1,0);
			speakWord = hasItem.alutiiqSound;
			alarm[2] = hasItem.lengthSound;
			//reset item
			hasItem = noone;
		}
	}
}
