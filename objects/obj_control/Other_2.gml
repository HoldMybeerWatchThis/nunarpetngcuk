/// @description Game variables

// Game variables
global.playerControl = true;
townBGMVolume = audio_sound_get_gain(snd_townBGM);
townAmbienceVolume = audio_sound_get_gain(snd_townAmbience);
global.gameOver = false;
global.gameStart = false;

// Player States
enum playerState {
	idle,
	walking,
	pickingUp,
	carrying,
	carryIdle,
	puttingDown,
}

// Item States
enum itemState {
	idle,
	taken,
	used,
	puttingBack,
}

// Sequence states
enum seqState {
	notPlaying,
	waiting,
	playing,
	finished,
}

// Sequence Variables
sequenceState = seqState.notPlaying;
curSeqLayer = noone;
curSeq = noone;

// NPC states
enum npcState {
	normal,
	done,
}