#include <fstream>

void next_offset(unsigned short* arg0, unsigned short* arg2, unsigned long arg4) {
	unsigned short var2;
	arg4 += *arg0;
	var2 = arg4 / 0x10;
	*arg2 += var2;
	*arg0 = arg4 - (var2 << 4);
}

bool apply_dif(const char* filename, char* bytes) {
	std::ifstream fs;
	fs.open(filename, std::ios::in | std::ios::binary);

	if (!fs) return false;

	unsigned short var8;
	unsigned char val1;
	unsigned short output_ofs = 0x0000;
	unsigned short output_seg = 0x0000;//0x01A7;

	if (output_ofs == 0)
		output_seg -= 0x1000;

	output_ofs--;

	next_offset(&output_ofs, &output_seg, 0);

	while (true) {
		fs.read((char*)&var8, sizeof(unsigned short));
		if (var8 == 0) break; // eof

		next_offset(&output_ofs, &output_seg, var8 & 0x7fff);

		int pos = output_seg << 4 | output_ofs;
		char* buffer = &bytes[pos];

		fs.read((char*)buffer, sizeof(unsigned char));
		fs.read((char*)&buffer[1], sizeof(unsigned char));

		if ((var8 & 0x8000) != 0) {
			fs.read((char*)&buffer[2], sizeof(unsigned char));
			fs.read((char*)&buffer[3], sizeof(unsigned char));
		}
	}


	fs.close();

	return true;
}

size_t copy_binary(const char* filename, char* exeimage) {
	std::ifstream fs;
	fs.open(filename, std::ios::in | std::ios::binary);
	if (!fs) return 0;
	fs.seekg(0, SEEK_END);
	size_t size = fs.tellg();
	fs.seekg(0, SEEK_SET);

	fs.read(exeimage, size);
	fs.close();

	return size;
}

void save_binary(std::string filename, char* image, int size) {
	std::ofstream fs;
	fs.open(filename.c_str(), std::ios::out | std::ios::binary);
	fs.write(image, size);
	fs.close();
}

int main() {

	char exehdr[30];

	copy_binary("assets\\mcga.hdr", exehdr);

	unsigned short bytes_in_last_page = *(unsigned short*)((char*)&exehdr[2]);
	unsigned short pages_in_executable = *(unsigned short*)((char*)&exehdr[4]);
	unsigned short relocation_offset = *(unsigned short*)((char*)&exehdr[24]);
	unsigned short paragraphs_in_header = *(unsigned short*)((char*)&exehdr[8]);

	int executable_size = (pages_in_executable * 512);
	if (bytes_in_last_page > 0)
		executable_size += -512 + bytes_in_last_page;

	int header_size = paragraphs_in_header * 16;

	char* exeimage = new char[executable_size];
	memcpy(exeimage, exehdr, 30);

	int size = copy_binary("assets\\ega.cmn", &exeimage[header_size]);
	apply_dif("assets\\mcga.dif", &exeimage[header_size]);
	copy_binary("assets\\mcga.cod", &exeimage[header_size + size]);

	save_binary("game.exe", exeimage, executable_size);

	// the new executable is EXEpack-compressed. 
	// to crack the game, uncompress the exe with unp and place 0x1 at offset 
	// 0x2B3C. the byte should be zero before.

	return 0;
}
