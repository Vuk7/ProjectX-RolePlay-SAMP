/*
================================================================================
--------------------------------------------------------------------------------
						CheckPoint include
		   	      				  by Vuk
						||English version||
--------------------------------------------------------------------------------
Check point types: NORMAL_CHECKPOINT, RACE_CHECKPOINT
--------------------------------------------------------------------------------
Functions:
CreateCheckpoint(Float:x,Float:y,Float:z,Float:size,type,Float:nextx=0.0, Float:nexty=0.0, Float:nextz=0.0,racetype=0); - create checkpoint
CheckpointExist(id); - return true if checkpoint exist
ShowPlayerCheckPoint(playerid,id); - showing checkpoint to player
DisableCheckPoint(playerid,type); - hiding players checkpoint
GetPlayerCheckPointID(playerid); - returning player checkpoints id
--------------------------------------------------------------------------------
Callbacks:
OnPlayerEnterToCheckPoint(playerid,checkpointid,type)
OnPlayerExitFromCheckPoint(playerid,checkpointid)
--------------------------------------------------------------------------------
================================================================================
*/

#if defined _checkpoints_included
  #endinput
#endif

#define _checkpoints_included
#pragma library checkpoints

#if defined MAX_CHECKPOINTS
#define MAX_CHECKPOINTS MAX_CHECKPOINTS
#else
#define MAX_CHECKPOINTS 500
#endif

#define NORMAL_CHECKPOINT 0
#define RACE_CHECKPOINT 1

#define INVALID_CHECKPOINT_ID -1

#include <a_samp>

forward OnPlayerEnterToCheckPoint(playerid,checkpointid,type);
forward OnPlayerExitFromCheckPoint(playerid,checkpointid);

enum cInfo
{
	bool:cUsing,
	Float:cX,
	Float:cY,
    Float:cZ,
    Float:cNexX,
    Float:cNexY,
    Float:cNexZ,
    Float:cSize,
	cRaceType,
	cType
}
new CheckPoint[MAX_CHECKPOINTS][cInfo];

stock CreateCheckpoint(Float:x,Float:y,Float:z,Float:size,type,Float:nextx=0.0, Float:nexty=0.0, Float:nextz=0.0,racetype=0)
{
	if(type != RACE_CHECKPOINT && type != NORMAL_CHECKPOINT) return print("ERROR with CreateCheckpoint!");
	new id;
	for(new i=0;i<MAX_CHECKPOINTS;i++) { if(!CheckPoint[i][cUsing]) { id=i; } }
    CheckPoint[id][cX] = x;
    CheckPoint[id][cY] = y;
    CheckPoint[id][cZ] = z;
    CheckPoint[id][cNexX] = nextx;
    CheckPoint[id][cNexY] = nexty;
    CheckPoint[id][cNexZ] = nextz;
    CheckPoint[id][cSize] = size;
    CheckPoint[id][cRaceType] = racetype;
    CheckPoint[id][cType] = type;
    CheckPoint[id][cUsing] = true;
	return id;
}

stock CheckpointExist(id)
{
	if(CheckPoint[id][cUsing]) return true;
	else return false;
}

stock ShowPlayerCheckPoint(playerid,id)
{
	if(CheckpointExist(id))
	{
	    if(CheckPoint[id][cType] == NORMAL_CHECKPOINT)
	    {
	        SetPlayerCheckpoint(playerid,CheckPoint[id][cX],CheckPoint[id][cY],CheckPoint[id][cZ],CheckPoint[id][cSize]);
	    }
	    else if(CheckPoint[id][cType] == RACE_CHECKPOINT)
	    {
	        SetPlayerRaceCheckpoint(playerid, CheckPoint[id][cRaceType], CheckPoint[id][cX],CheckPoint[id][cY],CheckPoint[id][cZ], CheckPoint[id][cNexX],CheckPoint[id][cNexY],CheckPoint[id][cNexZ], CheckPoint[id][cSize]);
	    }
	}
	else return print("ERROR with ShowPlayerCheckPoint!");
	return 1;
}

stock DisableCheckPoint(playerid,type)
{
    if(type != RACE_CHECKPOINT && type != NORMAL_CHECKPOINT) return print("ERROR with DisableCheckPoint!");
    if(type == NORMAL_CHECKPOINT) return DisablePlayerCheckpoint(playerid);
    else if(type == RACE_CHECKPOINT) return DisablePlayerRaceCheckpoint(playerid);
    return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	for(new i=0;i<MAX_CHECKPOINTS;i++)
	{
	    if(CheckpointExist(i))
	    {
	        if(CheckPoint[i][cType] == NORMAL_CHECKPOINT)
	        {
	            if(IsPlayerInRangeOfPoint(playerid,CheckPoint[i][cSize],CheckPoint[i][cX],CheckPoint[i][cY],CheckPoint[i][cZ]))
	            {
	                CallLocalFunction("OnPlayerEnterToCheckPoint","ddd",playerid,i,NORMAL_CHECKPOINT);
	            }
	        }
	    }
	}
    return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	for(new i=0;i<MAX_CHECKPOINTS;i++)
	{
	    if(CheckpointExist(i))
	    {
	        if(CheckPoint[i][cType] == RACE_CHECKPOINT)
	        {
	            if(IsPlayerInRangeOfPoint(playerid,CheckPoint[i][cSize],CheckPoint[i][cX],CheckPoint[i][cY],CheckPoint[i][cZ]))
	            {
	                CallLocalFunction("OnPlayerEnterToCheckPoint","ddd",playerid,i,RACE_CHECKPOINT);
	            }
	        }
	    }
	}
    return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	for(new i=0;i<MAX_CHECKPOINTS;i++)
	{
	    if(CheckpointExist(i))
	    {
			CallLocalFunction("OnPlayerExitFromCheckPoint","dd",playerid,i);
	    }
	}
    return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	for(new i=0;i<MAX_CHECKPOINTS;i++)
	{
	    if(CheckpointExist(i))
	    {
			CallLocalFunction("OnPlayerExitFromCheckPoint","dd",playerid,i);
	    }
	}
    return 1;
}

stock GetPlayerCheckPointID(playerid)
{
	for(new i=0;i<MAX_CHECKPOINTS;i++)
	{
	    if(CheckpointExist(i))
	    {
     		if(IsPlayerInRangeOfPoint(playerid,CheckPoint[i][cSize],CheckPoint[i][cX],CheckPoint[i][cY],CheckPoint[i][cZ])) return i;
		}
	}
	return -1;
}

stock DestroyCheckpoint(checkpointid)
{
	if(CheckpointExist(checkpointid))
	{
		CheckPoint[checkpointid][cUsing] = false;
		checkpointid = INVALID_CHECKPOINT_ID;
	}
	return 1;
}