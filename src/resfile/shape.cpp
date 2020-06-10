#include <fstream>
#include "shape.h"

bool stuntsshape::parse(std::istream& strm, const char* id) {

	strm.read((char*)&numvertices, sizeof(unsigned char));
	strm.read((char*)&numprimitives, sizeof(unsigned char));
	strm.read((char*)&numpaints, sizeof(unsigned char));
	strm.read((char*)&reserved, sizeof(unsigned char));

	//cout << "numverts " << (int)numvertices << endl;
	//cout << "numprims " << (int)numprimitives << endl;

	vertices = new stuntsvertex[numvertices];
	for (int i = 0; i < numvertices; i++) {
		stuntsvertex& v = vertices[i];
		strm.read((char*)&v.x, sizeof(short));
		strm.read((char*)&v.y, sizeof(short));
		strm.read((char*)&v.z, sizeof(short));
		//v.x *= -1;
	}



	cull1 = new unsigned int[numprimitives];
	cull2 = new unsigned int[numprimitives];

	for (int i = 0; i < numprimitives; i++) {
		strm.read((char*)&cull1[i], sizeof(unsigned int));
	}

	for (int i = 0; i < numprimitives; i++) {
		strm.read((char*)&cull2[i], sizeof(unsigned int));
	}

	primitives = new stuntsprimitive[numprimitives];

	for (int i = 0; i < numprimitives; i++) {
		stuntsprimitive& primitive = primitives[i];

		parse_primitive(strm, primitive);

	}

	return true;
}


void stuntsshape::parse_primitive(std::istream& strm, stuntsprimitive& p) {

	strm.read((char*)&p.type, sizeof(unsigned char));
	strm.read((char*)&p.flags, sizeof(unsigned char));

	//cout << "primtype " << (int)p.type << endl;
	//cout << "primflag " << (int)p.flags << endl;

	p.materials = new unsigned char[numpaints];
	for (int j = 0; j < numpaints; j++) {
		strm.read((char*)&p.materials[j], sizeof(unsigned char));
	}

	// p.type <= 8 creates a green tingy which look horribly wrong?
	// For car body and track element shapes the first eight vertices are reserved for the corner vertices of the shape's bound box, used to cull entire shapes located outside the view frustum. 
	p.numindices = get_vertex_count(p.type);
	p.indices = new unsigned char[p.numindices];
	for (int j = 0; j < p.numindices; j++) {
		strm.read((char*)&p.indices[j], sizeof(unsigned char));
	}

}
