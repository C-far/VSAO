#if defined _inc_index
    #undef _inc_index
#endif
#if defined _VSAO_RocketWar_
    #endinput
#endif
#define _VSAO_RocketWar_

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
	MODID = AddMod(RW_NAME, RW_SHORTNAME, RW_MOD_TYPE, RW_CLASS, RW_MAX_SCORE, RW_AUTHOR);
	
	return true;
}

//-----------------------------

Mod::Init()
{
	print(!"                      |           "RW_NAME" loaded         |");
	
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
	AddPlayerScore(killerid, RW_KILLED_SCORE);

	return true;
}