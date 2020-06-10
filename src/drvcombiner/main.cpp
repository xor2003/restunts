#include <cstdio>
#include <cassert>
#include <string>
#include <vector>
#include <fstream>
#include <algorithm>

typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;

typedef char int8_t;
typedef short int16_t;
typedef int int32_t;

static uint8_t NOP_opcode = 0x90;

const std::string game_exe = "assets\\game_cracked.exe"; // result of execombiner + crack
const std::string ad15_drv = "assets\\AD15.DRV"; // adlib/soundblaster driver
const std::string exe_with_drv = "game_drv.exe"; // resulting file

/*
based on the unpacked (using clvns execombiner(w4kfus should also work)) stunts executable

+----------------------------+
| header                     | 
+----------------------------+
| relocation table           | 
+----------------------------+
| header paragraphs padding  | 
+----------------------------+ 
| image                      | 
+----------------------------+ 

loaded exe

+----------------------------+
| PSP                        | 
+----------------------------+ <-- load segment
| image                      | 
+----------------------------+ 
| uinitialized data (udata)  | 
+----------------------------+ 
| stack                      | 
+----------------------------+ 
| uinitialized data (udata)  | 
+----------------------------+ 

change:
-attach block of 0x00 in size of former uninitialized data to image
-attach drv code
-add new entry for driver-ptr adjust to relocation table
-change position of stack
-change header sizes
-remove former unititalized data intializer
-remove driver load code
-set driver-ptrs to correct locations

new exe

+----------------------------+
| header                     | 
+----------------------------+
| relocation table           | 
+----------------------------+ 
| image                      | 
|- - - - - - - - - - - - - - |
| byte [udata size] = {0}    | 
|- - - - - - - - - - - - - - |
| drv code                   | 
|- - - - - - - - - - - - - - |
| 13 bytes paragraph padding | 
+----------------------------+ 

loaded new exe

+----------------------------+
| PSP                        | 
+----------------------------+ <-- load segment
| image                      | 
|- - - - - - - - - - - - - - | 
| byte [udata size] = {0}    |
|- - - - - - - - - - - - - - |
| drv code                   | 
|- - - - - - - - - - - - - - |
| 13 bytes paragraph padding | 
+----------------------------+ 
| stack                      | 
+----------------------------+ 
| uinitialized data (udata)  |
+----------------------------+ 
*/

static const int BLOCK_SIZE = 512;
static const int PARAGRAPH_SIZE = 16;

static bool is_aligned_to_paragraph(const size_t& p_offset)
{
  return (p_offset % PARAGRAPH_SIZE) == 0;
}

static int get_header_exe_size(const uint16_t& p_blocks_in_file, const uint16_t& p_bytes_in_last_block)
{
  int size = p_blocks_in_file * BLOCK_SIZE;
  if( p_bytes_in_last_block > 0 )
  {
    size -= BLOCK_SIZE - p_bytes_in_last_block;
  }
  return size;
}

static void set_header_exe_size(const int& p_size, uint16_t& p_blocks_in_file, uint16_t& p_bytes_in_last_block)
{
  p_blocks_in_file = p_size / BLOCK_SIZE;
  int rest = p_size % BLOCK_SIZE;
  if( rest != 0 )
  {
    ++p_blocks_in_file;
    p_bytes_in_last_block = rest;
  }
}

static size_t ptr16_to_offset32(const uint16_t& p_segment, const uint16_t& p_offset)
{
  return p_segment * 16 + p_offset;
}

static void offset32_to_ptr16(const size_t p_offset32, uint16_t& p_segment, uint16_t& p_offset)
{
  p_segment = p_offset32 / PARAGRAPH_SIZE;
  p_offset = p_offset32 % PARAGRAPH_SIZE;
}

typedef std::vector<uint8_t> t_buffer;

static void read_buffer_file( std::string filepath, t_buffer& p_buffer )
{
  std::ifstream infile (filepath.c_str(), std::ifstream::binary);

  infile.seekg(0,std::ifstream::end);
  size_t size = static_cast<size_t>(infile.tellg());
  infile.seekg(0);

  p_buffer.resize(size);
  infile.read(reinterpret_cast<char*>(&p_buffer[0]), size);

  infile.close();
}

static void write_buffer_file( const std::string& p_filepath, const t_buffer& p_buffer )
{
  std::ofstream outfile (p_filepath.c_str(), std::ifstream::binary);
  outfile.write(reinterpret_cast<const char*>(&p_buffer[0]), p_buffer.size());
  outfile.close();
}

