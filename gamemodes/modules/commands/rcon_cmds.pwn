hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    // Edit credits list for RCON
    if(dialogid == DIALOG_CREDITS && response)
    {
        if(!IsPlayerAdmin(playerid)) return SendError(playerid, "Only people with RCON access can edit credits list.");
        if(listitem == -1) return SendError(playerid, "Invalid listitem selected.");

        switch(p_isCreditsListEmpty)
        {
            case false:
            {
                format(p_CreditsInputText[playerid], sizeof(p_CreditsInputText[]), "%s", inputtext);
                if(!strmatch(p_CreditsInputText[playerid], "+ Add a user in to the list"))
                    ShowPlayerDialog(playerid, DIALOG_CREDITS_REMOVE_ROW, DIALOG_STYLE_MSGBOX, "Are you sure?", sprintf(COL_WHITE"Are you sure you want to remove %s from credits list?", p_CreditsInputText[playerid]), "Yes", "No");
                else
                    ShowPlayerDialog(playerid, DIALOG_CREDITS_ADD_PLAYER_NAME, DIALOG_STYLE_INPUT, COL_WHITE"Who do you wish to add?", COL_WHITE"Type Player's Name", "Next Step", "Cancel");
                return 1;
            }
            case true:
            {
                ShowPlayerDialog(playerid, DIALOG_CREDITS_ADD_PLAYER_NAME, DIALOG_STYLE_INPUT, COL_WHITE"Who do you wish to add?", COL_WHITE"Type Player's Name", "Next Step", "Cancel");
            }
        }
        return 1;
    }
    else if(dialogid == DIALOG_CREDITS_REMOVE_ROW && response)
    {
        if(!IsPlayerAdmin(playerid)) return SendError(playerid, "Only people with RCON access can edit credits list.");
        new query[64];
        erase(query);
        mysql_format(db, query, sizeof(query), "DELETE FROM `contribution_list` WHERE `NAME` = '%e'", p_CreditsInputText[playerid]);
        mysql_tquery(db, query);
        printf(query);
        SendClientMessageFormatted(playerid, -1, COL_GREEN"[SUCCESS] {FFFFFF}Removed %s from the credits list.", p_CreditsInputText[playerid]);
        erase(p_CreditsInputText[playerid]);
        return 1;
    }
    else if(dialogid == DIALOG_CREDITS_ADD_PLAYER_NAME && response)
    {
        format(p_CreditsInputText[playerid], sizeof(p_CreditsInputText[]), "%s", inputtext);
        SendClientMessage(playerid, -1, COL_GREEN"[SUCCESS]{FFFFFF} Success! Proceeding to the next step: Add Discord ID. You can still stop by clicking on 'Cancel' button.");
        ShowPlayerDialog(playerid, DIALOG_CREDITS_ADD_PLAYER_DISCORD, DIALOG_STYLE_INPUT, COL_WHITE"Who do you wish to add?", COL_WHITE"Type Player's Discord ID", "Finish", "Cancel");
        return 1;
    }
    else if(dialogid == DIALOG_CREDITS_ADD_PLAYER_DISCORD && response)
    {
        new query[128];
        erase(query);
        SendClientMessageFormatted(playerid, -1, COL_GREEN"[SUCCESS]{FFFFFF} You have added another contributor(Name: %s, Discord: %s) into the credits list.", p_CreditsInputText[playerid], inputtext);

        mysql_format(db, query, sizeof(query), "INSERT INTO `contribution_list` (`NAME`, `DISCORD_ID`) VALUES ('%e', '%e')", p_CreditsInputText[playerid], inputtext);
        mysql_tquery(db, query);
        printf(query);

        p_isCreditsListEmpty = false;

        return pc_cmd_credits(playerid), 1;
    }
    return 1;
}