#pragma once

struct stuntsvertex {
	short x, y, z;
};

struct stuntsprimitive {
	unsigned char type, flags;
	int numindices;
	unsigned char* indices;
	unsigned char* materials;
};

//struct stuntsshapefile;

struct stuntsshape {
	char id[5];
	unsigned char numvertices, numprimitives, numpaints, reserved;
	stuntsvertex* vertices;
	unsigned int* cull1;
	unsigned int* cull2;
	stuntsprimitive* primitives;

	bool parse(std::istream& strm, const char* id);
	void parse_primitive(std::istream& strm, stuntsprimitive& p);
};


/*
type verts
1		1	Particle, 1 pixel
2		2	Line segment, 1 pixel width
3–10	3–10	Polygon, n sides
11		2	Sphere (center + ~(radius / 2)
12		6	Wheel
*		0	Ignored 
*/
#define PRIM_TYPE_PARTICLE 1
#define PRIM_TYPE_LINE     2
#define PRIM_TYPE_SPHERE   11
#define PRIM_TYPE_WHEEL    12

#define PRIM_FLAG_TWOSIDED (1 << 0)
#define PRIM_FLAG_ZBIAS    (1 << 1) 

inline int get_vertex_count(int type) {
	if (type < PRIM_TYPE_PARTICLE || type > PRIM_TYPE_WHEEL) {
		return 0;
	}
	else if (type == PRIM_TYPE_SPHERE) {
		return 2;
	}
	else if (type == PRIM_TYPE_WHEEL) {
		return 6;
	}
	else {
		return type;
	}
}