/*
Offset 	Size 	Description
00 	word 	"MZ" - Link file .EXE signature
02 	word 	length of image mod 512
04 	word 	size of file in 512 byte pages
06 	word 	number of relocation items following header
08 	word 	size of header in 16 byte paragraphs, used to locate the beginning of the load module
0A 	word 	min # of paragraphs needed to run program
0C 	word 	max # of paragraphs the program would like
0E 	word 	offset in load module of stack segment (in paragraphs)
10 	word 	initial SP value to be loaded
12 	word 	negative checksum of pgm used while by EXEC loads pgm
14 	word 	program entry point, (initial IP value)
16 	word 	offset in load module of the code segment (in paragraphs)
18 	word 	offset in .EXE file of first relocation item
1A 	word 	overlay number (0 for root program)
*/

#pragma pack( push )
#pragma pack( 1 )

struct exe_header_t
{
  exe_header_t():
signature(0),
  bytes_in_last_block(0),
  blocks_in_file(0),
  num_relocs(0),
  header_paragraphs(0),
  min_extra_paragraphs(0),
  max_extra_paragraphs(0),
  ss(0),
  sp(0),
  checksum(0),
  ip(0),
  cs(0),
  reloc_table_offset(0),
  overlay_number(0)
{
} 

uint16_t signature;
uint16_t bytes_in_last_block;
uint16_t blocks_in_file;
uint16_t num_relocs;
uint16_t header_paragraphs;
uint16_t min_extra_paragraphs;
uint16_t max_extra_paragraphs;
uint16_t ss;
uint16_t sp;
uint16_t checksum;
uint16_t ip;
uint16_t cs;
uint16_t reloc_table_offset;
uint16_t overlay_number;

int32_t get_exe_size() const
{
  return get_header_exe_size(blocks_in_file, bytes_in_last_block);
}

void set_exe_size(const int& p_size)
{
  set_header_exe_size(p_size, blocks_in_file, bytes_in_last_block);
}

size_t header_paragraphs_in_byte() const
{
  return header_paragraphs * PARAGRAPH_SIZE;
}

int min_extra_paragraphs_in_bytes() const
{
  return min_extra_paragraphs * PARAGRAPH_SIZE;
}

int max_extra_paragraphs_in_bytes() const
{
  return max_extra_paragraphs * PARAGRAPH_SIZE;
}
};

struct ptr16_t
{
  ptr16_t():
offset(0),
  segment(0)
{
}

ptr16_t(const uint16_t& p_segment, const uint16_t& p_offset):
offset(p_offset),
  segment(p_segment)
{
}

ptr16_t(const uint32_t& p_offset32):
offset(0),
  segment(0)
{
  offset32(p_offset32);
}

int offset32() const
{
  return ptr16_to_offset32(segment, offset);
}

void offset32(const uint32_t& p_offset32)
{
  return offset32_to_ptr16(p_offset32, segment, offset);
}

//some operators
ptr16_t operator+(const ptr16_t& p_other) const
{
  return ptr16_t(offset32() + p_other.offset32());
}

//order needed
uint16_t offset;
uint16_t segment;
};

typedef std::vector<ptr16_t> relocation_table_t;

struct find_entry_by_offset32_t
{
  find_entry_by_offset32_t(const int& p_offset32):_offset32(p_offset32)
  {
  }

  bool operator()(const ptr16_t& p_entry)
  {
    return p_entry.offset32() == _offset32;
  }

  int _offset32;
};

#pragma pack( pop )

static void print_exe_header(const exe_header_t& p_exe_header)
{
  printf("exe_header:\n");
  printf("  signature: 0x%04X\n", p_exe_header.signature);
  printf("  bytes_in_last_block: 0x%04X\n", p_exe_header.bytes_in_last_block);
  printf("  blocks_in_file: 0x%04X\n", p_exe_header.blocks_in_file);
  printf("  num_relocs: 0x%04X\n", p_exe_header.num_relocs);
  printf("  header_paragraphs: 0x%04X\n", p_exe_header.header_paragraphs);
  printf("  min_extra_paragraphs: 0x%04X\n", p_exe_header.min_extra_paragraphs);
  printf("  max_extra_paragraphs: 0x%04X\n", p_exe_header.max_extra_paragraphs);
  printf("  ss: 0x%04X\n", p_exe_header.ss);
  printf("  sp: 0x%04X\n", p_exe_header.sp);
  printf("  checksum: 0x%04X\n", p_exe_header.checksum);
  printf("  ip: 0x%04X\n", p_exe_header.ip);
  printf("  cs: 0x%04X\n", p_exe_header.cs);
  printf("  reloc_table_offset: 0x%04X\n", p_exe_header.reloc_table_offset);
  printf("  overlay_number: 0x%04X\n", p_exe_header.overlay_number);
  printf("\n");
}

