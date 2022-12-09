/// @description deal with sequences by state

// Control Sequences
switch sequenceState {
	case seqState.playing: {
		global.playerControl = false;	
	}; break;
	case seqState.finished: {
		// remove sequence
		if (layer_sequence_exists(curSeqLayer, curSeq)) {
			layer_sequence_destroy(curSeq);	
		}
		global.playerControl = true;
		sequenceState = seqState.notPlaying;
		curSeq = noone;
		
		// CHeck if PCs are "done
		if(global.gameOver == false) {
			if (instance_exists(obj_npc_baker) && instance_exists(obj_npc_grocer) && instance_exists(obj_npc_teacher)) {
				if (obj_npc_baker.myState == npcState.done && obj_npc_teacher.myState == npcState.done && obj_npc_grocer.myState ==  npcState.done) {
					// Queue up "game over " sequence
					global.playerControl = false;
					alarm[0] = 60;
					// Mark game as won
					global.gameOver = true;
				}
			}
		}
		
	}; break;
}