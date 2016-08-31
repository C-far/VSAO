#include "YSI\y_hooks"

//-----------------------------
//-------------------------------------------------
//-----------------------------

hook OnGameModeInit()
{
	td_background_main = TextDrawCreate(149.000000, 72.000000, "_");
	TextDrawBackgroundColor(td_background_main, 255);
	TextDrawFont(td_background_main, 1);
	TextDrawLetterSize(td_background_main, 0.180000, 8.099999);
	TextDrawColor(td_background_main, -1);
	TextDrawSetOutline(td_background_main, 0);
	TextDrawSetProportional(td_background_main, 1);
	TextDrawSetShadow(td_background_main, 1);
	TextDrawUseBox(td_background_main, 1);
	TextDrawBoxColor(td_background_main, 128);
	TextDrawTextSize(td_background_main, 500.000000, 0.000000);
	
	td_current_mod = TextDrawCreate(253.000000, 65.000000, "MOD:");
	TextDrawBackgroundColor(td_current_mod, 255);
	TextDrawFont(td_current_mod, 2);
	TextDrawLetterSize(td_current_mod, 0.799998, 5.500000);
	TextDrawColor(td_current_mod, -1711315201);
	TextDrawSetOutline(td_current_mod, 0);
	TextDrawSetProportional(td_current_mod, 1);
	TextDrawSetShadow(td_current_mod, 0);	
	
	td_victory = TextDrawCreate(262.000000, 65.000000, "VICTORY");
	TextDrawBackgroundColor(td_victory, 255);
	TextDrawFont(td_victory, 2);
	TextDrawLetterSize(td_victory, 0.799999, 5.500000);
	TextDrawColor(td_victory, 42843903);
	TextDrawSetOutline(td_victory, 0);
	TextDrawSetProportional(td_victory, 1);
	TextDrawSetShadow(td_victory, 0);
	
	td_defeat = TextDrawCreate(265.000000, 65.000000, "DEFEAT");
	TextDrawBackgroundColor(td_defeat, 255);
	TextDrawFont(td_defeat, 2);
	TextDrawLetterSize(td_defeat, 0.799998, 5.500000);
	TextDrawColor(td_defeat, -13421569);
	TextDrawSetOutline(td_defeat, 0);
	TextDrawSetProportional(td_defeat, 1);
	TextDrawSetShadow(td_defeat, 0);
	
	td_categories = TextDrawCreate(154.000000, 115.000000, "NAME SCORE KILLS DEATHS");
	TextDrawBackgroundColor(td_categories, 255);
	TextDrawFont(td_categories, 2);
	TextDrawLetterSize(td_categories, 0.619998, 3.299998);
	TextDrawColor(td_categories, -1);
	TextDrawSetOutline(td_categories, 0);
	TextDrawSetProportional(td_categories, 1);
	TextDrawSetShadow(td_categories, 0);
	
	//-----------------------------
	
	new
		Float:y_background = 126.000000,
		Float:y_line = 125.000000;

	for(new i = 0; i < MAX_SLOTS; i++)
	{
		switch(i)
		{
			case 4, 9: y_background += 22.500000, y_line += 22.500000;
			default: y_background += 23.000000, y_line += 23.000000;
		}
	
		td_background[i] = TextDrawCreate(149.000000, y_background, "_");
		TextDrawBackgroundColor(td_background[i], 255);
		TextDrawFont(td_background[i], 1);
		TextDrawLetterSize(td_background[i], 0.180000, 2.099998);
		TextDrawColor(td_background[i], -1);
		TextDrawSetOutline(td_background[i], 0);
		TextDrawSetProportional(td_background[i], 1);
		TextDrawSetShadow(td_background[i], 1);
		TextDrawUseBox(td_background[i], 1);
		TextDrawBoxColor(td_background[i], 128);
		TextDrawTextSize(td_background[i], 500.000000, 0.000000);

		td_name[i] = TextDrawCreate(190.000000, y_line, "");
		TextDrawAlignment(td_name[i], 2);
		TextDrawBackgroundColor(td_name[i], 255);
		TextDrawFont(td_name[i], 1);
		TextDrawLetterSize(td_name[i], 0.230000, 2.099999);
		TextDrawColor(td_name[i], -1);
		TextDrawSetOutline(td_name[i], 0);
		TextDrawSetProportional(td_name[i], 1);
		TextDrawSetShadow(td_name[i], 0);		

		td_score[i] = TextDrawCreate(269.000000, y_line, "");
		TextDrawAlignment(td_score[i], 2);
		TextDrawBackgroundColor(td_score[i], 255);
		TextDrawFont(td_score[i], 1);
		TextDrawLetterSize(td_score[i], 0.230000, 2.099999);
		TextDrawColor(td_score[i], -1);
		TextDrawSetOutline(td_score[i], 0);
		TextDrawSetProportional(td_score[i], 1);
		TextDrawSetShadow(td_score[i], 0);

		td_kills[i] = TextDrawCreate(350.000000, y_line, "");
		TextDrawAlignment(td_kills[i], 2);
		TextDrawBackgroundColor(td_kills[i], 255);
		TextDrawFont(td_kills[i], 1);
		TextDrawLetterSize(td_kills[i], 0.230000, 2.099999);
		TextDrawColor(td_kills[i], -1);
		TextDrawSetOutline(td_kills[i], 0);
		TextDrawSetProportional(td_kills[i], 1);
		TextDrawSetShadow(td_kills[i], 0);

		td_deaths[i] = TextDrawCreate(442.000000, y_line, "");
		TextDrawAlignment(td_deaths[i], 2);
		TextDrawBackgroundColor(td_deaths[i], 255);
		TextDrawFont(td_deaths[i], 1);
		TextDrawLetterSize(td_deaths[i], 0.230000, 2.099999);
		TextDrawColor(td_deaths[i], -1);
		TextDrawSetOutline(td_deaths[i], 0);
		TextDrawSetProportional(td_deaths[i], 1);
		TextDrawSetShadow(td_deaths[i], 0);		
	}
	
	//-----------------------------
	
	td_time_endgame = TextDrawCreate(302.000000, 39.000000, "");
	TextDrawBackgroundColor(td_time_endgame, 255);
	TextDrawFont(td_time_endgame, 3);
	TextDrawLetterSize(td_time_endgame, 0.730000, 3.699999);
	TextDrawColor(td_time_endgame, -1);
	TextDrawSetOutline(td_time_endgame, 0);
	TextDrawSetProportional(td_time_endgame, 1);
	TextDrawSetShadow(td_time_endgame, 1);
	TextDrawUseBox(td_time_endgame, 1);
	TextDrawBoxColor(td_time_endgame, -10218408);
	TextDrawTextSize(td_time_endgame, 331.000000, 0.000000);
	
	//-----------------------------
	
	td_next_mods[0] = TextDrawCreate(214.000000, 407.000000, "");
	TextDrawAlignment(td_next_mods[0], 2);
	TextDrawBackgroundColor(td_next_mods[0], 255);
	TextDrawFont(td_next_mods[0], 2);
	TextDrawLetterSize(td_next_mods[0], 0.200000, 2.300000);
	TextDrawColor(td_next_mods[0], -1);
	TextDrawSetOutline(td_next_mods[0], 0);
	TextDrawSetProportional(td_next_mods[0], 1);
	TextDrawSetShadow(td_next_mods[0], 0);
	TextDrawUseBox(td_next_mods[0], 1);
	TextDrawBoxColor(td_next_mods[0], 128);
	TextDrawTextSize(td_next_mods[0], 260.000000, 85.000000);
	TextDrawSetSelectable(td_next_mods[0], true);

	td_next_mods[1] = TextDrawCreate(328.000000, 407.000000, "");
	TextDrawAlignment(td_next_mods[1], 2);
	TextDrawBackgroundColor(td_next_mods[1], 255);
	TextDrawFont(td_next_mods[1], 2);
	TextDrawLetterSize(td_next_mods[1], 0.200000, 2.300000);
	TextDrawColor(td_next_mods[1], -1);
	TextDrawSetOutline(td_next_mods[1], 0);
	TextDrawSetProportional(td_next_mods[1], 1);
	TextDrawSetShadow(td_next_mods[1], 0);
	TextDrawUseBox(td_next_mods[1], 1);
	TextDrawBoxColor(td_next_mods[1], 128);
	TextDrawTextSize(td_next_mods[1], 373.000000, 85.000000);
	TextDrawSetSelectable(td_next_mods[1], true);

	td_next_mods[2] = TextDrawCreate(441.000000, 407.000000, "");
	TextDrawAlignment(td_next_mods[2], 2);
	TextDrawBackgroundColor(td_next_mods[2], 255);
	TextDrawFont(td_next_mods[2], 2);
	TextDrawLetterSize(td_next_mods[2], 0.200000, 2.300000);
	TextDrawColor(td_next_mods[2], -1);
	TextDrawSetOutline(td_next_mods[2], 0);
	TextDrawSetProportional(td_next_mods[2], 1);
	TextDrawSetShadow(td_next_mods[2], 0);
	TextDrawUseBox(td_next_mods[2], 1);
	TextDrawBoxColor(td_next_mods[2], 128);
	TextDrawTextSize(td_next_mods[2], 485.000000, 85.000000);
	TextDrawSetSelectable(td_next_mods[2], true);
	
	return 1;
}