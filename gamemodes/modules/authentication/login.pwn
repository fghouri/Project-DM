#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid)
{
    p_PasswordAttempts[playerid] = 0;

    GetPlayerName(playerid, p_PlayerName[playerid], MAX_PLAYER_NAME);
    GetPlayerIp(playerid, p_PlayerIP[playerid], 16);

    mysql_format(db, szNormalString, sizeof(szNormalString), "SELECT * FROM `USERS` WHERE ")

    return 1;
}