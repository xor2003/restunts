#include <fstream>
#include <iostream>
#include <limits>
#include <cassert>
#include "resfile.h"

using std::cout;
using std::endl;

bool resfile::open(const char* fn) {

	fs.open(fn, std::ios::in | std::ios::binary);
	if (!fs) return false;

	fs.read((char*)&size, sizeof(unsigned int));
	fs.read((char*)&chunks, sizeof(unsigned short));

	//cout << "size  : " << size << endl;
	//cout << "chunks: " << chunks << endl;

	resources = new resinfo[chunks];

	for (int i = 0; i < chunks; i++) {
		memset(resources[i].id, 0, 5);
		fs.read(resources[i].id, 4);
	}

	for (int i = 0; i < chunks; i++) {
		fs.read((char*)&resources[i].offset, sizeof(unsigned int));
		//cout << resources[i].id << ": " << resources[i].offset << endl;
	}

	dataoffset = 6 + chunks * 8;

	return true;
}

int resfile::find_resource(const char* id) {
	for (int i = 0; i < chunks; i++) {
		if (strcmp(resources[i].id, id) == 0) return i;
	}
	return -1;
}

int resfile::find_next_resource(unsigned int ofs) {
	unsigned int smallest = std::numeric_limits<unsigned int>::max();
	int smallest_index = -1;
	for (int i = 0; i < chunks; i++) {
		if (resources[i].offset > ofs && resources[i].offset < smallest) {
			smallest = resources[i].offset;
			smallest_index = i;
		}
	}
	//if (smallest == std::numeric_limits<unsigned int>::max()) return -1;
	return smallest_index;
}

bool resfile::seek_resource(const char* id, unsigned int* length) {
	int index = find_resource(id);

	if (index < 0) return false;

	int next_index = find_next_resource(resources[index].offset);

	if (next_index == - 1) {
		*length = size - (dataoffset + resources[index].offset);
	} else {
		*length = resources[next_index].offset - resources[index].offset;
	}
	fs.seekg(dataoffset + resources[index].offset, SEEK_SET);

	return true;
}

bool resfile::read_resource(const char* id, unsigned int* length, char** buffer) {
	int index = find_resource(id);

	if (index < 0) return false;

	int next_index = find_next_resource(resources[index].offset);

	if (next_index == - 1) {
		*length = size - (dataoffset + resources[index].offset);
	} else {
		*length = resources[next_index].offset - resources[index].offset;
	}
	*buffer = new char[*length];
	fs.seekg(dataoffset + resources[index].offset, SEEK_SET);
	fs.read(*buffer, *length);
	return true;
}

void resfile::close() {
	fs.close();
}

