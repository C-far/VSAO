// native Start(modid = NO_MOD);
stock Start(modid = NO_MOD)
{
	if(modid == NO_MOD) CURRENT_MOD = modid = Iter_Random(Mod);
	else CURRENT_MOD = modid;

	do CURRENT_MAP = MODS[modid][mMaps][random(MAX_MAPS_PER_MOD)];
	while(CURRENT_MAP == NO_MAP);
	
	static
		str[MAX_SHORT_MOD_NAME + 5];
	
	strunpack(str, MODS[modid][mShortName]);
	strins(str, "MOD: ", 0);
	
	TextDrawSetString(td_current_mod, str);
	
	if(MODS[modid][mType] == MOD_TYPE_TEAM)
	{
		for(new i = 0; i < 2; i++)
		{
			MODS[modid][mTeamMembers][0] = 0;
			MODS[modid][mTeamScores][0] = 0;
		}
		
		foreach(new i : Player)
		{
			PLAYERS[i][pTeamDG] = NO_TEAM;
		}
	}
	
	foreach(new i : Player)
	{
		PLAYERS[i][pVoteMod] = NO_VOTE;
	}
	
	end_game = false;
	
	printf("MOD: %s (%d) > BY: %s", MODS[CURRENT_MOD][mName], CURRENT_MOD, MODS[CURRENT_MOD][mAuthor]);
	printf("MAP: %d > BY: %s", CURRENT_MAP, MAPS[CURRENT_MAP][mapAuthor]);
	
	return true;
}

//-----------------------------

#define SCM_Params (3)

// native SCM(playerid, color, const fmat[], va_args<>);
stock SCM(playerid, color, const fmat[], va_args<>)
{ 
	if(numargs() == SCM_Params) return SendClientMessage(playerid, color, fmat);

    static 
		str[145];
		
	va_format(str, sizeof(str), fmat, va_start<SCM_Params>);    
    return SendClientMessage(playerid, color, str); 
}  

//-----------------------------

#define SCMTA_Params (2)

// native SCMTA(color, const fmat[], va_args<>);
stock SCMTA(color, const fmat[], va_args<>)
{ 
	if(numargs() == SCMTA_Params) 
	{
		foreach(new i : Player)
		{	
			SendClientMessage(i, color, fmat);
		}
		
		return true;
	}

    static 
		str[145];
		
	va_format(str, sizeof(str), fmat, va_start<2>);    
	
	foreach(new i : Player)
	{
		SendClientMessage(i, color, str);
	}
	
    return true;
}

//-----------------------------

#define GTFP_Params (4)

// native GTFP(playerid, const fmat[], time, style, va_args<>);
stock GTFP(playerid, const fmat[], time, style, va_args<>)
{
	if(numargs() == GTFP_Params) return GameTextForPlayer(playerid, fmat, time, style);

    static 
		str[145];
		
	va_format(str, sizeof(str), fmat, va_start<GTFP_Params>);    
    return GameTextForPlayer(playerid, str, time, style);
}

//-----------------------------

// native LoadWhitelist();
stock LoadWhitelist()
{
	new
		File:file = fopen("whitelist.ini"),
		str[2];
		
	fread(file, str);
	whitelist = !!strval(str);
		
	fclose(file);
}

//-----------------------------

// native IsUsernameWhitelisted(const name[]); 
stock IsUsernameWhitelisted(const name[])
{		
	static
		req[128],
		Cache:result,
		exist;
		
	mysql_format(mysql, req, sizeof(req), "SELECT Username FROM Whitelist WHERE Username = '%e'", name);
	result = mysql_query(mysql, req); // my bad :(
	
	exist = cache_get_row_count();
	cache_delete(result);
	
	return exist;
}

//-----------------------------

// native StripsNewLine(string[]);
stock StripsNewLine(string[]) 
{
	new 
		l = strlen(string) - 1;
		
	if(string[0] != EOS)
	{
		if((string[l] == '\n') || (string[l] == '\r')) 
		{
			string[l--] = 0;
			
			if((string[l] == '\n') || (string[l] == '\r')) 
				string[l] = 0;
		}
	}
}

//-----------------------------

// native KickWithMessage(playerid, color, const string[]);
stock KickWithMessage(playerid, color, const string[])
{
	SCM(playerid, color, string);
	SetTimerEx("Timer_Kick", 250, false, "i", playerid);
	
	return true;
}

