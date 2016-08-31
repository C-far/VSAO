Player::TakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	if(weaponid != WEAPON_RIFLE) return true;
	
	PLAYERS[playerid][pHealth] -= 100.0;
	SetPlayerHealth(playerid, PLAYERS[playerid][pHealth]);

	return true;
}