#include "sign_up.pwn"
#include "sign_in.pwn"
#include "sign_out.pwn"

//-----------------------------
//-------------------------------------------------
//-----------------------------

Player::Connect(playerid)
{	
	SetPlayerColor(playerid, COLOR_GREY);
	GetPlayerName(playerid, PLAYERS[playerid][pUsername], MAX_PLAYER_NAME);
	GetPlayerIp(playerid, PLAYERS[playerid][pIp], 16);
	
	if(whitelist)
	{
		SCM(playerid, COLOR_YELLOW, "Recherche de votre pseudo dans la whitelist...");
	
		if(!IsUsernameWhitelisted(PLAYERS[playerid][pUsername])) 
			return KickWithMessage(playerid, COLOR_RED, "Username non trouvé.");
		
		SCM(playerid, COLOR_GREEN, "Username trouvé.");
	}
	
	return 1;
}

//-----------------------------

Player::RequestClass(playerid, classid)
{
	if(IsPlayerLogged(playerid)) 
		return SpawnPlayer(playerid);
	
    SetSpawnInfo(playerid, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	TogglePlayerSpectating(playerid, true);
	
	static
		query[128];
	
	mysql_format(mysql, query, sizeof(query), "SELECT * FROM `IPBans` WHERE `IP` = '%s'", PLAYERS[playerid][pIp]);
	mysql_tquery(mysql, query, "CheckingIP", "i", playerid);	
	
	return 1;
}

//-----------------------------
//-------------------------------------------------
//-----------------------------

forward CheckingIP(playerid);
public CheckingIP(playerid)
{		
	if(!cache_get_row_count()) goto noban;

	new
		tempsban = cache_get_field_content_int(0, "TempsBan");		

	if(tempsban > gettime() || tempsban == -1)
	{
		if(tempsban != -1) tempsban -= gettime();
		
		static
			ban[128], 
			banpar[MAX_PLAYER_NAME];
			
		cache_get_field_content(0, "RaisonBan", ban);
		cache_get_field_content(0, "BanPar", banpar);				
		
		ClearChat(playerid);
		SCM(playerid, COLOR_RED, "____________________________________________________________________");
	
		SCM(playerid, -1, "Votre IP a été bannie du serveur."); 
		SCM(playerid, -1, "Par : %s.", banpar);				
		SCM(playerid, -1, "Raison : %s.", ban);
		
		if(tempsban == -1) SCM(playerid, -1, "Temps : permanent.");
		else SCM(playerid, -1, "Temps restant : %s.", ReturnDateBySecond(tempsban));

		return SetTimerEx("Timer_Kick", 250, false, "i", playerid);
	}
	
	static
		query[128];	
	
	mysql_format(mysql, query, sizeof(query), "DELETE FROM `IPBans` WHERE IP = '%s'", PLAYERS[playerid][pIp]);
	mysql_tquery(mysql, query);
	
	noban:
	
	mysql_format(mysql, query, sizeof(query), "SELECT * FROM `UsernameBans` WHERE `Username` = '%s'", PLAYERS[playerid][pUsername]);
	return mysql_tquery(mysql, query, "CheckingUsername", "i", playerid);
}

//-----------------------------

forward CheckingUsername(playerid);
public CheckingUsername(playerid)
{
	if(!cache_get_row_count()) goto noban;
	
	new 
		tempsban = cache_get_field_content_int(0, "TempsBan");		

	if(tempsban > gettime() || tempsban == -1)
	{
		if(tempsban != -1) tempsban -= gettime();
		
		static
			ban[128], 
			banpar[MAX_PLAYER_NAME+1];
			
		cache_get_field_content(0, "RaisonBan", ban);
		cache_get_field_content(0, "BanPar", banpar);				
		
		ClearChat(playerid);
		SCM(playerid, COLOR_RED, "____________________________________________________________________");
	
		SCM(playerid, -1, "Votre pseudo a été banni du serveur."); 
		SCM(playerid, -1, "Par : %s.", banpar);				
		SCM(playerid, -1, "Raison : %s.", ban);
		
		if(tempsban == -1) SCM(playerid, -1, "Temps : permanent.");
		else SCM(playerid, -1, "Temps restant : %s.", ReturnDateBySecond(tempsban));

		return SetTimerEx("Timer_Kick", 250, false, "i", playerid);
	}
	
	static
		query[128];
	
	mysql_format(mysql, query, sizeof(query), "DELETE FROM `UsernameBans` WHERE Username = '%s'", PLAYERS[playerid][pUsername]);
	mysql_tquery(mysql, query);
	
	noban:
	
	mysql_format(mysql, query, sizeof(query), "SELECT * FROM `Accounts` WHERE `Username` = '%s'", PLAYERS[playerid][pUsername]);
	return mysql_tquery(mysql, query, "Sign", "i", playerid);
}

//-----------------------------

forward Sign(playerid);
public Sign(playerid)
{
	static 
		string[33];

	if(cache_get_row_count())
	{
		PLAYERS[playerid][pIDSql] = cache_get_field_content_int(0, "ID");
	
		format(string, sizeof(string), "Bonjour %s.", PLAYERS[playerid][pUsername]);
		return Dialog_Show(playerid, SignIn, DIALOG_STYLE_PASSWORD, string, ""WHITE"Votre compte est enregistré dans notre base de données,\nvous pouvez dès maintenant vous connecter.\n\nEntrez dès maintenant votre mot de passe.", "Connexion", "Quitter");
	}

	format(string, sizeof(string), "Bienvenue %s.", PLAYERS[playerid][pUsername]);
	return Dialog_Show(playerid, SignUp, DIALOG_STYLE_INPUT, string, ""WHITE"Votre compte n'est pas enregistré dans notre base de données.\n\nEntrez un mot de passe de minimum 5 caractères pour pouvoir vous inscrire et\nvous connecter par la suite.", "Inscription", "Quitter");
}