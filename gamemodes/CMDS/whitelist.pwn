YCMD:whitelist(playerid, params[], help)
{		
	if(isnull(params)) return SCU(playerid, "/whitelist <add, remove, tog>");
	
	if(strcmp(params, "add", true, 3) == 0)
	{
		if(sscanf(params[3], "s[25]", params)) return SCU(playerid, "/whitelist add <username>");
		if(IsUsernameWhitelisted(params)) return SCE(playerid, "Ce pseudo est déjà dans la whitelist.");
		
		static
			req[128];
		
		mysql_format(mysql, req, sizeof(req), "INSERT INTO Whitelist (Username) VALUES ('%e')", params);
		mysql_tquery(mysql, req);
		
		return 1;
	}
	
	if(strcmp(params, "remove", true, 6) == 0)
	{
		if(sscanf(params[6], "s[25]", params)) return SCU(playerid, "/whitelist remove <username>");
		if(!IsUsernameWhitelisted(params)) return SCE(playerid, "Ce pseudo n'est pas dans la whitelist.");
		
		static
			req[128];
		
		mysql_format(mysql, req, sizeof(req), "DELETE FROM Whitelist WHERE Username='%e'", params);
		mysql_tquery(mysql, req);
		
		return 1;
	}

	if(strcmp(params, "tog", true, 3) == 0)
	{
		whitelist = !whitelist;
		
		new
			File:file = fopen("whitelist.ini"),
			str[2];
		
		str[0] = _:whitelist + 48;
		
		fwrite(file, str);
		fclose(file);
		
		return (whitelist ? SCMTA(COLOR_GREEN, "La whitelist a été activée par un membre du staff.") : SCMTA(COLOR_RED, "La whitelist a été désactivée par un membre du staff."));		
	}
	
	return SCM(playerid, -1, "Nom : add, remove, tog");	
}