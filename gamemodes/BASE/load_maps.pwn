stock LoadMaps()
{
	new const 
		buffer_map[] = "p<,>da<f>[3]a<f>[3]D(0)S(0)[32]S(0)[32]",
		buffer_spawn[] = "p<,>a<f>[3]f";

	new
		filename[16],
		File:file,
		str[128],
		
		model,
		Float:pos[3],
		Float:rot[3],
		
		texture_model,
		texture_txdname[32],
		texture_texturename[32],
		
		tmpobjid;
	
	for(new mapid = 0;; mapid++)
	{
		format(filename, sizeof filename, "maps/%03d.ini", mapid);
		
		if(!fexist(filename)) 
			break;
		
		file = fopen(filename);
		
		new
			firstline = true;
		
		while(fread(file, str))
		{
			StripsNewLine(str);
		
			if(firstline)
			{
				if(str[0] == '#')		
					strcat(MAPS[mapid][mapAuthor], str[1]);
				
				else
					strcat(MAPS[mapid][mapAuthor], "Unknown");
					
				firstline = false;
				
				continue;
			}
			
			sscanf(str, buffer_map, model, pos, rot, texture_model, texture_txdname, texture_texturename);

			tmpobjid = CreateDynamicObject(model, pos[0], pos[1], pos[2], rot[0], rot[1], rot[2], .worldid = mapid);
			
			if(texture_model != 0) SetDynamicObjectMaterial(tmpobjid, 0, texture_model, texture_txdname, texture_texturename, 0x00000000);

			MAPS[mapid][mapNbrObjects]++;
		}
		
		Iter_Add(Map, mapid);
		
		fclose(file);
		
		#define angle rot[0]
		
		format(filename, sizeof filename, "spawns/%03d.ini", mapid);
		
		if(!fexist(filename)) 
		{
			printf("ERROR: %s doesn't exist", filename);
			SendRconCommand(!"exit");
		}
		
		file = fopen(filename);
		
		#define spawnid MAPS[mapid][mapNbrSpawns]
		
		while(fread(file, str))
		{	
			if(spawnid == MAX_SPAWNS_PER_MAP)
				break;
		
			sscanf(str, buffer_spawn, pos, angle);
			MAPS[mapid][mapSpawnsX][spawnid] = pos[0];
			MAPS[mapid][mapSpawnsY][spawnid] = pos[1];
			MAPS[mapid][mapSpawnsZ][spawnid] = pos[2];
			MAPS[mapid][mapSpawnsA][spawnid] = angle;
			
			MAPS[mapid][mapNbrSpawns]++;
		}
		
		fclose(file);
		
		#undef angle
		#undef spawnid
	}
	
	return 1;
}