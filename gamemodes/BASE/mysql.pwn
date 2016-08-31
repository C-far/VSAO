#include "YSI\y_hooks"

//-----------------------------
//-------------------------------------------------
//-----------------------------

hook OnGameModeInit()
{
	mysql = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_DATABASE, MYSQL_PASSWORD); 
	mysql_tquery(mysql, "UPDATE `Accounts` SET Logged=65535");

	return 1;
}