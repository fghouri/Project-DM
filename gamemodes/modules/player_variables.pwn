new
    p_PasswordAttempts              [MAX_PLAYERS],
    p_PlayerName                    [MAX_PLAYERS][MAX_PLAYER_NAME],
    p_PlayerIP                      [MAX_PLAYERS][16],
    p_FPS_DrunkLevel 				[MAX_PLAYERS],
	p_FPS 							[MAX_PLAYERS],
    p_CreditsInputText              [MAX_PLAYERS][64],
    bool: p_isCreditsListEmpty      = false,
    Text3D:AFKLabel                 [MAX_PLAYERS],
    playerupdate                    [MAX_PLAYERS]
;