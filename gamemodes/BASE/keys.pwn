hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(end_game) return 1;

	if(PRESSED(KEY_YES))
		ShowPlayerStats(playerid);
	
	if(RELEASED(KEY_YES))
		HidePlayerStats(playerid);
	
	return 1;
}