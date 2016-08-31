#include "colors.pwn"

//-----------------------------
//-------------------------------------------------
//-----------------------------

#define Player::%0( hook OnPlayer%0(
#define GameMode::%0( hook OnGameMode%0(
#define Mod::%0( hook OnMod%0(

//-----------------------------

#define MAX_PLAYER_LEVEL (100)
#define MAX_PLAYER_XP (3043095)

//-----------------------------

#define MAX_MODS (20)
#define MAX_MAPS_PER_MOD (10)
#define MAX_MAPS (MAX_MODS * MAX_MAPS_PER_MOD)
#define MAX_SPAWNS_PER_MAP (8)

#define MAX_MOD_NAME (17)
#define MAX_SHORT_MOD_NAME (5)

#define MAX_NEXT_MODS (3)

#define MAX_CLASS (10)
#define MAX_CLASS_NAME (11)

#define NO_MOD (-1)
#define NO_MAP (-1)
#define NO_CLASS (-1)
#define NO_VOTE (-1)

#define DEFAULT_MAX_SCORE_MOD (2000)

//-----------------------------

#define ClearChat(%0) for(new c@c_p = 0; c@c_p < 100; c@c_p++) SendClientMessage(%0, -1, "	")

//-----------------------------

#define HOLDING(%0) ((newkeys & (%0)) == (%0))
#define PRESSED(%0) (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define RELEASED(%0) (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

//-----------------------------

#define IsValidMod(%0) (Iter_Contains(Mod,%0))
#define IsValidMap(%0) (Iter_Contains(Map,%0))
#define IsPlayerLogged(%0) (Iter_Contains(Player,%0))
#define IsPlayerMute(%0) (PLAYERS[%0][pMute] != 0)
#define IsPlayerMaxLevel(%0) (PLAYERS[%0][pLevel] == MAX_PLAYER_LEVEL)

//-----------------------------

#define SCE(%0,%1) SCM(%0, 0xFF0000FF, "ERREUR"WHITE": "%1)
#define SCU(%0,%1) SCM(%0, 0xFF0000FF, "USAGE"GREY": "%1)