struct ida_dosbox_ptr_converter_t
{
  ida_dosbox_ptr_converter_t(const ptr16_t& p_exe_header_first_instruction, const ptr16_t& p_dosbox_first_instruction):
m_exe_header_first_instruction(p_exe_header_first_instruction),
  m_dosbox_first_instruction(p_dosbox_first_instruction),
  m_ida_base(0),
  m_dosbox_base(0)
{
  const size_t ida_load_segment = 0x1000;
  const size_t ida_load_offset32 = ptr16_to_offset32(ida_load_segment, 0);
  //const size_t ida_first_instruction_offset32 = m_exe_header_first_instruction.offset32() + ida_load_offset32;

  m_ida_base = ida_load_offset32;
  m_dosbox_base = m_dosbox_first_instruction.offset32() - m_exe_header_first_instruction.offset32(); 
}

ptr16_t dosbox_ptr16(const int& p_ida_offset) const
{
  const size_t relative_offset32 = p_ida_offset - m_ida_base;
  const size_t dosbox_offset32 = relative_offset32 + m_dosbox_base;
  const ptr16_t ptr(dosbox_offset32);
  return ptr;
};

int ida_offset32(const ptr16_t& p_dosbox_ptr16) const
{
  const size_t dosbox_offset32 = p_dosbox_ptr16.offset32();
  const size_t relative_offset32 = dosbox_offset32 - m_dosbox_base;
  const size_t ida_offset32 = m_ida_base + relative_offset32;
  return ida_offset32;
}

ptr16_t m_exe_header_first_instruction;
ptr16_t m_dosbox_first_instruction;

int m_ida_base;
int m_dosbox_base;
};

static void ida_dosbox_info()
{
  const ptr16_t exe_header_first_instruction(0x1CC5,0x0012);

  // debug game.exe -> first instruction address
  const ptr16_t dosbox_first_instruction(0x1ED3,0x0012);

  ida_dosbox_ptr_converter_t convert(exe_header_first_instruction, dosbox_first_instruction);

  const ptr16_t start = convert.dosbox_ptr16(0x2CC62);
  const ptr16_t call_main = convert.dosbox_ptr16(0x2CCF9);
  const ptr16_t main = convert.dosbox_ptr16(0x10000);
  const ptr16_t set_video_mode = convert.dosbox_ptr16(0x39E56);
  const ptr16_t AudioDrvAtExit = convert.dosbox_ptr16(0x37A64);
  const ptr16_t DoKbChecking2 = convert.dosbox_ptr16(0x36B05);

  const ptr16_t load_audio_driver_proc = convert.dosbox_ptr16(0x378CA);
  const ptr16_t load_audio_driver_call = convert.dosbox_ptr16(0x3A0AC);
  const ptr16_t cmdline_parse = convert.dosbox_ptr16(0x39F63);
  const ptr16_t test_sbb = convert.dosbox_ptr16(0x3A00F);

  const ptr16_t drv_loaded = convert.dosbox_ptr16(0x37970);
  const ptr16_t drv_unload = convert.dosbox_ptr16(0x37AE7);
  const ptr16_t load_audio_res = convert.dosbox_ptr16(0x299E7);
  //where is the driver mem released?

  const ptr16_t byte = convert.dosbox_ptr16(0x42DAE);

  const ptr16_t load_skidms = convert.dosbox_ptr16(0x37D39);
  int offset_fail = convert.ida_offset32(ptr16_t(0x1ED3,0x0086));

  int brk = 1;
}

static void print_relocation_table(const ptr16_t* const p_relocation_table, const size_t& p_count)
{
  //image relative offsets
  printf("relocation table entries count: %u\n", p_count);
  size_t i = 0;
  for( const ptr16_t* entry = p_relocation_table; entry != p_relocation_table+p_count; ++entry)
  {
    //printf("[%u] ptr16: 0x%04X:0x%04X, offset32: 0x%08X\n", i++, entry->segment, entry->offset, ptr16_to_offset32(entry->segment, entry->offset));
    printf("ptr16: 0x%04X:0x%04X, offset32: 0x%08X\n", entry->segment, entry->offset, ptr16_to_offset32(entry->segment, entry->offset));
  }
  printf("\n");
}

static void print_relocations(const uint16_t p_load_segment, const ptr16_t* const p_relocation_table, const size_t& p_count, const uint8_t* const image_begin, const size_t& p_image_size)
{
  printf("relocation table entries count: %u\n", p_count);
  size_t i = 0;
  for( const ptr16_t* entry = p_relocation_table; entry != p_relocation_table+p_count; ++entry)
  {
    int offset32 = ptr16_to_offset32(entry->segment, entry->offset);
    uint16_t& relocate_value = *(uint16_t*)(image_begin + offset32);
    uint16_t before = relocate_value;
    uint16_t after = relocate_value + p_load_segment;

    printf("[%i] offset32: 0x%08, before: 0x%04X, after: 0x%04X\n", i++, offset32, before, after);
  }
  printf("\n");
}