//-----------------------------

// native GetWeaponSlot(weaponid);
stock GetWeaponSlot(weaponid)
{		
	switch(weaponid)
	{
		case 0, 1: return 0;
		case 2 .. 9: return 1; 
		case 22 .. 24: return 2;
		case 25 .. 27: return 3;
		case 28, 29, 32: return 4;
		case 30, 31: return 5;
		case 33, 34: return 6;
		case 35 .. 38: return 7;
		case 16, 18, 39: return 8;
		case 42, 43: return 9;
		case 14: return 10;
		case 44 .. 46: return 11;
		case 40: return 12;
	}
	
	return -1;
}

//-----------------------------

// native UpdatePlayerCommandPermissions(playerid);
stock UpdatePlayerCommandPermissions(playerid)
{
	#pragma unused playerid

	return true;
}

//-----------------------------
		
// native SelectNextMods();
stock SelectNextMods()
{
	for(new i = 0; i < MAX_NEXT_MODS; i++)
	{
		modid_next_mods[i] = NO_MOD;
		votes_next_mods[i] = 0;
	}
	
	if(Iter_Count(Mod) >= MAX_NEXT_MODS)
	{
		new
			modid,
			nbr;
	
		do 
		{
			already:
			modid = Iter_Random(Mod);
			
			for(new i = 0; i < MAX_NEXT_MODS; i++)
				if(modid_next_mods[i] == modid) goto already;
			
			modid_next_mods[nbr++] = modid;
		}
		while(nbr < MAX_NEXT_MODS);
	}
	
	else
	{
		for(new i = 0; i < MAX_NEXT_MODS; i++)
			modid_next_mods[i] = Iter_Random(Mod);
	}
	
	return true;
}

//-----------------------------

// native ShowPlayerStats(playerid, bool:victory = false);
stock ShowPlayerStats(playerid, bool:victory = false)
{
	TextDrawShowForPlayer(playerid, td_background_main);
	
	if(end_game)
	{
		TextDrawHideForPlayer(playerid, td_current_mod);
	
		TextDrawShowForPlayer(playerid, victory ? td_victory : td_defeat);
		
		static
			str[MAX_MOD_NAME + 4];	
		
		#define modid modid_next_mods[i]
		
		for(new i = 0; i < 3; i++)
		{
			format(str, sizeof(str), "%s: %d", MODS[modid][mName], votes_next_mods[i]);
			TextDrawSetString(td_next_mods[i], str);
			TextDrawShowForPlayer(playerid, td_next_mods[i]);
		}
		
		#undef modid
		
		valstr(str, time_endgame);
		TextDrawSetString(td_time_endgame, str);
		TextDrawShowForPlayer(playerid, td_time_endgame);
	}
	
	else
		TextDrawShowForPlayer(playerid, td_current_mod);
	
	TextDrawShowForPlayer(playerid, td_categories);
	
	for(new i = 0; i < MAX_SLOTS; i++)
	{			
		TextDrawShowForPlayer(playerid, td_background[i]);
		TextDrawShowForPlayer(playerid, td_name[i]);
		TextDrawShowForPlayer(playerid, td_score[i]);
		TextDrawShowForPlayer(playerid, td_kills[i]);
		TextDrawShowForPlayer(playerid, td_deaths[i]);
	}
	
	PLAYERS[playerid][pStats] = true;
	
	return true;
}

//-----------------------------

// native HidePlayerStats(playerid);
stock HidePlayerStats(playerid)
{
	TextDrawHideForPlayer(playerid, td_background_main);
	TextDrawHideForPlayer(playerid, td_defeat);
	TextDrawHideForPlayer(playerid, td_victory);
	TextDrawHideForPlayer(playerid, td_categories);
	TextDrawHideForPlayer(playerid, td_current_mod);
	TextDrawHideForPlayer(playerid, td_time_endgame);
	
	for(new i = 0; i < 3; i++)
		TextDrawHideForPlayer(playerid, td_next_mods[i]);
	
	for(new i = 0; i < MAX_SLOTS; i++)
	{			
		TextDrawHideForPlayer(playerid, td_background[i]);
		TextDrawHideForPlayer(playerid, td_name[i]);
		TextDrawHideForPlayer(playerid, td_score[i]);
		TextDrawHideForPlayer(playerid, td_kills[i]);
		TextDrawHideForPlayer(playerid, td_deaths[i]);
	}
	
	PLAYERS[playerid][pStats] = false;
		
	return true;
}

