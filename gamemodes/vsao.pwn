/*
	GAMEMODE CREATED by C_far/Dutheil.
			
	This GameMode doesn't use any base, almost everything is made by 
	"Timothé Dutheil" alias "C_far" or "Dutheil".
	some includes are made by some SAMP community's members.
	
	Credits:
			=============================================================
			| C_far/Dutheil			| CLI libraries, TDs and the GM.	|
			| TheMatrix 			| All Maps.						  	|
			=============================================================
			| Y_less				| YSI 4, WhirlPool, sscanf2.	  	|
			| Zeex					| Compiler and amx_assembly.		|
			| Slice					| md-sort.							|
			| BlueG & Maddinat0r	| MySQL plugin.					  	|
			| Incognito				| Streamer plugin.				  	|
			| Emmet_				| easyDialog.					  	|
			| Crayder				| timestamp						  	|
			=============================================================
			| Sidney De Vries		| Vertix Online (vertix.io).		|
			| SAMP Team				| SAMP mod.						  	|
			| Thiadmer Riemersma	| Pawn.							  	|
			=============================================================
		
	-----------------------------------------------------------------------------
	
	The MIT License (MIT)
	Copyright (c) 2016 - Timothé Dutheil : C_far

	Permission is hereby granted, free of charge, to any person obtaining a 
	copy of this software and associated documentation files (the "Software"), 
	to deal in the Software without restriction, including without limitation 
	the rights to use, copy, modify, merge, publish, distribute, sublicense, 
	and/or sell copies of the Software, and to permit persons to whom the 
	Software is furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included 
	in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS 
	OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN 
	THE SOFTWARE.
*/

//-----------------------------
//-------------------------------------------------
//-----------------------------

/**--------------------------------------------------------------------------**\
	Remark : Please, don't remove theses lines, the GM uses properties of the 
	Zeex's compiler.
	
	__Pawn -> Macro which contains the compiler version.
	0x302 -> The SAMP's compiler version. (3.2.3664)
	0x30A -> The Zeex's compiler version. (3.10.20160702 : July 2nd 2016)
\**--------------------------------------------------------------------------**/
#if __Pawn != 0x30A
	#error Download the Zeex's PAWN Compiler : github.com/Zeex/pawn/releases
// '
#endif

/**--------------------------------------------------------------------------**\
	Remark : Exclusive of the Zeex's compiler that allows compability with 
	some includes and avoids errors.
\**--------------------------------------------------------------------------**/
#pragma compat 1 // github.com/Zeex/pawn/wiki/Compatibility-mode

//-----------------------------
//-------------------------------------------------
//-----------------------------

#include "a_samp"
#include "BASE\version.pwn"
#include "BASE\config.pwn"

#if MAX_SLOTS & 0b00000001
	#error MAX_SLOTS must be even, please config correctly "BASE/config.pwn"
#elseif MAX_SLOTS < 2 || MAX_SLOTS > 10 
	#error MAX_SLOTS must be between 2 and 10, please config correctly "BASE/config.pwn"
#endif

/**--------------------------------------------------------------------------**\
	Remark : MAX_SLOTS is 10 by default.
\**--------------------------------------------------------------------------**/
#if defined MAX_PLAYERS
	#undef MAX_PLAYERS
#endif
#define MAX_PLAYERS MAX_SLOTS

//-----------------------------
//-------------------------------------------------
//-----------------------------

native WP_Hash(buffer[], len, const str[]); /* WhirlPool (plugin) */

//-----------------------------
//-------------------------------------------------
//-----------------------------

#tryinclude "YSI_Internal\y_version"

#if !defined YSI_VERSION_MAJOR
	#error Download YSI4 & amx_assembly | github.com/Misiur/YSI-Includes/archive/YSI.tl.zip & github.com/Zeex/amx_assembly/archive/master.zip
#elseif YSI_VERSION_MAJOR < 4 
	#error Update to YSI4 with amx_assembly | github.com/Misiur/YSI-Includes/archive/YSI.tl.zip & github.com/Zeex/amx_assembly/archive/master.zip
#endif

