/// @description ISorting and other

// Depth, animation
switch myState {
	// If item is sitting on the ground 
	case itemState.idle: {
		depth = -y;	
	}; break;
	// if item has been taken
	case itemState.taken: {
		// Keep track of player position
		var _result = scr_itemPosition();
		x = _result[0];
		y = _result[1];
		depth = _result[2];
	}; break;
	case itemState.puttingBack: {
		// put item back
		y = putDownY;
		myState = itemState.idle
	}; break;
}