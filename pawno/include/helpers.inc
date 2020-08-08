/*
 * Irresistible Gaming (c) 2018
 * Developed by Lorenc_
 * Module: helpers.inc
 * Purpose: functions that help your scripting life
 */

/* ** Includes ** */
#include                                    < YSI\y_va >

/* ** Macros ** */
#define function%1(%2)                      forward%1(%2); public%1(%2)
#define RandomEx(%0,%1)                     (random((%1) - (%0)) + (%0))
#define HOLDING(%0)                         ((newkeys & (%0)) == (%0))
#define PRESSED(%0)                         (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define SendUsage(%0,%1)                    (SendClientMessageFormatted(%0,-1,"{FFAF00}[USAGE]{FFFFFF} " # %1))
#define SendError(%0,%1) 			        (SendClientMessageFormatted(%0,-1,"{F81414}[ERROR]{FFFFFF} " # %1))
#define SendServerMessage(%0,%1)            (SendClientMessageFormatted(%0,-1,"{C0C0C0}[SERVER]{FFFFFF} " # %1))
#define sprintf(%1)                         (format(szLargeString, sizeof(szLargeString), %1), szLargeString) // thanks Slice
#define strmatch(%1,%2)                     (!strcmp(%1,%2,true))
#define Beep(%1)                            PlayerPlaySound(%1, 1137, 0.0, 0.0, 0.0)
#define erase(%0)                           (%0[0]='\0')
#define SetObjectInvisible(%0)              (SetDynamicObjectMaterialText(%0, 0, " ", 140, "Arial", 64, 1, -32256, 0, 1))

/* ** Variables ** */
stock szSmallString 						[ 32 ];
stock szNormalString 						[ 144 ];
stock szBigString 							[ 256 ];
stock szLargeString							[ 1024 ];
stock szHugeString							[ 2048 ];
stock tmpVariable;

/* ** Functions ** */
stock SendClientMessageFormatted( playerid, colour, format[ ], va_args<> )
{
    static
		out[ 144 ];

    va_format( out, sizeof( out ), format, va_start<3> );

	if ( !IsPlayerConnected( playerid ) ) {
		SendClientMessageToAll( colour, out );
		return 0;
	}
 	return SendClientMessage( playerid, colour, out );
}

// purpose: replaces a phrase in a string with whatever specified (credit Slice)
stock strreplace(string[], const search[], const replacement[], bool:ignorecase = false, pos = 0, limit = -1, maxlength = sizeof(string)) {
    // No need to do anything if the limit is 0.
    if (limit == 0)
        return 0;

    new
             sublen = strlen(search),
             replen = strlen(replacement),
        bool:packed = ispacked(string),
             maxlen = maxlength,
             len = strlen(string),
             count = 0
    ;


    // "maxlen" holds the max string length (not to be confused with "maxlength", which holds the max. array size).
    // Since packed strings hold 4 characters per array slot, we multiply "maxlen" by 4.
    if (packed)
        maxlen *= 4;

    // If the length of the substring is 0, we have nothing to look for..
    if (!sublen)
        return 0;

    // In this line we both assign the return value from "strfind" to "pos" then check if it's -1.
    while (-1 != (pos = strfind(string, search, ignorecase, pos))) {
        // Delete the string we found
        strdel(string, pos, pos + sublen);

        len -= sublen;

        // If there's anything to put as replacement, insert it. Make sure there's enough room first.
        if (replen && len + replen < maxlen) {
            strins(string, replacement, pos, maxlength);

            pos += replen;
            len += replen;
        }

        // Is there a limit of number of replacements, if so, did we break it?
        if (limit != -1 && ++count >= limit)
            break;
    }

    return count;
}
