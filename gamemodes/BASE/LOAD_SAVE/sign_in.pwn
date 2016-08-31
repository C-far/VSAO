Dialog:SignIn(playerid, response, listitem, inputtext[])
{
	if(!response) return Kick(playerid);
	
	static 
		string[128];
	
	if(strlen(inputtext) < 5) 
	{
		format(string, sizeof(string), "Bonjour %s.", PLAYERS[playerid][pUsername]);
		return Dialog_Show(playerid, SignIn, DIALOG_STYLE_PASSWORD, string, ""RED"ERREUR : Vous avez rentré moins de 5 caractères.\n\n"WHITE"Votre compte est enregistré dans notre base de données,\nvous pouvez dès maintenant vous connecter.\n\nEntrez dès maintenant votre mot de passe.", "Connexion", "Quitter");
	}	

	WP_Hash(PLAYERS[playerid][pPassword], 129, inputtext);
	
	mysql_format(mysql, string, sizeof(string), "SELECT * FROM `Accounts` WHERE `Username` = '%s'", PLAYERS[playerid][pUsername]);
	return mysql_tquery(mysql, string, "CheckPass_GetInfos", "i", playerid);
}

//-----------------------------
//-------------------------------------------------
//-----------------------------

forward CheckPass_GetInfos(playerid);
public CheckPass_GetInfos(playerid)
{
	#define mdp str

    static 
		str[129];	
		
	cache_get_field_content(0, "Password", mdp);
	
	if(strcmp(mdp, PLAYERS[playerid][pPassword], true) == 0)
	{			
		PLAYERS[playerid][pStaff] = !!cache_get_field_content_int(0, "Staff");
		
		PLAYERS[playerid][pMute] = cache_get_field_content_int(0, "Mute");
		
		PLAYERS[playerid][pLevel] = cache_get_field_content_int(0, "Level");
		PLAYERS[playerid][pXp] = cache_get_field_content_int(0, "Xp");
		PLAYERS[playerid][pXpMax] = cache_get_field_content_int(0, "XpMax");
		PLAYERS[playerid][pClass] = cache_get_field_content_int(0, "Class");
		
		PLAYERS[playerid][pKills] = cache_get_field_content_int(0, "Kills");
		PLAYERS[playerid][pDeaths] = cache_get_field_content_int(0, "Deaths");
		PLAYERS[playerid][pLikes] = cache_get_field_content_int(0, "Likes");
		
		PLAYERS[playerid][pGamesPlayed] = cache_get_field_content_int(0, "GamesPlayed");
		PLAYERS[playerid][pGamesWon] = cache_get_field_content_int(0, "GamesWon");
		PLAYERS[playerid][pGamesLost] = cache_get_field_content_int(0, "GamesLost");
		
		PLAYERS[playerid][pTeamDG] = NO_TEAM;
		PLAYERS[playerid][pVoteMod] = NO_VOTE;
		
		Iter_Add(Player, playerid);
		
		//-----------------------------
		
		UpdateStats();
		
		if(end_game) ShowPlayerStats(playerid);
		
		//-----------------------------
		
		TogglePlayerSpectating(playerid, false);
		
		//-----------------------------
		
		mysql_format(mysql, str, sizeof(str), "UPDATE `Accounts` SET Logged=%d, IP = '%s' WHERE ID = %d", playerid, PLAYERS[playerid][pIp], PLAYERS[playerid][pIDSql]);
		mysql_tquery(mysql, str);
		
		/**                              PERMISSIONS COMMANDS                              **/
		UpdatePlayerCommandPermissions(playerid);
		/**                              PERMISSIONS COMMANDS                              **/
		
		return 1;
	}
	
	format(str, sizeof(str), "Bonjour %s.", PLAYERS[playerid][pUsername]);
	return Dialog_Show(playerid, SignIn, DIALOG_STYLE_PASSWORD, str, ""RED"ERREUR : Mot de passe erroné.\n\n"WHITE"Votre compte est enregistré dans notre base de données,\nvous pouvez dès maintenant vous connecter.\n\nEntrez dès maintenant votre mot de passe.", "Connexion", "Quitter");	
	
	#undef mdp
}