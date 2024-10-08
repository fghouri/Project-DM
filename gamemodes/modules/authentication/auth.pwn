#include <YSI_Coding\y_hooks>


new p_AccountID[MAX_PLAYERS];


hook OnPlayerConnect(playerid)
{
    p_PasswordAttempts[playerid] = 0;

    GetPlayerName(playerid, p_PlayerName[playerid], MAX_PLAYER_NAME);
    GetPlayerIp(playerid, p_PlayerIP[playerid], 16);

    new query[62];

    mysql_format(db, query, sizeof(query), "SELECT * FROM `USERS` WHERE NAME='%e' LIMIT 0,1", p_PlayerName[playerid]);
    mysql_tquery(db, query, "OnPlayerConnectCheck", "i", playerid);
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    p_AccountID[playerid] = -1;
    p_PasswordAttempts[playerid] = 0;
    p_PlayerName[playerid][0] = EOS;
    p_PlayerIP[playerid][0] = EOS;
}

thread OnPlayerConnectCheck(playerid)
{
    new rows;
    cache_get_row_count(rows);

    if(!rows)
    {
        ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "Account - Register", "Welcome to DM server, type in password", "Register", "Quit");
    }
    else
    {
        ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Account - Login", "Welcome to DM server, type in your password", "Login", "Quit");
    }
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_REGISTER)
    {
        if(!response) return Kick(playerid), 1;

        if(strlen(inputtext) > 16) return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "Account - Register", "Your Password exceeds 16 characters make sure it is wihtin 16 letters", "Register", "Quit");
        
        new query[101];

        mysql_format(db, query, sizeof(query), "INSERT INTO `USERS` (`NAME`, `PASSWORD`) VALUES ('%e', '%e')", p_PlayerName[playerid], inputtext);
        mysql_tquery(db, query, "OnPlayerRegister", "i", playerid);

        SendClientMessage(playerid, 0xFFFFFF, "registered kosmk");
    }
    if(dialogid == DIALOG_LOGIN)
    {
        if(!response) return Kick(playerid), 1;

        if(strlen(inputtext) > 16) return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Account - Login", "Incorrect Password", "Login", "Quit");
        
        new query[83];

        mysql_format(db, query, sizeof(query), "SELECT * FROM `USERS` WHERE `PASSWORD`='%e' AND `NAME`='%s'", inputtext, p_PlayerName[playerid]);
        mysql_tquery(db, query, "OnPlayerLogin", "i", playerid);
    }
    return 1;
}

thread OnPlayerRegister(playerid)
{
    p_AccountID[playerid] = cache_insert_id();
}

thread OnPlayerLogin(playerid)
{
    new rows;
    
    cache_get_row_count(rows);

    if(!rows) return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Account - Login", "Incorrect Password", "Login", "Quit");

    cache_get_value_name_int(0, "ID", p_AccountID[playerid]);

    return 1;
}