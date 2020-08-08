#include <YSI_Coding\y_va>

/* ** Macros ** */
#define function%1(%2)                      forward%1(%2); public%1(%2)
#define RandomEx(%0,%1)                     (random((%1) - (%0)) + (%0))
#define HOLDING(%0)                         ((newkeys & (%0)) == (%0))
#define PRESSED(%0)                         (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define RELEASED(%0)                        (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
#define SendUsage(%0,%1)                    (SendClientMessageFormatted(%0,-1,"{FFAF00}[USAGE]{FFFFFF} " # %1))
#define SendError(%0,%1) 			        (SendClientMessageFormatted(%0,-1,"{F81414}[ERROR]{FFFFFF} " # %1))
#define SendServerMessage(%0,%1)            (SendClientMessageFormatted(%0,-1,"{C0C0C0}[SERVER]{FFFFFF} " # %1))
#define SendClientMessageToAllFormatted(%0) (SendClientMessageFormatted(INVALID_PLAYER_ID, %0))
#define sprintf(%1)                         (format(g_szSprintfBuffer, sizeof(g_szSprintfBuffer), %1), g_szSprintfBuffer)
#define SetObjectInvisible(%0)              (SetDynamicObjectMaterialText(%0, 0, " ", 140, "Arial", 64, 1, -32256, 0, 1))
#define fRandomEx(%1,%2)                    (floatrandom(%2-%1)+%1)
#define strmatch(%1,%2)                     (!strcmp(%1,%2,true))
#define Beep(%1)                            PlayerPlaySound(%1, 1137, 0.0, 0.0, 0.0)
#define StopSound(%1)                       PlayerPlaySound(%1,1186,0.0,0.0,0.0)
#define erase(%0)                           (%0[0]='\0')
#define positionToString(%0)                (%0==1?("st"):(%0==2?("nd"):(%0==3?("rd"):("th"))))
#define SetPlayerPosEx(%0,%1,%2,%3,%4)      SetPlayerPos(%0,%1,%2,%3),SetPlayerInterior(%0,%4)
#define points_format(%0)                   (number_format(%0, .prefix = '\0', .decimals = 2))
#define bool_to_string(%0)                  (%0 == true ? (COL_GREEN # "YES" # COL_WHITE) : (COL_RED # "NO" # COL_WHITE))
#define ResetPlayerWorldBounds(%0)          (SetPlayerWorldBounds(playerid, 20000.0000, -20000.0000, 20000.0000, -20000.0000))

/* ** Variables ** */
stock szSmallString[32];
stock szNormalString[144];
stock szBigString[256];
stock szLargeString[1024];
stock szHugeString[2116];
stock g_szSprintfBuffer[1024];
stock tmpVariable;

/* ** Function Hooks ** */
stock __svrticks__GetTickCount( )
{
    static
        offset = 0; // store the static value here

    new
        curr_tickcount = GetTickCount( );

    if ( curr_tickcount < 0 && offset == 0 )
    {
        offset = curr_tickcount * -1;
        print( "\n\n*** NEGATIVE TICK COUNT DETECTED... FIXING GetTickCount( )" );
    }
    return curr_tickcount + offset;
}

#if defined _ALS_GetTickCount
    #undef GetTickCount
#else
    #define _ALS_GetTickCount
#endif

#define GetTickCount __svrticks__GetTickCount

stock SendClientMessageFormatted(playerid, color, const format[], va_args<>)
{
    new message[144];

    va_format(message, sizeof(message), format, va_start<3>);

    if(playerid == INVALID_PLAYER_ID){
        return SendClientMessageToAll(-1, message), -1;
    } else {
        return SendClientMessage(playerid, color, message), 1;
    }
    return 0;
}