/**

	native SetPlayerStaff(playerid, bool:tog);
	native AddPlayerXp(playerid, xp);
	native AddPlayerScore(playerid, score);
	native UpPlayerLevel(playerid);
	native DownPlayerLevel(playerid);
	native GetPlayerClass(playerid);
	
**/

//-----------------------------

/* Return <bool> :
	- true : success
	- false : playerid is not logged */
stock SetPlayerStaff(playerid, bool:tog)
{
	if(!IsPlayerLogged(playerid))
		return false;

	PLAYERS[playerid][pStaff] = tog;
	
	return true;
}

//-----------------------------

/* Return <bool> :
	- true : success
	- false : playerid is not logged */
stock AddPlayerXp(playerid, xp)
{
	if(!IsPlayerLogged(playerid))
		return false;
		
	if(!IsPlayerMaxLevel(playerid))
	{
		new
			oldxp = PLAYERS[playerid][pXp];
			
		PLAYERS[playerid][pXp] += xp;
		OnPlayerXpChange(playerid, oldxp, oldxp + xp);
	}
	
	return true;
}

//-----------------------------

/* Return <bool> :
	- true : success
	- false : playerid is not logged */
stock AddPlayerScore(playerid, score)
{
	if(!IsPlayerLogged(playerid))
		return false;
		
	new
		oldscore = PLAYERS[playerid][pScoreDG];
		
	PLAYERS[playerid][pScoreDG] += score;
	OnPlayerScoreChange(playerid, oldscore, oldscore + score);
	
	return true;
}

//-----------------------------

/* Return <bool> :
	- true : success
	- false : playerid is not logged */
stock AddPlayerKill(playerid)
{
	if(!IsPlayerLogged(playerid))
		return false;
		
	PLAYERS[playerid][pKillsDG]++;
	
	return true;
}

//-----------------------------

/* Return <bool> :
	- true : success
	- false : playerid is not logged */
stock AddPlayerDeath(playerid)
{
	if(!IsPlayerLogged(playerid))
		return false;
		
	PLAYERS[playerid][pDeathsDG]++;
	
	return true;
}

//-----------------------------

/* Return <bool> :
	- true : success
	- false : playerid is not logged or it is already at max level */
stock UpPlayerLevel(playerid)
{
	if(!IsPlayerLogged(playerid))
		return false;
		
	if(IsPlayerMaxLevel(playerid))
		return false;
		
	PLAYERS[playerid][pLevel]++;
	OnPlayerLevelChange(playerid, PLAYERS[playerid][pLevel]-1, PLAYERS[playerid][pLevel]);
	
	return true;
}

//-----------------------------

/* Return <bool> :
	- true : success
	- false : playerid is not logged or it is already at level 1 */
stock DownPlayerLevel(playerid)
{
	if(!IsPlayerLogged(playerid))
		return false;
		
	if(PLAYERS[playerid][pLevel] == 1)
		return false;
		
	PLAYERS[playerid][pLevel]--;
	OnPlayerLevelChange(playerid, PLAYERS[playerid][pLevel], PLAYERS[playerid][pLevel]-1);
	
	return true;
}

//-----------------------------

/* Return <value> :
	- -1 : playerid is not logged
	- otherwise : the class id */
stock GetPlayerClass(playerid)
{
	if(!IsPlayerLogged(playerid))
		return 0;
	
	return PLAYERS[playerid][pClass];
	
	// Ternary : 
	// return IsPlayerLogged(playerid) ? PLAYERS[playerid][pClass] : -1;
}