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

CMD:contributions(playerid)
{
    mysql_tquery(db, "SELECT * FROM `contribution_list`", "OnReadContributions", "i", playerid);
    return 1;
}

thread OnReadContributions(playerid)
{
    new rows, header[68];
    header = COL_WHITE"Player Name\t"COL_WHITE"Discord ID\t"COL_WHITE"Status\n";
    cache_get_row_count(rows);
    if(!rows)
    {
        new result[128];
        if(IsPlayerAdmin(playerid))
        {
            p_isCreditsListEmpty = true;
            format(result, sizeof(result), "%s"COL_GREEN"+ Add a user in to the list", header);
            ShowPlayerDialog(playerid, DIALOG_CREDITS, DIALOG_STYLE_TABLIST_HEADERS, COL_WHITE"Contributors to this Server", result, "Add", "Close");
        }
        else
        {
            format(result, sizeof(result), "%s"COL_RED"There's no-one to show.", header);
            ShowPlayerDialog(playerid, DIALOG_CREDITS_FOUND_NONE, DIALOG_STYLE_TABLIST_HEADERS, COL_WHITE"Contributors to this Server", result, "Okay", "");
        }
    }
    else
    {
        new result[512];
        for(new i; i < rows; i++)
        { 
            new name[24], discord_id[60];
            cache_get_value_name(i, "NAME", name);
            cache_get_value_name(i, "DISCORD_ID", discord_id);

            if(IsPlayerConnected(GetPlayerIDFromName(name)))
            {
                format(result, sizeof(result), "%s%s\t%s\t"COL_GREEN"Online\n", result, name, discord_id);
            }
            else
            {
                format(result, sizeof(result), "%s%s\t%s\t"COL_RED"Offline\n", result, name, discord_id);
            }
        }
        p_isCreditsListEmpty = false;
        if(IsPlayerAdmin(playerid))
            format(result, sizeof(result), "%s%s\n"COL_GREEN"+ Add a user in to the list", header, result);
        else
            format(result, sizeof(result), "%s%s", header, result);
        ShowPlayerDialog(playerid, DIALOG_CREDITS, DIALOG_STYLE_TABLIST_HEADERS, COL_WHITE"Contributors to this Server", result, "Select", "Close");
    }
    return 1;
}

CMD:setweather(playerid, params[])
{
    if(isnull(params)) return SendUsage(playerid, "/setweather [WEATHER_ID]");
    if(!isint(params)) return SendError(playerid, "Weather ID should be numeric.");
    SetPlayerWeather(playerid, strval(params));
    SendClientMessageFormatted(playerid, -1, COL_GREEN"[SUCCESS]{FFFFFF} You have changed your weather to %d.", strval(params));
    return 1;
}

CMD:settime(playerid, params[])
{
    if(isnull(params)) return SendUsage(playerid, "/settime [TIME IN HOURS]");
    if(!isint(params)) return SendError(playerid, "Time input can only be numeric.");
    if(0 < strval(params) > 24) return SendError(playerid, "Time input can only be between 0-24 hours.");
    SetPlayerTime(playerid, strval(params), 0);
    SendClientMessageFormatted(playerid, -1, COL_GREEN"[SUCCESS]{FFFFFF} You have set your time to %d:00.", strval(params));
    return 1;
}
CMD:afklist(playerid)
{
    erase(szHugeString);
    new afk_players = 0,
    header[38] = COL_WHITE"Player\t"COL_WHITE"AFK For\n";
    foreach(new i : Player)
    {
        if(IsPlayerAFK(i))
        {
            format(szHugeString, sizeof(szHugeString), "%s%s(%d)\t%s\n", szHugeString, ReturnPlayerName(i), i, secondstotime(playerupdate[i]));
            afk_players++;
        }
    }
    if(afk_players == 0) return SendError(playerid, "There are no {00CDFF}AFK{FFFFFF} players at the moment.");
    format(szHugeString, sizeof(szHugeString), "%s%s", header, szHugeString);
    if(afk_players == 1)
        ShowPlayerDialog(playerid, DIALOG_AFK_LIST, DIALOG_STYLE_TABLIST_HEADERS, sprintf("There's only %d player AFK", afk_players), szHugeString, "Okay", "");
    else
        ShowPlayerDialog(playerid, DIALOG_AFK_LIST, DIALOG_STYLE_TABLIST_HEADERS, sprintf("There are only %d players AFK", afk_players), szHugeString, "Okay", "");
    return 1;
}

CMD:idletime(playerid, params[]) return pc_cmd_isafk(playerid, params);
CMD:isafk(playerid, params[])
{
    new tID;
    if(sscanf(params, "u", tID)) return SendUsage(playerid, "/isafk/idletime [PLAYER_ID]");
    else if(!IsPlayerConnected(tID) || IsPlayerNPC(tID)) return SendError(playerid, "Invalid Player ID.");
    else{
        if(IsPlayerAFK(tID)) return SendClientMessageFormatted(playerid, -1, "{00CDFF}[AFK]{FFFFFF} %s(%d) is AFK for %s seconds.", ReturnPlayerName(tID), tID, secondstotime(playerupdate[tID]));
        else{
            SendClientMessageFormatted(playerid, -1, "{00CDFF}[AFK]{FFFFFF} %s(%d) is not AFK.", ReturnPlayerName(tID), tID);
        }
    }
    return 1;
}