static int bytes_to_paragraphs(const int& p_byte_size)
{
  int paragraphs = p_byte_size / PARAGRAPH_SIZE;
  if( p_byte_size % PARAGRAPH_SIZE )
  {
    ++paragraphs;
  }
  return paragraphs;
}

static int pad_to_paragraph_bytes(const int& p_byte_size)
{
  return bytes_to_paragraphs(p_byte_size) * PARAGRAPH_SIZE;
}

static void print_exe_layout(const exe_header_t& p_exe_header)
{
  const size_t header_begin = 0;
  const size_t header_end = sizeof(exe_header_t);
  const size_t header_size = header_end - header_begin;

  const size_t relocation_table_begin = p_exe_header.reloc_table_offset;
  const size_t relocation_table_end = relocation_table_begin + p_exe_header.num_relocs * sizeof(ptr16_t);
  const size_t relocation_table_size = relocation_table_end - relocation_table_begin;

  const size_t header_paragraphs_end = p_exe_header.header_paragraphs_in_byte();

  printf("exe file layout:\n");

  printf("(exe_begin)\n");
  printf("  (header_paragraphs_begin)\n");
  printf("    header: [0x%08X - [0x%08X size: 0x%X = %u bytes\n", header_begin, header_end, header_size, header_size);

  if( header_end != relocation_table_begin )
  {
    const size_t unused_space = relocation_table_begin - header_end;
    printf("    unused space: [0x%08X - [0x%08X size: 0x%X = %u bytes\n", header_end, relocation_table_begin, unused_space, unused_space);
  }

  if( relocation_table_begin != relocation_table_end )
  {
    printf("    relocation_table: [0x%08X - [0x%08X size: 0x%X = %u bytes\n", relocation_table_begin, relocation_table_end, relocation_table_size, relocation_table_size);
  }

  if( relocation_table_end != header_paragraphs_end)
  {
    const size_t unused_space = header_paragraphs_end - relocation_table_end;
    printf("    unused space (header_paragraphs padding): [0x%08X - [0x%08X size: 0x%X = %u bytes\n", relocation_table_end, header_paragraphs_end, unused_space, unused_space);
  }
  printf("  (header_paragraphs_end)\n");

  const int exe_end = p_exe_header.get_exe_size();
  const int image_size = exe_end - header_paragraphs_end;
  if( image_size > 0 )
  {
    printf("  image: [0x%08X - [0x%08X size: 0x%X = %u bytes\n", header_paragraphs_end, exe_end, image_size, image_size);
  }
  printf("(exe_end)\n");

  printf("\n");

  printf("loaded exe layout:\n");

  //IDA default load_segment for analyse is 0x1000
  const size_t load_segment_ida = 0x1000;
  const size_t load_offset32_ida = ptr16_to_offset32(load_segment_ida, 0);

  const size_t loaded_image_begin = 0;
  const size_t loaded_image_end = loaded_image_begin + image_size;

  const size_t stack_begin = ptr16_to_offset32(p_exe_header.ss, 0);
  const size_t stack_end = ptr16_to_offset32(p_exe_header.ss, p_exe_header.sp);
  const size_t stack_size = p_exe_header.sp;

  const size_t udata_before_stack_begin = loaded_image_end;
  const size_t udata_before_stack_end = stack_begin;
  const size_t udata_before_stack_size = udata_before_stack_end - udata_before_stack_begin;

  const size_t udata_after_stack_begin = stack_end;
  const size_t udata_after_stack_end = loaded_image_end + p_exe_header.min_extra_paragraphs_in_bytes();
  const size_t udata_after_stack_size = udata_after_stack_end - udata_after_stack_begin;

  const size_t min_extra_paragraphs_in_bytes = p_exe_header.min_extra_paragraphs_in_bytes();
  const size_t max_extra_paragraphs_in_bytes = p_exe_header.max_extra_paragraphs_in_bytes();
  const size_t min_max_extra_paragraphs_diff_in_bytes = max_extra_paragraphs_in_bytes - min_extra_paragraphs_in_bytes;

  const size_t min_extra_paragraphs_in_bytes_end = loaded_image_end + min_extra_paragraphs_in_bytes;
  const size_t max_extra_paragraphs_in_bytes_end = loaded_image_end + max_extra_paragraphs_in_bytes;

  printf("  PSP: size: 0x0100 = 256 bytes\n");

  printf("  <--- load_segment 0x0000, in IDA: ptr16: 0x%04X:0x0 = offset32: 0x%08X)\n", load_segment_ida, load_offset32_ida);
  if( image_size > 0 )
  {
    printf("  image: [0x%08X - [0x%08X, in IDA: [0x%08X - [0x%08X size: 0x%X = %u bytes\n", loaded_image_begin, loaded_image_end, loaded_image_begin+load_offset32_ida, loaded_image_end+load_offset32_ida, image_size, image_size);
    const size_t cs_ip_offset32 = ptr16_to_offset32(p_exe_header.cs, p_exe_header.ip);

    const size_t cs_ip_IDA_offset32 = cs_ip_offset32 + load_offset32_ida;
    const uint16_t cs_IDA = p_exe_header.cs + load_segment_ida;
    printf("    first instruction: ptr16: 0x%04X:0x%04X, offset32: 0x%08X, in IDA: ptr16: 0x%04X:0x%04X, offset32: 0x%08X\n", p_exe_header.cs, p_exe_header.ip, cs_ip_offset32, cs_IDA, p_exe_header.ip, cs_ip_IDA_offset32);
  }

  printf("  (min/max_extra_paragraphs_begin)\n");
  //udata before stack?
  if( udata_before_stack_size > 0 )
  {
    printf("    udata: [0x%08X - [0x%08X size: 0x%X = %u bytes\n", udata_before_stack_begin, udata_before_stack_end, udata_before_stack_size, udata_before_stack_size);
  }

  //stack
  if( stack_size > 0 )
  {
    printf("    stack: [0x%08X - [0x%08X size: 0x%X = %u bytes\n", stack_begin, stack_end, stack_size, stack_size);
  }

  //udata after stack?
  if( udata_after_stack_size > 0 )
  {
    printf("    udata: [0x%08X - [0x%08X size: 0x%X = %u bytes\n", udata_after_stack_begin, udata_after_stack_end, udata_after_stack_size, udata_after_stack_size);
  }

  printf("  (min_extra_paragraphs_end)\n");
  if( min_max_extra_paragraphs_diff_in_bytes > 0 )
  {
    size_t udata_size = min_max_extra_paragraphs_diff_in_bytes;
    printf("    udata: [0x%08X - [0x%08X size: 0x%X = %u bytes\n", min_extra_paragraphs_in_bytes_end, max_extra_paragraphs_in_bytes_end, udata_size, udata_size);
  }
  printf("  (max_extra_paragraphs_end)\n");
}  