/**--------------------------------------------------------------------------**\
	Remark : The iterator "Player" is not added from the include, but it is 
	declared in the GameMode.
	It contains the players IDs connected and logged.
\**--------------------------------------------------------------------------**/
#define FOREACH_NO_PLAYERS
#define FOREACH_NO_BOTS
#define FOREACH_NO_ACTORS
#define FOREACH_NO_VEHICLES
	
#include "YSI\y_iterate"
#include "YSI\y_va"
#include "YSI\y_commands"

//-----------------------------

#tryinclude "CLI\c_time"

#if !defined _cli_time_included
	#error Download c_time.inc | github.com/Dutheil/CLI/tree/master/CLI
#endif

//-----------------------------

#tryinclude "CLI\c_tdselect"

#if !defined cli_tdselect_included
	#error Download c_tdselect.inc | github.com/Dutheil/CLI/tree/master/CLI
#endif

//-----------------------------

#tryinclude "a_mysql"

#if !defined cache_get_query_exec_time 
	#error Download the last plugin and the include of mysql | github.com/pBlueG/SA-MP-MySQL/releases
#endif

//-----------------------------

#tryinclude "streamer"

#if !defined CreateDynamicObject
	#error Download the plugin and the include of streamer | github.com/samp-incognito/samp-streamer-plugin/releases
#endif

//-----------------------------

#tryinclude "sscanf2"

#if !defined sscanf
	#error Download the plugin and the include of sscanf2 | dl.dropboxusercontent.com/u/102595204/sscanf-2.8.2.zip
#endif

//-----------------------------

#tryinclude "easyDialog"

#if !defined Dialog_Show
	#error Download easyDialog.inc | forum.sa-mp.com/showthread.php?t=475838
#endif 

//-----------------------------

#tryinclude "timestamp"

#if !defined stamp2datetime
	#error Download timestamp.inc | github.com/Crayder/Time-Conversion
#endif 

//-----------------------------

#tryinclude "md-sort"

#if !defined SortDeepArray
	#error Download md-sort.inc | github.com/oscar-broman/md-sort
#endif 

//-----------------------------
//-------------------------------------------------
//-----------------------------

/**--------------------------------------------------------------------------**\
	Remark : You can found the others languages in the folder "LANGS".
\**--------------------------------------------------------------------------**/
//#include "LANGS\lang_fr.pwn"

//-----------------------------
//-------------------------------------------------
//-----------------------------

#if defined OnModInit
	forward OnModInit();
#endif

//-----------------------------
//-------------------------------------------------
//-----------------------------

#include "BASE\STATEMENTS\defines.pwn"
#include "BASE\STATEMENTS\enums.pwn"
#include "BASE\STATEMENTS\variables.pwn"
#include "BASE\STATEMENTS\arrays.pwn"
#include "BASE\STATEMENTS\iterators.pwn"
#include "BASE\STATEMENTS\functions.pwn"
#include "BASE\STATEMENTS\publics.pwn"

//-----------------------------

#include "BASE\mysql.pwn"
#include "BASE\load_maps.pwn"
#include "BASE\textdraws.pwn"
#include "BASE\keys.pwn"
#include "BASE\spawns.pwn"
#include "BASE\class.pwn"
#include "BASE\damages.pwn"

//-----------------------------

#include "BASE\LOAD_SAVE\index.pwn"

//-----------------------------

#include "UTILS\functions_mods.pwn"
#include "UTILS\functions_players.pwn"

//-----------------------------

#include "CMDS\ban.pwn"
#include "CMDS\kick.pwn"
#include "CMDS\mute.pwn"
#include "CMDS\staff.pwn" // chat staff
#include "CMDS\unban.pwn"
#include "CMDS\unmute.pwn"
#include "CMDS\whitelist.pwn"

//-----------------------------

#include "MODS\include_mods.pwn"

//-----------------------------
//-------------------------------------------------
//-----------------------------

main() 
{
	
}

//-----------------------------
//-------------------------------------------------
//-----------------------------

#include "YSI\y_hooks"

//-----------------------------
//-------------------------------------------------
//-----------------------------

