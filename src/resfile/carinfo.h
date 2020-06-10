#pragma once

#include <istream>

#pragma pack (push, 1)

struct point2d {
	short x, y;
};

struct carinfo {

	unsigned char numgears;
	unsigned char unk1;
	unsigned short carmass;
	unsigned short braking;
	unsigned short idlerpm;
	unsigned short downshiftrpm;
	unsigned short upshiftrpm;
	unsigned short maxrpm;
	unsigned short gearratio[7];
	point2d knobs[7];
	unsigned short aeroresistance;	// 20-52 in the original cars
	unsigned char torquecurve[104]; // 0 is idle
	unsigned char unk11[2];
	unsigned short grip; // The default cars have values ranging from slightly lower than 0100h to slightly higher than 0200h. 
	unsigned char unk9[14];
	unsigned short surfacegrip[5]; // surfacegrip[0] is described as sliding oversteer/air-sliding
	unsigned char unk10[10];

	unsigned short collide[4];
	unsigned short carheight;
	unsigned short wheelcoords[3*4]; // Finally, the ratio between the physical coordinates for the wheels and the corresponding 3D shape coordinates is 64:1. 
	unsigned char steeringdots[62]; // ??
	unsigned short spd_centerx;
	unsigned short spd_centery;
	unsigned short spd_numpts;
	unsigned char speedometer[208]; // ??
	unsigned short rev_centerx;
	unsigned short rev_centery;
	unsigned short rev_numpts;
	unsigned char revneedle[256]; // ??
	unsigned short* aerotbl;
	
	bool parse(std::istream& strm) {
		int size = sizeof(carinfo);
		strm.read((char*)this, sizeof(carinfo));
		return true;
	}
};

#pragma pack (pop)
