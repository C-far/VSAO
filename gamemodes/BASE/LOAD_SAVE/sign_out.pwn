Player::Disconnect(playerid, reason)
{	
	static const 
			RaisonDeco[][] = {"Crash", "Déconnexion", "Kick/Ban"};

	if(restart)
	{
		ClearChat(playerid);
		SCM(playerid, COLOR_RED, "____________________________________________________________________");
		SCM(playerid, -1, "Le serveur vient d'être relancé par un Staff.");
	}
	
	else if(IsPlayerLogged(playerid)) 
	{
		SCMTA(COLOR_GREY, "%s a quitté le serveur. (%s)", PLAYERS[playerid][pUsername], RaisonDeco[reason]);
	}
	
	else return true;
	
	//-----------------------------
	
	SavePlayer(playerid);
	
	//-----------------------------
	
	new
		vote = PLAYERS[playerid][pVoteMod];
		
	if(vote != NO_VOTE) 
	{
		votes_next_mods[vote]--;
		UpdateVotes();
	}
	
	//-----------------------------
	
	Iter_Remove(Player, playerid);
	
	static 
		eBlank[e_PLAYERS];
		
	PLAYERS[playerid] = eBlank;
	
	SetPlayerTeam(playerid, NO_TEAM); // prevent
	
	UpdateStats();
	
	return true;
}

//-----------------------------
//-------------------------------------------------
//-----------------------------

stock SavePlayer(playerid)
{
	static
		query[512];
		
	mysql_format(mysql, query, sizeof(query), "\
												UPDATE `Accounts` SET \
												Logged = 65535, \
												Staff = %d, \
												Mute = %d, \
												Level = %d, \
												Xp = %d, \
												XpMax = %d, \
												Class = %d, \
												Kills = %d, \
												Deaths = %d, \ 
												Likes = %d, \
												GamesPlayed = %d, \
												GamesWon = %d, \
												GamesLost = %d \
												WHERE ID = '%d'",
												
												PLAYERS[playerid][pStaff],
												
												PLAYERS[playerid][pMute],
												
												PLAYERS[playerid][pLevel],
												PLAYERS[playerid][pXp],
												PLAYERS[playerid][pXpMax],
												PLAYERS[playerid][pClass],
												
												PLAYERS[playerid][pKills],
												PLAYERS[playerid][pDeaths],
												PLAYERS[playerid][pLikes],
												
												PLAYERS[playerid][pGamesPlayed],
												PLAYERS[playerid][pGamesWon],
												PLAYERS[playerid][pGamesLost],
												
												PLAYERS[playerid][pIDSql]);

	return mysql_tquery(mysql, query);
}