GameMode::Init()
{
	SendRconCommand(!"hostname "SERVER_NAME);
	SetGameModeText(!"VSAO "VERSION);

	//--------------------------------------------
	
	/**--------------------------------------------------------------------------**\
		Remark : Here, just a debug prevention.
	\**--------------------------------------------------------------------------**/
	new
		players = GetMaxPlayers(),
		ex[] = !"exit";

	if(MAX_PLAYERS != players)
	{
		printf("ERROR: MAX_PLAYERS (%d) is different of the slot number (%d).", MAX_PLAYERS, players);
		print(!"Please edit your server.cfg or the file \"BASE/config.pwn\".");
		SendRconCommand(ex);
		
		return true;
	}
	
	//--------------------------------------------
	
	LoadWhitelist();
	LoadMaps();
	SetTimer(!"Mute", 1000, true);
	
	//--------------------------------------------
	
	print(!"\n\n\n\n\n\n\n                  888     888  .d8888b.        d8888  .d88888b.");
	print(!"                  888     888 d88P  Y88b      d88888 d88P\" \"Y88b");
	print(!"                  888     888 Y88b.          d88P888 888     888");
	print(!"                  Y88b   d88P  \"Y888b.      d88P 888 888     888");
	print(!"                   Y88b d88P      \"Y88b.   d88P  888 888     888");
	print(!"                    Y88o88P         \"888  d88P   888 888     888");
	print(!"                     Y888P    Y88b  d88P d8888888888 Y88b. .d88P");
	print(!"                      Y8P      \"Y8888P\" d88P     888  \"Y88888P\"\n\n");
	
	//"
	
	print(!"                      =======================================");
	print(!"                      |           Vertix SA Online          |");
	print(!"                      |                  by                 |");
	print(!"                      |                                     |");
	print(!"                      |            C_far/Dutheil            |");
	print(!"                      |              TheMatrix              |");
	print(!"                      |                                     |");
	print(!"                      |          Version : "VERSION"         |");
	print(!"                      =-------------------------------------=");
	
	CallLocalFunction("OnModInit", ""); // y_hooks :/
	
	print(!"                      =-------------------------------------=");
	printf("                      |          %03d mod(s) loaded          |", Iter_Count(Mod));
	printf("                      |          %03d map(s) loaded          |", Iter_Count(Map));
	print(!"                      =======================================\n");
	
	//--------------------------------------------
	
	if(Iter_Count(Mod) == 0) 
	{
		print(!"ERROR: No mod found, please add in.");
		SendRconCommand(ex);
	}
	
	if(Iter_Count(Map) == 0) 
	{
		print(!"ERROR: No map found, please add in.");
		SendRconCommand(ex);
	}
	
	if(Iter_Count(Class) == 0) 
	{
		print(!"ERROR: No class found, please add in.");
		SendRconCommand(ex);
	}
	
	new
		bool:t = false;
	
	foreach(new modid : Mod)
	{
		if(MODS[modid][mNbrMaps] == 0)
		{
			printf("ERROR: The mod \"%s\" don't have any map, please add in.", MODS[modid][mName]);
			t = true;
		}
	}
	
	if(t) SendRconCommand(ex);
	
	//--------------------------------------------
	
	Start();
	
	return true;
}

Player::ClickTextDraw(playerid, Text:clickedid)
{
	for(new i = 0; i < MAX_NEXT_MODS; i++)
	{
		if(td_next_mods[i] == clickedid)
		{
			new
				vote = PLAYERS[playerid][pVoteMod];
		
			if(vote != NO_VOTE) votes_next_mods[vote]--;
			
			votes_next_mods[i]++;
			PLAYERS[playerid][pVoteMod] = i;
			
			UpdateVotes();
			
			return true;
		}
	}

	return true;
}

public OnPlayerCancelSelectByEchap(playerid) // I can't put "Player::" because : warning 200
{
	if(end_game) SelectTextDraw(playerid, 0xFF000088);

	return true;
}

YCMD:respawn(playerid, params[], help)
{
	return SpawnPlayer(playerid);
}

YCMD:test(playerid, params[], help)
{
	AddPlayerScore(playerid, 900);

	return true;
}

