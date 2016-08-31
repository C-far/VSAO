enum e_MOD_TYPE
{
	MOD_TYPE_TEAM, // Lootcrate, Hardpoint, Team Deathmatch, Zone War
	MOD_TYPE_FREE, // Free For All, Sniper War, Rocket War
	MOD_TYPE_ALONE, // Boss Hunt
}

//-----------------------------

enum e_MODS
{
	mAuthor[MAX_PLAYER_NAME],
	
	mName[MAX_MOD_NAME],
	mShortName[MAX_SHORT_MOD_NAME],
	
	e_MOD_TYPE:mType,
	
	mMaps[MAX_MAPS_PER_MOD],
	mNbrMaps,
	
	mMaxScore,
	
	mClass,
	
	mTeamMembers[2],
	mTeamScores[2]
}

//-----------------------------

enum e_MAPS
{
	mapAuthor[MAX_PLAYER_NAME],
	mapNbrObjects,
	
	Float:mapSpawnsX[MAX_SPAWNS_PER_MAP],
	Float:mapSpawnsY[MAX_SPAWNS_PER_MAP],
	Float:mapSpawnsZ[MAX_SPAWNS_PER_MAP],
	Float:mapSpawnsA[MAX_SPAWNS_PER_MAP],
	mapNbrSpawns
}

//-----------------------------

enum e_CLASS
{
	cName[MAX_CLASS_NAME],
	
	Float:cHealth,
	
	cWeapID,
	cWeapAmount,
	cWeapReload
}

//-----------------------------

enum e_PLAYERS
{
	pIDSql,
	
	pIp[16],
	
	pUsername[MAX_PLAYER_NAME],
	pPassword[129],
	
	bool:pStaff,
	
	pMute,
	
	bool:pStats,
	pVoteMod,
	bool:pAlreadyCalledTimer,
	
	// DG = During the game
	pScoreDG,
	pKillsDG,
	pDeathsDG,
	pTeamDG,
	// DG = During the game
	
	// Internal
	Float:pHealth,
	
	pLevel,
	pXp,
	pXpMax,
	pClass,
	
	pKills,
	pDeaths,
	pLikes,
	
	pGamesPlayed,
	pGamesWon,
	pGamesLost
	// Internal
}