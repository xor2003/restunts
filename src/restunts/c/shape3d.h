#ifndef RESTUNTS_SHAPE3D_H
#define RESTUNTS_SHAPE3D_H

#include "math.h"

#pragma pack (push, 1)

struct SHAPE3D {
	unsigned short shape3d_numverts;
	struct VECTOR far* shape3d_verts;
	unsigned short shape3d_numprimitives;
	unsigned short shape3d_numpaints;
	char far* shape3d_primitives;
	char far* shape3d_cull1;
	char far* shape3d_cull2;
};

struct SHAPE3DHEADER {
	unsigned char header_numverts;
	unsigned char header_numprimitives;
	unsigned char header_numpaints;
	unsigned char header_reserved;
};

struct TRANSFORMEDSHAPE3D {
	struct VECTOR pos;
	struct SHAPE3D* shapeptr;
	struct RECTANGLE* rectptr;
	struct VECTOR rotvec;
	unsigned short unk;
	unsigned char ts_flags;
	unsigned char material;
};

#pragma pack (pop)

int shape3d_load_all(void);
void shape3d_free_all(void);
void shape3d_init_shape(char far* shapeptr, struct SHAPE3D* gameshape);
unsigned transformed_shape_op(struct TRANSFORMEDSHAPE3D* arg_transshapeptr);
void set_projection(int i1, int i2, int i3, int i4);
int polarAngle(int z, int y);
unsigned select_cliprect_rotate(int angZ, int angX, int angY, struct RECTANGLE* cliprect, int unk);
void init_polyinfo(void);
void polyinfo_reset(void);
void get_a_poly_info(void);
void sub_204AE(struct VECTOR far* arg_verts, int arg_4, short* arg_6, short* arg_8, struct VECTOR* arg_vecarray, struct VECTOR* arg_vecptr);

#endif
