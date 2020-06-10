//#include <idc.idc>

//static main()
//{
        //auto code0,jumptable,a5offs;
        //auto addr;
//
        //code0=LocByName("CODEResource0");
        //jumptable=code0+20;
        //a5offs=Dword(code0+16);
//
        //addr=0;
        //for(;;)
        //{
                //auto op;
                //auto jumpentry,jumpresid,resoffs,funcoffs;
//
                //addr=FindCode(addr,SEARCH_DOWN);
                //if(addr==BADADDR) break;
//
                //if(GetMnem(addr)!="jsr") continue;
                //if(GetOpType(addr,0)!=4) continue;
                //op=GetOpnd(addr,0);
                //if(substr(op,strlen(op)-4,-1)!="(a5)") continue;
//
                //OpOffEx(addr,0,REF_OFF32,-1,jumptable,a5offs+2);
//
                //jumpentry=jumptable-a5offs-2+GetOperandValue(addr,0);
                //jumpresid=ltoa(Word(jumpentry+4),10);
                //resoffs=LocByName("CODEResource"+jumpresid);
                //funcoffs=resoffs+8+Word(jumpentry+0);
//
                //AddCodeXref(addr,funcoffs,fl_CF|XREF_USER);
        //}
//}

#include <idc.idc>

static showoperands(f,ea)
{
 auto i;
 for (i=0 ; GetOpType(ea, i) ; i++) {
  //Message("operand %d: %s %08lx %s\n", i, OpTypeString(GetOpType(ea, i)), GetOperandValue(ea, i), GetOpnd(ea, i));
  fprintf(f,"operand %d: %s %08lx %s\n", i, OpTypeString(GetOpType(ea, i)), GetOperandValue(ea, i), GetOpnd(ea, i));
 }
}

//from idc.idc
static OpTypeString(t)
{
 if (t==1) return "register";         // General Register (al,ax,es,ds...)    reg
 if (t==2) return "memref";           // Direct Memory Reference  (DATA)      addr
 if (t==3) return "base+index";    // Memory Ref [Base Reg + Index Reg]    phrase
 if (t==4) return "base+index+disp";// Memory Reg [Base Reg + Index Reg + Displacement] phrase+addr
 if (t==5) return "immediate";        // Immediate Value                      value
 if (t==6) return "immfar";           // Immediate Far Address  (CODE)        addr
 if (t==7) return "immnear";         // Immediate Near Address (CODE)        addr

 //missing is reg8,reg16,imm8,imm16,etc.
 //i think that need to be extracted from the opcode-byte (or does ida got a function for that)
}

static main()
{
	auto addr;
	auto disass;
	auto mnem;
	auto f;
	auto f_mnem;
	auto op_type;
	auto op_str;
	auto op_nr;
	auto i;
	auto first_byte;
	auto cmd;
	auto prefix;

	f = fopen("c:\\temp\\stunts.dis.txt", "w+");
	f_mnem = fopen("c:\\temp\\stunts.dis.mnem.txt", "w+");

	addr = 0;
	for(;;)
	{
		addr = FindCode(addr,SEARCH_DOWN);
		if(addr == BADADDR) break;

		//cmd = DecodeInstruction(addr);
		//      if ( !cmd )
		//        Message("Failed to decode!\n");
		//      else
		//        Message("cmd.itype=%d\n", cmd.itype);

		mnem = GetMnem(addr);
		disass = GetDisasm(addr);

		first_byte = Byte(addr);

		//imul with 0x26 at start
		//first_byte == 0x26 -> es segment override (what happens here?)

		/*
		- Lock and Repeat:
			- 0xF0 - LOCK
			- 0xF2 - REPNE/REPNZ
			- 0xF3 - REP/REPE/REPZ
		- Segment Override:
			- 0x2E - CS
			- 0x36 - SS
			- 0x3E - DS
			- 0x26 - ES
			- 0x64 - FS
			- 0x65 - GS
		- Operand-Size Override: 0x66, switching to non-default size.
		- Address-Size Override: 0x67, switching to non-default size.
*/

    prefix = "";
		if( first_byte == 0xF0 )
		{
			prefix = "LOCK";
		  first_byte = Byte(addr+1);
		}
		else
		if( first_byte == 0xF2 )
		{
			prefix = "REPNE/REPNZ";
		  first_byte = Byte(addr+1);
		}
		else
		if( first_byte == 0xF3 )
		{
			prefix = "REP/REPE/REPZ";
		  first_byte = Byte(addr+1);
		}
		else
		if( first_byte == 0x2E )
		{
			prefix = "cs override";
		  first_byte = Byte(addr+1);
		}
		else
		if( first_byte == 0x36 )
		{
			//example: add ss:54AAh,dx ... [0x36] [ADD-Opcode] ... results in: *wptr(ss,0x54aa) += dx;
			prefix = "ss override";
		  first_byte = Byte(addr+1);
		}
		else
		if( first_byte == 0x3E )
		{
			prefix = "ds override";
		  first_byte = Byte(addr+1);
		}
		else
		if( first_byte == 0x26 )
		{
			prefix = "es override";
		  first_byte = Byte(addr+1);
		}

		//beware of prefixes like repne etc. 0x95,0xF2...

		fprintf(f,"prefix: %s\n", prefix);
		fprintf(f,"code: 0x%02x b%08b\n",first_byte, first_byte);
		fprintf(f,"dis: %s\n",disass);
		fprintf(f,"mnem: %s\n",mnem);

		fprintf(f_mnem,"%s\t0x%02x\t%s\n",mnem,first_byte,prefix);
		//fprintf(f_mnem,"%08xl %s 0x%02x\n",addr,mnem,first_byte);

		showoperands( f, addr );

		fprintf(f,"\n");
	}
}

