/**

	native AddMod(const modname[], const shortmodname[], e_MOD_TYPE:type, maxscore = DEFAULT_MAX_SCORE_MOD, const author[] = "Unknown");
	native AddMapMod(modid, mapid);
	native RemoveMapMod(modid, mapid);
	native CountMapsMod(modid);
	
**/

#define MOD_LOADED(%0) (%0 >= 0)

//-----------------------------

/* Return <value> : 
	-1 : if the name is less than 4.
	-2 : if the short name is not between 2 and 4 letters.
	-3 : if the classid isn't existing
	-4 : if the max mods is reached. 
	otherwise : the id of the mod added. */
stock AddMod(const modname[], const shortmodname[], e_MOD_TYPE:type, classid = NO_CLASS, maxscore = DEFAULT_MAX_SCORE_MOD, const author[] = "Unknown")
{	
	if(strlen(modname) < 4) return -1;
	if(!(2 <= strlen(shortmodname) <= 4)) return -2;
	
	if(classid != NO_CLASS)
	{
		if(!Iter_Contains(Class, classid)) return -3;
	}
	
	new
		modid = Iter_Free(Mod);
	
	if(modid == -1) return -4;
		
	Iter_Add(Mod, modid);
	
	strunpack(MODS[modid][mAuthor], author);
	strunpack(MODS[modid][mName], modname);
	strunpack(MODS[modid][mShortName], shortmodname);
	
	MODS[modid][mType] = type;
	MODS[modid][mMaxScore] = maxscore;
	
	MODS[modid][mClass] = classid;

	for(new i = 0; i < MAX_MAPS_PER_MOD; i++)
		MODS[modid][mMaps][i] = NO_MAP;
	
	return modid;
}

//-----------------------------

/* Return <bool> :
	- true : success
	- false : modid/mapid is invalid */
stock AddMapMod(modid, mapid)
{
	if(!IsValidMod(modid) || !IsValidMap(mapid)) return false;
	
	new
		n_map = 0;

	for(; n_map < MAX_MAPS_PER_MOD; n_map++)
	{
		if(MODS[modid][mMaps][n_map] == NO_MAP) break;
	}
		
	if(n_map == MAX_MAPS_PER_MOD) return false;
		
	MODS[modid][mMaps][n_map] = mapid;
	MODS[modid][mNbrMaps]++;
	
	return true;
}

//-----------------------------

/* Return <bool> :
	- true : success
	- false : modid/mapid is invalid */
stock RemoveMapMod(modid, mapid)
{
	if(!IsValidMod(modid) || !IsValidMap(mapid)) return false;

	for(new n_map = 0; n_map < MAX_MAPS_PER_MOD; n_map++)
	{
		if(MODS[modid][mMaps][n_map] == mapid)
		{
			MODS[modid][mMaps][n_map] = NO_MAP;
			MODS[modid][mNbrMaps]--;
			
			break;
		}
	}
	
	return n_map != MAX_MAPS_PER_MOD;
}

//-----------------------------

/* Return <value> :
	- -1 : modid is invalid
	- otherwise : the number of maps for the modid */
stock CountMapsMod(modid)
{
	if(!IsValidMod(modid)) return -1;
		
	return MODS[modid][mNbrMaps];
}