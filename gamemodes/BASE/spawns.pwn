hook OnPlayerSpawn(playerid)
{
	// TEAM :

	switch(MODS[CURRENT_MOD][mType])
	{
		case MOD_TYPE_TEAM:
		{
			if(PLAYERS[playerid][pTeamDG] == NO_TEAM)
			{
				if(MODS[CURRENT_MOD][mTeamMembers][0] < MODS[CURRENT_MOD][mTeamMembers][1])
					AddPlayerToTeam(playerid, 0);
				
				else if(MODS[CURRENT_MOD][mTeamMembers][0] > MODS[CURRENT_MOD][mTeamMembers][1])
					AddPlayerToTeam(playerid, 1);
					
				else
					AddPlayerToTeam(playerid, random(2));
			}
		}
	}
	
	// SPAWN :

	new
		rand = random(MAPS[CURRENT_MAP][mapNbrSpawns]);
		
	FreezeSpawn(playerid);	
		
	SetPlayerPos(playerid, MAPS[CURRENT_MAP][mapSpawnsX][rand], MAPS[CURRENT_MAP][mapSpawnsY][rand], MAPS[CURRENT_MAP][mapSpawnsZ][rand]);
	SetPlayerFacingAngle(playerid, MAPS[CURRENT_MAP][mapSpawnsA][rand]);
	
	SetPlayerVirtualWorld(playerid, CURRENT_MAP);

	// CLASS :
	
	new
		classid = MODS[CURRENT_MOD][mClass] == NO_CLASS ? PLAYERS[playerid][pClass] : MODS[CURRENT_MOD][mClass];
	
	SetPlayerHealth(playerid, PLAYERS[playerid][pHealth] = CLASS[classid][cHealth]);
	GivePlayerWeapon(playerid, CLASS[classid][cWeapID], CLASS[classid][cWeapAmount]);
	
	return 1;
}