//-----------------------------

stock UpdateStats()
{
	new
		nbr,
		array[MAX_SLOTS][2];

	foreach(new i : Player)
	{
		array[nbr][0] = PLAYERS[i][pScoreDG];
		array[nbr][0]++; // fix bug of SortDeepArray
		array[nbr][1] = i;
		
		nbr++;
	}
	
	SortDeepArray(array, 0, .order = SORT_DESC);

	#define id array[i][1]
	
	for(new i = 0; i < MAX_SLOTS; i++)
	{	
		if(i < nbr)
		{
			static
				val[6];
		
			TextDrawSetString(td_name[i], PLAYERS[id][pUsername]);
			
			valstr(val, PLAYERS[id][pScoreDG]);
			TextDrawSetString(td_score[i], val);
			
			valstr(val, PLAYERS[id][pKillsDG]);
			TextDrawSetString(td_kills[i], val);
			
			valstr(val, PLAYERS[id][pDeathsDG]);
			TextDrawSetString(td_deaths[i], val);
		}
		
		else
		{
			TextDrawSetString(td_name[i], "----");
			TextDrawSetString(td_score[i], "----");
			TextDrawSetString(td_kills[i], "----");
			TextDrawSetString(td_deaths[i], "----");
		}
	}
	
	#undef id
	
	return true;
}

//-----------------------------

// native UpdateVotes();
stock UpdateVotes()
{
	static
		str[MAX_MOD_NAME + 4];				

	for(new j = 0 ; j < MAX_NEXT_MODS; j++)
	{
		format(str, sizeof(str), "%s: %d", MODS[modid_next_mods[j]][mName], votes_next_mods[j]);
		TextDrawSetString(td_next_mods[j], str);
	}
	
	return true;
}

//-----------------------------

// native FreezeSpawn(playerid);
stock FreezeSpawn(playerid)
{
	new
		m = GetPlayerPing(playerid) / 50;

	TogglePlayerControllable(playerid, false);
	SetTimerEx("UnfreezeSpawn", m == 0 ? TIME_FREEZE_SPAWN : TIME_FREEZE_SPAWN * m, false, "d", playerid);
	
	return true;
}

//-----------------------------

// native EndGame();
stock EndGame()
{
	end_game = true;
	
	SelectNextMods();
	
	foreach(new i : Player)
	{					
		PLAYERS[i][pKills] += PLAYERS[i][pKillsDG];
		PLAYERS[i][pDeaths] += PLAYERS[i][pDeathsDG];
	}
	
	time_endgame = 15;
	timer_time_endgame = SetTimer(!"Timer_EndGame", 1000, true);
	
	return true;
}

//-----------------------------

// native AddPlayerToTeam(playerid, teamid);
stock AddPlayerToTeam(playerid, teamid)
{
	SetPlayerTeam(playerid, teamid);
	
	PLAYERS[playerid][pTeamDG] = teamid;
	MODS[CURRENT_MOD][mTeamMembers][teamid]++;

	return true;
}

//-----------------------------

// native ResetStatsDG(playerid);
stock ResetStatsDG(playerid)
{
	PLAYERS[playerid][pScoreDG] = 0;
	PLAYERS[playerid][pKillsDG] = 0;
	PLAYERS[playerid][pDeathsDG] = 0;
	
	PLAYERS[playerid][pTeamDG] = NO_TEAM;
	SetPlayerTeam(playerid, NO_TEAM);

	return true;
}

//-----------------------------

// native AddClass(const name[], Float:health, weapid, weapamount, weapreload);
stock AddClass(const name[], Float:health, weapid, weapamount, weapreload)
{
	if(strlen(name) >= MAX_CLASS_NAME || isnull(name)) return NO_CLASS;

	new
		classid = Iter_Free(Class);
		
	if(classid == -1) return NO_CLASS;
	
	Iter_Add(Class, classid);
	
	strunpack(CLASS[classid][cName], name);
	
	CLASS[classid][cHealth] = health;
	
	CLASS[classid][cWeapID] = weapid;
	CLASS[classid][cWeapAmount] = weapamount;
	CLASS[classid][cWeapReload] = weapreload;
	
	return classid;
}