//TODO

static int file_offset_to_image_offset(const int& p_file_offset)
{
  assert(true);
  return 0;
}

static int image_offset_to_file_offset(const int& p_image_offset)
{
  assert(true);
  return 0;
}

static std::vector<int> find_relocations_in_image_range(relocation_table_t& p_table, const int& p_in_image_offset_begin, const int& p_in_image_offset_end)
{
  std::vector<int> relocation_offsets;
  for(relocation_table_t::iterator it = p_table.begin(); it != p_table.end(); ++it)
  {
    int offset32 = it->offset32();
    if( offset32 >= p_in_image_offset_begin && offset32 < p_in_image_offset_end )
    {
      relocation_offsets.push_back(offset32);  
    }
  }
  return relocation_offsets;
}

static bool check_table_entries_uniqueness(relocation_table_t& p_table)
{
  std::vector<int> tmp;
  for(relocation_table_t::const_iterator it = p_table.begin(); it != p_table.end(); ++it)
  {
    int offset32 = it->offset32();
    tmp.push_back(offset32);  
  }
  std::sort(tmp.begin(), tmp.end());
  bool unique = std::unique(tmp.begin(), tmp.end()) == tmp.end();
  return unique;
}

static void remove_relocations_by_offset32(relocation_table_t& p_table, const std::vector<int>& p_offsets32)
{
  for(std::vector<int>::const_iterator it = p_offsets32.begin(); it != p_offsets32.end(); ++it)
  {
    relocation_table_t::iterator e_it = std::find_if(p_table.begin(), p_table.end(), find_entry_by_offset32_t(*it));
    assert(e_it != p_table.end());
    p_table.erase(e_it);
  }
}

static std::string hex_string(const void* const p_buffer, const size_t& p_size)
{
  std::string tmp;
  if( p_size != 0)
  {
    const size_t string_size = (p_size * 3)-1;  
    tmp.resize(string_size,' ');

    const uint8_t* const in_buffer = (uint8_t*)p_buffer;
    uint8_t* const out_buffer = (uint8_t*)&tmp[0];

    for(size_t i = 0; i < p_size; ++i)
    {
      const char hex_digits[]="0123456789ABCDEF";
      const uint8_t value = in_buffer[i];
      char* const chr = (char*)(out_buffer + i*3);
      chr[0] = hex_digits[value >> 4];
      chr[1] = hex_digits[value & 0xF];
    }
  }
  return tmp;
}

