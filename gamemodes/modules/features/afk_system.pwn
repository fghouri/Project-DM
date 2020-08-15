#include <YSI_Coding\y_hooks>

#define MAX_AFK_TIME 			30 //in Minutes!
#define LABEL_DRAW_DISTANCE     50.0

hook OnPlayerConnect(playerid)
{
	AFKLabel[playerid] = Create3DTextLabel(" ",0x000000,0.0,0.0,0.0,LABEL_DRAW_DISTANCE,0,1);
	Attach3DTextLabelToPlayer(AFKLabel[playerid], playerid, 0.0, 0.0, 1.0);
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	Delete3DTextLabel(AFKLabel[playerid]);
	return 1;
}

task PerPlayerTimer[1000]()
{
	foreach(new i : Player)
	{
		UpdatePlayerAFKStatus(i);
	}
}

UpdatePlayerAFKStatus(playerid)
{
	new string[128];
	if(GetTickCount() > (GetPVarInt(playerid,"UpdatePlayerAFKStatus") + 1000) && GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)
	{
		playerupdate[playerid]++;
	    if(playerupdate[playerid] > 60)
		{
		    new mins,secs;
		    mins = playerupdate[playerid] / 60;
		    secs = playerupdate[playerid] - (mins * 60);
		    if(mins == 1) format(string,sizeof(string),"AFK for\n%d minute and %d seconds",mins, secs);
		    else format(string,sizeof(string),"AFK for\n%d minutes and %d seconds",mins, secs);
		}
		else format(string,sizeof(string),"AFK for\n%d seconds", playerupdate[playerid]);
	    Update3DTextLabelText(AFKLabel[playerid], 0x00CDFFFF, string);
	}
	else
	{
        Update3DTextLabelText(AFKLabel[playerid],0x00000000, " ");
	}
}

hook OnPlayerUpdate(playerid)
{
	SetPVarInt(playerid, "UpdatePlayerAFKStatus", GetTickCount());
	playerupdate[playerid] = 0;
	return 1;
}

stock IsPlayerAFK(playerid)
{
    if(GetTickCount() > ( GetPVarInt(playerid,"UpdatePlayerAFKStatus") + 3000 ) && GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)
    {
        return 1;
    }
    return 0;
}