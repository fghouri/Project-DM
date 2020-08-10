#include <YSI_Coding\y_hooks>

#define GetPlayerFPS(%0)                (p_FPS[%0])

hook OnPlayerConnect(playerid)
{
	p_FPS_DrunkLevel[playerid] = 0;
	p_FPS[playerid] = 0;
	return 1;
}

hook OnPlayerUpdate(playerid)
{
    new
    	iDrunkLevel = GetPlayerDrunkLevel(playerid);

    // Calculate FPS
    if (iDrunkLevel < 100) SetPlayerDrunkLevel(playerid, 2000);
   	else
   	{
        if (p_FPS_DrunkLevel[playerid] != iDrunkLevel) {
            new iFPS = p_FPS_DrunkLevel[playerid] - iDrunkLevel;

            if ((iFPS > 0) && (iFPS < 200))
                p_FPS[playerid] = iFPS;

            p_FPS_DrunkLevel[playerid] = iDrunkLevel;
        }
    }
	return 1;
}

CMD:pinfo(playerid, params[])
{
    new targetID;
    if(sscanf(params, "u", targetID)) return SendUsage(playerid, "/pinfo [PLAYER_NAME|ID]");
    else if(!IsPlayerConnected(targetID) || IsPlayerNPC(targetID)) return SendError(playerid, "Invalid Player ID.");
    else
    {
        SendClientMessageFormatted(playerid, -1, COL_RED"[PLAYER-INFO] %s(%d)'s: "COL_WHITE"Ping: %d MS, Packetloss: %0.2f, FPS: %d", ReturnPlayerName(targetID), targetID, GetPlayerPing(targetID), NetStats_PacketLossPercent(targetID), GetPlayerFPS(targetID));
    }
    return 1;
}

CMD:packetloss(playerid) return pc_cmd_pl(playerid);
CMD:pl(playerid)
{
    SendClientMessageFormatted(playerid, -1, COL_RED"[PACKETLOSS]"COL_WHITE" Your packetloss is %0.2f", NetStats_PacketLossPercent(playerid));
    return 1;
}