YCMD:class(playerid, params[], help)
{
	if(MODS[CURRENT_MOD][mClass] != NO_CLASS) return SCM(playerid, -1, "ERREUR: Vous ne pouvez pas changer de classe dans ce mod.");
	if(PLAYERS[playerid][pHealth] != CLASS[PLAYERS[playerid][pClass]][cHealth]) return SCM(playerid, -1, "ERREUR: Vous devez avoir toute votre vie pour changer de classe.");
	
	static
		classid;
		
	if(sscanf(params, "k<class>", classid)) return SCM(playerid, -1, "USAGE: /class <ClassID>");
	if(classid == NO_CLASS) 
	{
		SCM(playerid, -1, "ERREUR: Classes : 0 - %d", Iter_Count(Class) - 1);
		
		foreach(new i : Class)
		{
			if(i == 2) SCM(playerid, -1, "- \"Rocketeer\" ou 2 - "RED"Bloquée");
			else SCM(playerid, -1, "- \"%s\" ou %d", CLASS[i][cName], i);
		}
		
		return true;
	}
	
	if(classid == 2) return SCM(playerid, -1, "ERREUR: Cette classe est bloquée");
	
	PLAYERS[playerid][pClass] = classid;
	SCM(playerid, -1, "Vous sélectionnez la classe : %s", CLASS[classid][cName]);
	SpawnPlayer(playerid);
	
	return true;
}

YCMD:eq(playerid, params[], help)
{
	if(MODS[CURRENT_MOD][mType] != MOD_TYPE_TEAM) return SCM(playerid, -1, !"Fonctionne que pour les mods équipes");
	
	return SCM(playerid, -1, "Equipe : %d", PLAYERS[playerid][pTeamDG]);
}

YCMD:mods(playerid, params[], help)
{
	new
		str[1024];

	foreach(new modid : Mod)
	{
		new
			tab[16];
	
		static
			fmt[64];
			
		if(strlen(MODS[modid][mName]) > 12) strcat(tab, "\t>\t");
		else strcat(tab, "\t\t>\t");
	
		format(fmt, sizeof fmt, ""DARK_YELLOW"%s "WHITE"%s"BLUE"%s\n", MODS[modid][mName], tab, MODS[modid][mAuthor]);
		strcat(str, fmt);
	}

	Dialog_Show(playerid, nothing, DIALOG_STYLE_MSGBOX, DARK_YELLOW"MODS", str, "Ok", "");
	
	return true;
}

YCMD:credits(playerid, params[], help)
{
	SCM(playerid, COLOR_GOLD, !"--------------------------------------------------------------------------------------------------------------------------");
	SCM(playerid, -1, !DARK_GREEN"VSAO "WHITE"is based on the original game \"Vertix Online (vertix.io)\", created by "DARK_YELLOW"Sidney De Vries"WHITE".");
	SCM(playerid, -1, !DARK_GREEN"VSAO "WHITE"is a GameMode open-source made by "DARK_YELLOW"C_far "WHITE"aka "DARK_YELLOW"Dutheil"WHITE".");
	SCM(playerid, -1, "Actual mod: "DARK_GREEN"%s "WHITE"made by "DARK_YELLOW"%s"WHITE".", MODS[CURRENT_MOD][mName], MODS[CURRENT_MOD][mAuthor]);
	SCM(playerid, -1, "Actual map: "DARK_GREEN"No.%d "WHITE"made by "DARK_YELLOW"%s"WHITE".", CURRENT_MAP, MAPS[CURRENT_MAP][mapAuthor]);
	SCM(playerid, COLOR_GOLD, !"--------------------------------------------------------------------------------------------------------------------------");

	return true;
}

SSCANF:class(const string[])
{
	new
		classid = NO_CLASS;

	if('0' <= string[0] <= '9')
	{
		classid = strval(string);
		
		if(!Iter_Contains(Class, classid)) return NO_CLASS;
	}
	
	else
	{	
		foreach(new i : Class)
		{
			if(strcmp(string, CLASS[i][cName], true) == 0) return i;
		}
	}
		
	return classid;
}
