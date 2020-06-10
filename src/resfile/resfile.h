
struct resinfo {
	
	struct idtype {
		unsigned char id1,id2,id3,id4;
	};

	union {
		idtype idbytes;
		char id[5];
	};

	unsigned int offset;

};

struct resfile {
	std::ifstream fs;
	unsigned int size;
	unsigned short chunks;
	resinfo* resources;
	int dataoffset;

	bool open(const char* fn);
	bool read_resource(const char* id, unsigned int* length, char** buffer);
	bool seek_resource(const char* id, unsigned int* length);
	void close();

	int find_resource(const char* id);
	int find_next_resource(unsigned int offset);
};
