forward OnPlayerXpChange(playerid, oldxp, newxp);
public OnPlayerXpChange(playerid, oldxp, newxp)
{
	if(newxp >= PLAYERS[playerid][pXpMax])
		UpPlayerLevel(playerid);

	return true;
}

//-----------------------------

forward OnPlayerScoreChange(playerid, oldscore, newscore);
public OnPlayerScoreChange(playerid, oldscore, newscore)
{
	UpdateStats();
	
	switch(MODS[CURRENT_MOD][mType])
	{
		case MOD_TYPE_TEAM:
		{
			new
				team = PLAYERS[playerid][pTeamDG];
			
			MODS[CURRENT_MOD][mTeamScores][team] += newscore - oldscore;
			
			if(MODS[CURRENT_MOD][mTeamScores][team] < MODS[CURRENT_MOD][mMaxScore]) return true;
			
			EndGame();
			
			foreach(new i : Player)
			{
				PLAYERS[i][pGamesPlayed]++;
				
				PLAYERS[i][pKills] += PLAYERS[i][pKillsDG];
				PLAYERS[i][pDeaths] += PLAYERS[i][pDeathsDG];
			
				TogglePlayerControllable(i, false);
				SelectTextDraw(i, 0xFF000088);
				
				if(team == PLAYERS[i][pTeamDG])
				{
					ShowPlayerStats(i, true);
					PLAYERS[i][pGamesWon]++;
				}
				
				else
				{
					ShowPlayerStats(i, false);
					PLAYERS[i][pGamesLost]++;
				}
				
				PLAYERS[i][pVoteMod] = NO_VOTE;
			}

		}
		
		default:
		{
			if(newscore < MODS[CURRENT_MOD][mMaxScore]) return true;

			EndGame();

			ShowPlayerStats(playerid, true);
			
			PLAYERS[playerid][pGamesWon]++;

			foreach(new i : Player)
			{
				PLAYERS[i][pGamesPlayed]++;
				
				PLAYERS[i][pKills] += PLAYERS[i][pKillsDG];
				PLAYERS[i][pDeaths] += PLAYERS[i][pDeathsDG];
			
				TogglePlayerControllable(i, false);
				SelectTextDraw(i, 0xFF000088);
				
				if(i == playerid) continue;
				
				ShowPlayerStats(i, false);
				PLAYERS[i][pGamesLost]++;
				
				PLAYERS[i][pVoteMod] = NO_VOTE;
			}
		}
	}
	
	return true;
}

//-----------------------------

forward OnPlayerLevelChange(playerid, oldlevel, newlevel);
public OnPlayerLevelChange(playerid, oldlevel, newlevel)
{
	switch(newlevel)
	{
		case MAX_PLAYER_LEVEL - 1:
		{		
			PLAYERS[playerid][pXp] = 0;
			PLAYERS[playerid][pXpMax] = MAX_PLAYER_XP;
		}
		
		case MAX_PLAYER_LEVEL:
		{
			PLAYERS[playerid][pXp] = PLAYERS[playerid][pXpMax] = MAX_PLAYER_XP;
		}
		
		default:
		{
			PLAYERS[playerid][pXp] = 0;
			PLAYERS[playerid][pXpMax] += floatround(floatmul(PLAYERS[playerid][pXpMax], 0.06));
		}
	}

	return true;
}

//-----------------------------

forward Timer_Kick(playerid);
public Timer_Kick(playerid)
	return Kick(playerid);

//-----------------------------
	
forward Mute();
public Mute()
{
	foreach(new i : Player)
	{
		if(!IsPlayerMute(i)) continue;
		
		if(--PLAYERS[i][pMute] == 0)
			SCM(i, -1, "Vous pouvez de nouveau parler et utiliser les commandes.");
	}
	
	return true;
}

//-----------------------------

forward UnfreezeSpawn(playerid);
public UnfreezeSpawn(playerid)
{
	TogglePlayerControllable(playerid, true);

	return true;
}

//-----------------------------

forward Timer_EndGame();
public Timer_EndGame()
{
	if(time_endgame == 0)
	{
		KillTimer(timer_time_endgame);
	
		new
			rand = random(MAX_NEXT_MODS),
			modid = modid_next_mods[rand],
			votes = votes_next_mods[rand];
	
		for(new i = 0 ; i < MAX_NEXT_MODS; i++)
		{
			if(votes_next_mods[i] >= votes)
			{
				if(votes_next_mods[i] == votes && random(2)) continue;
				
				modid = modid_next_mods[i];
				votes = votes_next_mods[i];
			}
		}
		
		Start(modid);
	
		foreach(new i : Player)
		{
			ResetStatsDG(i);
			HidePlayerStats(i);
			SpawnPlayer(i);
			CancelSelectTextDraw(i);
		}
		
		UpdateStats();
	
		return true;
	}
	
	time_endgame--;
	
	static
		str[3];
	
	format(str, sizeof(str), "%02d", time_endgame);
	TextDrawSetString(td_time_endgame, str);

	return true;
}