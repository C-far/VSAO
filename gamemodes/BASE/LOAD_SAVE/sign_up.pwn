Dialog:SignUp(playerid, response, listitem, inputtext[])
{
	if(!response) return Kick(playerid);
	
	static
		string[256];
	
	if(strlen(inputtext) < 5)
	{			
		format(string, sizeof(string), "Bienvenue %s.", PLAYERS[playerid][pUsername]);
		return Dialog_Show(playerid, SignUp, DIALOG_STYLE_INPUT, string, ""RED"ERREUR : Vous avez rentr� moins de 5 caract�res.\n\n"WHITE"Votre compte n'est pas enregistr� dans notre base de donn�es.\n\nEntrez un mot de passe de minimum 5 caract�res pour pouvoir vous inscrire et\nvous connecter par la suite.", "Connexion", "Quitter");
	}
		
	WP_Hash(string, sizeof(string), inputtext);
	
	mysql_format(mysql, string, sizeof(string), "INSERT INTO `Accounts` (Username, Password, Ip) VALUES ('%s', '%s', '%s')", PLAYERS[playerid][pUsername], string, PLAYERS[playerid][pIp]);
	mysql_tquery(mysql, string);
	
	format(string, sizeof(string), "Bonjour %s.", PLAYERS[playerid][pUsername]);
	return Dialog_Show(playerid, SignIn, DIALOG_STYLE_PASSWORD, string, ""WHITE"Votre compte est enregistr� dans notre base de donn�es,\nvous pouvez d�s maintenant vous connecter.\n\nEntrez d�s maintenant votre mot de passe.", "Connexion", "Quitter");
}