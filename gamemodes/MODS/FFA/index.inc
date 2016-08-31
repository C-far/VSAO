#if defined _inc_index
    #undef _inc_index
#endif
#if defined _VSAO_FFA_
    #endinput
#endif
#define _VSAO_FFA_

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
	MODID = AddMod(FFA_NAME, FFA_SHORTNAME, FFA_MOD_TYPE, FFA_CLASS, FFA_MAX_SCORE, FFA_AUTHOR);
	
	return true;
}

//-----------------------------

Mod::Init()
{
	print(!"                      |         "FFA_NAME" loaded         |");
	
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
	AddPlayerScore(killerid, FFA_KILLED_SCORE);

	return true;
}