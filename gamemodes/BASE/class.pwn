#include "YSI\y_hooks"

//-----------------------------
//-------------------------------------------------
//-----------------------------

stock
	CLASS_TRIGGERMAN,
	CLASS_HUNTER,
	CLASS_ROCKETEER,
	CLASS_GUNMAN;

//-----------------------------
//-------------------------------------------------
//-----------------------------

GameMode::Init()
{
	CLASS_TRIGGERMAN 	= AddClass("Triggerman", 100.0, WEAPON_M4, 25, 1750);
	CLASS_HUNTER 		= AddClass("Hunter", 50.0, WEAPON_RIFLE, 1, 2000);
	CLASS_ROCKETEER 	= AddClass("Rocketeer", 150.0, WEAPON_ROCKETLAUNCHER, 1, 3000);
	CLASS_GUNMAN 		= AddClass("GunMan", 100.0, WEAPON_MP5, 9999999, 0);

	return true;
}

//-----------------------------

Player::Update(playerid)
{	
	if(PLAYERS[playerid][pAlreadyCalledTimer]) return true;

	new 
		classid = MODS[CURRENT_MOD][mClass] == NO_CLASS ? PLAYERS[playerid][pClass] : MODS[CURRENT_MOD][mClass];
		
	if(CLASS[classid][cWeapReload] == 0) return true;
	
	new
		ammo;
		
	GetPlayerWeaponData(playerid, GetWeaponSlot(CLASS[classid][cWeapID]), ammo, ammo);
	
	if(ammo == 0)
	{	
		PLAYERS[playerid][pAlreadyCalledTimer] = true;
		
		SetTimerEx("ReloadWeapClass", CLASS[classid][cWeapReload], false, "d", playerid);
	}

	return true;
}

//-----------------------------
//-------------------------------------------------
//-----------------------------

forward ReloadWeapClass(playerid);
public ReloadWeapClass(playerid)
{
	PLAYERS[playerid][pAlreadyCalledTimer] = false;

	new
		classid = MODS[CURRENT_MOD][mClass] == NO_CLASS ? PLAYERS[playerid][pClass] : MODS[CURRENT_MOD][mClass];
	
	new
		ammo;
		
	GetPlayerWeaponData(playerid, GetWeaponSlot(CLASS[classid][cWeapID]), ammo, ammo);
	
	if(ammo != 0) return true;
	
	GivePlayerWeapon(playerid, CLASS[classid][cWeapID], CLASS[classid][cWeapAmount]);

	return true;
}