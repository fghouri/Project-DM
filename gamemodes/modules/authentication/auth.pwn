#include <YSI_Coding\y_hooks>

new p_AccountID[MAX_PLAYERS];


hook OnPlayerConnect(playerid)
{
    p_PasswordAttempts[playerid] = 0;

    GetPlayerName(playerid, p_PlayerName[playerid], MAX_PLAYER_NAME);
    GetPlayerIp(playerid, p_PlayerIP[playerid], 16);

    new query[62];

    mysql_format(db, query, sizeof(query), "SELECT * FROM `USERS` WHERE NAME='%e' LIMIT 0,1");
    mysql_tquery(db, query, "OnPlayerConnectCheck", "i", playerid);
    return 1;
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

        if(strlen(inputtext) > 16) ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "Account - Register", "Your Password exceeds 16 characters make sure it is wihtin 16 letters", "Register", "Quit");
        
        new query[101];

        mysql_format(db, query, sizeof(query), "INSERT INTO `USERS` (`NAME`, `PASSWORD`) VALUES ('%e', '%e')", p_PlayerName[playerid], inputtext);
        mysql_tquery(db, query, "OnPlayerRegister", "i", playerid);
    }
    return 1;
}


thread OnPlayerRegister(playerid)
{
    p_AccountID[playerid] = cache_insert_id();
}