#include <windows.h>   	// required for all Windows applications
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#define MAX_SIZE 1024

FILE *file;
char string[65535];

const unsigned char GROUND=' ';
const unsigned char WALL='@';

const unsigned char original[]=
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\
@@@                             \
@@@   @                     @@@ \
@@@  @@                       @ \
@@@   @                     @@@ \
@@@   @                     @   \
@@@  @@@                    @@@ \
@@@                             \
@@@                             \
@@@                             \
@@@            @                \
@@@           @@@               \
@@@            @                \
@@@                             \
@@@                             \
@@                              \
@@@                             \
@@@                             \
@@@                             \
@@@                             \
@@@                             \
@@@ @@@                     @ @ \
@@@ @                       @ @ \
@@@ @@@                     @@@ \
@@@ @ @                       @ \
@@@ @@@                       @ \
@@@                             \
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@";

/*"                                \
  @@@@@@                        \
  @    @@@@@           7        \
  @    @   @@@@@@@@@            \
  @      2         @            \
  @   @@ 2 @       @@@@@@@@     \
  @   @  2 @@@@@@@        @@@@  \
  @  @@  2 @     @@@@@@@@    @  \
  @  @             @      @@@@  \
  @ @  @@@@@@@@@@@@@ @@@@@@     \
  @ @      @         @          \
  @ @@@@   @@@@@@@@@@@          \
  @    @@@@@                    \
  @@@@@@                        \
                    4           \
                                \
          222222222222222       \
                                \
  @@@@@@                        \
  @    @@@@@           5        \
  @    @   @@@@@@@@@            \
  @                @@@@@@@@     \
  @   @@   @              @     \
  @   @    @@@@@@@    33  @@@@  \
  @  @@    @     @@@@  33    @  \
  @  @             @      @@@@  \
  @ @  @@@@@@@@@@@@@ @@@@@@     \
  @ @      @         @          \
  @ @@@@   @@@@@@@@@@@          \
  @    @@@@@                    \
  @@@@@@               6        \
                                ";*/

unsigned char filtered[MAX_SIZE];

typedef struct
{
	unsigned char Value;
	int Pos;
} STEP1;

typedef struct
{
	unsigned char Value;
	int Count;
} STEP2;

STEP1 S1[MAX_SIZE];
STEP2 S2[MAX_SIZE];

const void debugstring() { file=fopen("log.txt","a"); fprintf(file,string); fclose(file); }

const int step1()
{
	sprintf(string,"step1\n"); debugstring();

	int count=-1;

	for (int p=0; p!=(MAX_SIZE-1); ++p)
	{
		unsigned char value=original[p];
		if ( (value!=GROUND) && (value!=WALL) )		// if char not ground or wall
		{
			count++;
			S1[count].Value=value;	// add char to list
			S1[count].Pos=p;		// start fill count at 1

//sprintf(string,".replace %4ld %4ld\n",value,p); debugstring();
			value=GROUND;							// make char ground
		}
		filtered[p]=value;
	}
	return count;
}

const int step2()
{
	sprintf(string,"step2\n"); debugstring();

	int count=-1;
	unsigned char prev_char=255;

	for (int p=0; p!=(MAX_SIZE-1); ++p)
	{
		if (prev_char!=filtered[p]) 		// if char not same as last
		{
			prev_char=filtered[p];			// replace previous with this
			count++;
			S2[count].Value=prev_char;	// add char to list
			S2[count].Count=0;			// start fill count at 1
		}
		if (S2[count].Count==127)
		{
////			prev_char=input[p];			// replace previous with this
			count++;
			S2[count].Value=prev_char;	// add char to list
			S2[count].Count=0;			// start fill count at 1			
		}
		S2[count].Count++;			// same char as before so inc fill count

//sprintf(string,".check p %3ld pc %3ld fp %3ld c %3ld val %3ld cnt %3ld\n",p,prev_char,filtered[p],count,S2[count].Value,S2[count].Count); debugstring();

	}
	return count;
}

const int replace(const unsigned char value)
{
	switch (value) 
	{
		case ' ':
			return 0;
		case '@':
			return 1;

		case 'A':
			return 2;
		case 'B':
			return 3;
		case 'C':
			return 4;
		case 'D':
			return 5;
		case 'E':
			return 6;
		case 'F':
			return 7;
		case 'G':
			return 8;
		case 'H':
			return 9;
		case 'I':
			return 10;
		case 'J':
			return 11;
		case 'K':
			return 12;
		case 'L':
			return 13;
		case 'M':
			return 14;
		case 'N':
			return 15;
		case 'O':
			return 16;
		case 'P':
			return 17;
		case 'Q':
			return 18;
		case 'R':
			return 19;
		case 'S':
			return 20;
		case 'T':
			return 21;
		case 'U':
			return 22;
		case 'V':
			return 23;
		case 'W':
			return 24;
		case 'X':
			return 25;
		case 'Y':
			return 26;
		case 'Z':
			return 27;

		case '0':
			return 28;
		case '1':
			return 29;
		case '2':
			return 30;
		case '3':
			return 31;
		case '4':
			return 32;
		case '5':
			return 33;
		case '6':
			return 34;
		case '7':
			return 35;
		case '8':
			return 36;
		case '9':
			return 37;

		case '?':
			return 38;
		case '&':
			return 39;
		case '%':
			return 40;
		case '$':
			return 41;
		case '=':
			return 42;
		case '(':
			return 43;
		case ')':
			return 44;
		case '{':
			return 45;
		case '}':
			return 46;
		case '#':
			return 47;
		case '+':
			return 48;
		case '-':
			return 49;
		case '/':
			return 50;
		case '*':
			return 51;
		case '[':
			return 52;
		case ']':
			return 53;
		case ':':
			return 54;
		case '^':
			return 55;
		case '!':
			return 56;
		case '<':
			return 57;
		case '>':
			return 58;
		case '_':
			return 59;
		case '~':
			return 60;
		case '.':
			return 61;
		case ',':
			return 62;
		case ';':
			return 63;
	}
}

int main()
{
	file=fopen("log.txt","w");

	const int s1_count = step1();
	const int s2_count = step2();

	for (int p=0; p<=s2_count; p++)
	{
		const int byte_value = replace(S2[p].Value);
		const int byte_count = S2[p].Count;
//		sprintf(string,"p %4ld %4ld %4ld\n",p,S2[p].Value,S2[p].Count); debugstring();
		sprintf(string," !byte (%3ld *128) + %3ld\n",byte_value,byte_count); debugstring();
	}
	sprintf(string," !byte 0\n"); debugstring();

	for (int p=0; p<=s1_count; p++)
	{
		sprintf(string,"p %4ld %4ld %4ld\n",p,S1[p].Value,S1[p].Pos); debugstring();
	}
}
