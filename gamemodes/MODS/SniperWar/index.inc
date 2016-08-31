#if defined _inc_index
    #undef _inc_index
#endif
#if defined _VSAO_SniperWar_
    #endinput
#endif
#define _VSAO_SniperWar_

//-----------------------------
//-------------------------------------------------
//-----------------------------

/*
	MADE by C_far/Dutheil.
*/

#include "config"
#include "YSI\y_hooks"

//-----------------------------
//-------------------------------------------------
//-----------------------------

stock static
	MODID;

//-----------------------------
//-------------------------------------------------
//-----------------------------

GameMode::Init()
{
	MODID = AddMod(SW_NAME, SW_SHORTNAME, SW_MOD_TYPE, SW_CLASS, SW_MAX_SCORE, SW_AUTHOR);
	
	return true;
}

//-----------------------------

Mod::Init()
{
	print(!"                      |           "SW_NAME" loaded         |");
	
	AddMapMod(MODID, 0);
	AddMapMod(MODID, 1);
	AddMapMod(MODID, 2);
	
	return true;
}

//-----------------------------

Player::Death(playerid, killerid, reason)
{
	if(CURRENT_MOD != MODID) return true;
	if(killerid == INVALID_PLAYER_ID) return true;
	
	AddPlayerDeath(playerid);
	
	AddPlayerKill(killerid);
	AddPlayerScore(killerid, SW_KILLED_SCORE);

	return true;
}