static void create_driver_integrated_exe()
{
  t_buffer old_exe_buffer;
  t_buffer driver_buffer;

  std::string filename = game_exe; // result of execombiner + crack
  std::string filename_driver = ad15_drv; // adlib/soundblaster driver

  read_buffer_file( filename, old_exe_buffer);
  read_buffer_file( filename_driver, driver_buffer);

  const exe_header_t& old_exe_header = *reinterpret_cast<exe_header_t*>(&old_exe_buffer[0]);

  assert(old_exe_header.get_exe_size() == old_exe_buffer.size());

  //--------- 
  // copy old relocation table
  const size_t old_relocation_table_offset = sizeof(exe_header_t);
  const size_t old_relocation_table_size = old_exe_header.num_relocs * sizeof(ptr16_t);
  ptr16_t* old_relocation_table = reinterpret_cast<ptr16_t*>(&old_exe_buffer[0]+old_relocation_table_offset);

  relocation_table_t vector_new_relocation_table(old_exe_header.num_relocs);
  ::memcpy(&vector_new_relocation_table[0], old_relocation_table, old_relocation_table_size);  
  assert(check_table_entries_uniqueness(vector_new_relocation_table));
  //----------

  const int image_size = old_exe_header.get_exe_size() - old_exe_header.header_paragraphs_in_byte();

  const uint16_t stack_size = old_exe_header.sp;

  const int udata_size = old_exe_header.min_extra_paragraphs_in_bytes() - stack_size;

  printf("\n-----------------------\nold exe\n-----------------------\n");
  print_exe_header(old_exe_header);
  printf("----------\n");
  print_exe_layout(old_exe_header);

  uint16_t new_num_relocs = old_exe_header.num_relocs + 1;
  int new_relocation_table_size = new_num_relocs * sizeof(ptr16_t);

  int new_header_size = sizeof(exe_header_t) + new_relocation_table_size;
  uint16_t new_header_paragraphs = new_header_size / PARAGRAPH_SIZE;
  if( new_header_size % PARAGRAPH_SIZE )
  {
    ++new_header_paragraphs;
  }
  int new_header_paragraphs_in_bytes = new_header_paragraphs * PARAGRAPH_SIZE;

  uint16_t new_min_extra_paragraphs = stack_size / PARAGRAPH_SIZE;
  if(stack_size % PARAGRAPH_SIZE)
  {
    ++new_min_extra_paragraphs;
  }
  uint16_t new_max_extra_paragraphs = new_min_extra_paragraphs + (old_exe_header.max_extra_paragraphs - old_exe_header.min_extra_paragraphs);

  const size_t drv_code_size = driver_buffer.size();

  const size_t new_image_size = image_size + udata_size + drv_code_size;

  //padding to paragraphs so stack starts right after new_image

  int new_image_paragraphs = new_image_size / PARAGRAPH_SIZE;
  if( new_image_size % PARAGRAPH_SIZE )
  {
    ++new_image_paragraphs;
  }
  int new_image_padded_size = new_image_paragraphs * PARAGRAPH_SIZE;

  int new_exe_file_size = new_header_paragraphs_in_bytes + new_image_padded_size;

  int image_padding_size_diff = new_image_padded_size - new_image_size;

  int new_ss = new_image_padded_size / PARAGRAPH_SIZE;

  //create new image

  t_buffer new_exe_buffer(new_exe_file_size, NOP_opcode);

  exe_header_t& new_exe_header = *reinterpret_cast<exe_header_t*>(&new_exe_buffer[0]);
  new_exe_header = old_exe_header;
  new_exe_header.header_paragraphs = new_header_paragraphs;
  new_exe_header.num_relocs = new_num_relocs;
  set_header_exe_size(new_exe_file_size, new_exe_header.blocks_in_file, new_exe_header.bytes_in_last_block);
  new_exe_header.ss = new_ss;

  new_exe_header.min_extra_paragraphs = old_exe_header.sp / PARAGRAPH_SIZE;
  new_exe_header.max_extra_paragraphs = new_exe_header.min_extra_paragraphs + old_exe_header.max_extra_paragraphs - old_exe_header.min_extra_paragraphs;

  //set relocation table
  const size_t new_relocation_table_offset = sizeof(exe_header_t);
  ptr16_t* new_relocation_table = reinterpret_cast<ptr16_t*>(&new_exe_buffer[0]+new_relocation_table_offset);
  ::memset(new_relocation_table, 0, old_relocation_table_size);

  //---

  //---

  //set image
  const size_t old_image_offset = old_exe_header.header_paragraphs * PARAGRAPH_SIZE;
  const size_t old_image_size = image_size;
  const size_t new_image_offset = new_exe_header.header_paragraphs * PARAGRAPH_SIZE;
  ::memcpy(&new_exe_buffer[0]+new_image_offset, &old_exe_buffer[0]+old_image_offset, old_image_size);

  //full former udata
  const size_t new_udata_offset = new_image_offset + old_image_size;
  ::memset(&new_exe_buffer[0]+new_udata_offset, 0x00, udata_size);

  //set drv
  const size_t drv_offset = new_udata_offset + udata_size;
  ::memcpy(&new_exe_buffer[0]+drv_offset, &driver_buffer[0], driver_buffer.size());

  //image ready...

  //------------------ 
  //set new relocation table entry
  ptr16_t& new_relocation_entry = new_relocation_table[new_num_relocs-1];

  //at ida-fileoffset (first offset in status line) 0x32E9A + 2 needs to hold the relative address of the segment to image begin
  //dseg:4E9A g_pDrvBinary    dd 0
  const size_t g_pDrvBinary_ida_file_offset = 0x32E9A;
  const size_t g_pDrvBinary_in_image_offset = g_pDrvBinary_ida_file_offset - new_exe_header.header_paragraphs_in_byte();

  const size_t g_pDrvBinary_segment_in_image_offset = g_pDrvBinary_in_image_offset + sizeof(uint16_t);
  offset32_to_ptr16(g_pDrvBinary_segment_in_image_offset, new_relocation_entry.segment, new_relocation_entry.offset);

  //pointer to variable holding loaded driver pointer
  //set relative segment
  ptr16_t& loaded_driver_ptr = *reinterpret_cast<ptr16_t*>(&new_exe_buffer[0] + g_pDrvBinary_ida_file_offset);

  offset32_to_ptr16(image_size + udata_size, loaded_driver_ptr.segment, loaded_driver_ptr.offset);
  assert(loaded_driver_ptr.offset == 0);

  //==========================================================
  //patched relocation table

  //print_relocation_table(&vector_new_relocation_table[0], vector_new_relocation_table.size());

  vector_new_relocation_table.push_back(new_relocation_entry);

  //nop out driver load/unload code

  {
    int ida_fileoffset_range_begin = 0x2A162;
    int ida_fileoffset_range_end = 0x2A17D;
    int range_size = ida_fileoffset_range_end - ida_fileoffset_range_begin;

    int image_offset_range_begin = ida_fileoffset_range_begin - old_exe_header.header_paragraphs_in_byte();
    int image_offset_range_end = image_offset_range_begin + range_size;

    std::vector<int> found = find_relocations_in_image_range(vector_new_relocation_table, image_offset_range_begin, image_offset_range_end);
    remove_relocations_by_offset32(vector_new_relocation_table, found);

    ::memset(&new_exe_buffer[0] + ida_fileoffset_range_begin, NOP_opcode, ida_fileoffset_range_end-ida_fileoffset_range_begin);

    int brk = 1;
  }

  {
    int ida_fileoffset_range_begin = 0x2A18E;
    int ida_fileoffset_range_end = 0x2A218;
    int range_size = ida_fileoffset_range_end - ida_fileoffset_range_begin;

    int image_offset_range_begin = ida_fileoffset_range_begin - old_exe_header.header_paragraphs_in_byte();
    int image_offset_range_end = image_offset_range_begin + range_size;

    std::vector<int> found = find_relocations_in_image_range(vector_new_relocation_table, image_offset_range_begin, image_offset_range_end);
    remove_relocations_by_offset32(vector_new_relocation_table, found);

    ::memset(&new_exe_buffer[0] + ida_fileoffset_range_begin, NOP_opcode, ida_fileoffset_range_end-ida_fileoffset_range_begin);

    int brk = 1;
  }

  {
    int ida_fileoffset_range_begin = 0x2A2E2;
    int ida_fileoffset_range_end = 0x2A2F4;
    int range_size = ida_fileoffset_range_end - ida_fileoffset_range_begin;

    int image_offset_range_begin = ida_fileoffset_range_begin - old_exe_header.header_paragraphs_in_byte();
    int image_offset_range_end = image_offset_range_begin + range_size;

    std::vector<int> found = find_relocations_in_image_range(vector_new_relocation_table, image_offset_range_begin, image_offset_range_end);
    remove_relocations_by_offset32(vector_new_relocation_table, found);

    ::memset(&new_exe_buffer[0] + ida_fileoffset_range_begin, NOP_opcode, ida_fileoffset_range_end-ida_fileoffset_range_begin);

    int brk = 1;
  }

  {
    int ida_fileoffset_range_begin = 0x2A377;
    int ida_fileoffset_range_end = 0x2A387;
    int range_size = ida_fileoffset_range_end - ida_fileoffset_range_begin;

    int image_offset_range_begin = ida_fileoffset_range_begin - old_exe_header.header_paragraphs_in_byte();
    int image_offset_range_end = image_offset_range_begin + range_size;

    std::vector<int> found = find_relocations_in_image_range(vector_new_relocation_table, image_offset_range_begin, image_offset_range_end);
    remove_relocations_by_offset32(vector_new_relocation_table, found);

    ::memset(&new_exe_buffer[0] + ida_fileoffset_range_begin, NOP_opcode, ida_fileoffset_range_end-ida_fileoffset_range_begin);

    int brk = 1;
  }

  //nop init with 0 of former udata - disable or our setted startvalues getting nulled
  {
    int ida_fileoffset_range_begin = 0x1F55C;
    int ida_fileoffset_range_end = 0x1F568;
    int range_size = ida_fileoffset_range_end - ida_fileoffset_range_begin;

    int image_offset_range_begin = ida_fileoffset_range_begin - old_exe_header.header_paragraphs_in_byte();
    int image_offset_range_end = image_offset_range_begin + range_size;

    std::vector<int> found = find_relocations_in_image_range(vector_new_relocation_table, image_offset_range_begin, image_offset_range_end);
    remove_relocations_by_offset32(vector_new_relocation_table, found);

    ::memset(&new_exe_buffer[0] + ida_fileoffset_range_begin, NOP_opcode, ida_fileoffset_range_end-ida_fileoffset_range_begin);

    int brk = 1;
  }

  //set default driver name to 
  char driver_to_load[] = "ad15";
  //dseg:53A2 g_pcAudioDriver db 'pc15',0
  //file: 0x333A2 ida-offset: 0x40B12

  char old[5]={0};
  ::memcpy(old, &new_exe_buffer[0] + 0x333A2, 4);
  assert(std::string(old) == "pc15");

  ::memcpy(&new_exe_buffer[0] + 0x333A2, driver_to_load, sizeof(driver_to_load));
  ::memcpy(old, &new_exe_buffer[0] + 0x333A2, 4);
  assert(std::string(old) == "ad15");

  {
    //set loaded driver name to "ad\0"
    char loaded_driver_name[] = "ad";
    int x = sizeof(loaded_driver_name);
    //dseg:763E => file: UNKNOWN, ida-offset: 0x42DAE g_str_loaded_AudioDrvName db 3 dup(?)

    const size_t ida_offset = 0x42DAE;
    const size_t distance_from_base = ida_offset - 0x10000;
    uint8_t* ptr = &new_exe_buffer[0] + new_exe_header.header_paragraphs_in_byte() + distance_from_base;
    ::memcpy(ptr, loaded_driver_name, sizeof(loaded_driver_name));
  }

  {
    //file-offset: UNNOWN, ida-offset: 0x45950
    //dseg:A1E0 g_cAudioByte2   db ?  == 0x7F
    const size_t ida_offset = 0x45950;
    const size_t distance_from_base = ida_offset - 0x10000;
    uint8_t* ptr = &new_exe_buffer[0] + new_exe_header.header_paragraphs_in_byte() + distance_from_base;
    *ptr = 0x7F;
  }

  {
    //file-offset: UNKNONWN, ida-offset: 0x45948
    //dseg:A1D8 g_cDrvFlag6Flag db ?   == 0x7F
    const size_t ida_offset = 0x45948;
    const size_t distance_from_base = ida_offset - 0x10000;
    uint8_t* ptr = &new_exe_buffer[0] + new_exe_header.header_paragraphs_in_byte() + distance_from_base;
    *ptr = 0x7F;
  }

  //print_relocation_table(&vector_new_relocation_table[0], vector_new_relocation_table.size());

  ::memcpy(new_relocation_table, &vector_new_relocation_table[0], vector_new_relocation_table.size()*sizeof(ptr16_t));
  new_exe_header.num_relocs = vector_new_relocation_table.size();

  //print_relocation_table(new_relocation_table, new_exe_header.num_relocs);

  //==========================================================

  //relocations ready...

  printf("\n-----------------------\nnew exe\n-----------------------\n");
  print_exe_header(new_exe_header);
  printf("-----------\n");
  print_exe_layout(new_exe_header);

  write_buffer_file(exe_with_drv, new_exe_buffer);
}

//void dos_exe_patch_lib_test();

int main()
{
  ida_dosbox_info();
  create_driver_integrated_exe();
  return 0;

  //test-code for exe-patch-lib
  //return 0;
}

