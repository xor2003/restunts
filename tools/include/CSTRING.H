#pragma once
#include <iostream.h>
#include <string.h>
class CString
{
	char *data;//строка с данными
	int size;//длина строки с данными, без '/'
	int buffer;//размер выделенной памяти под строку
	friend ostream& operator<<(ostream& out, const CString& str );
public:
	CString(void);//конструкторпо умолчанию
	CString(const CString& other);//конструктор копирования
	CString(char* str);//конструктор по строке
	void operator=(const CString& other);//оператор присваивания
	CString operator+(const CString& other);//конкатенция двух строк
	bool operator!=(const CString& other);///|
	bool operator==(const CString& other){
		if(strcmp(data, other.data)==0)
			return true;
		else
			return false;
	}
	void operator+(char sym){
		char *temp=new char[size+2];
		strcpy(temp,data);
		temp[size]=sym;
		size++;
		temp[size]='\0';
		buffer=size+1;
		delete [] data;
		data=temp;
	}
	char* GetStr(){
		if(data)
			return data;
	}
	bool operator<(const CString& other);//  | сравнение
	bool operator>(const CString& other);//  | двух строк
	bool operator>=(const CString& other);// |
	bool operator<=(const CString& other);// |
	void LeftCut(const CString& other);//вырезание слева части, равной по длине строки справа other
	void RightCut(const CString& other);//вырезание справа части, равной по длине строки справа other
	void DelLeftSym(void);//отбрасывание самого левого символа (если он есть)
	void DelRightSym(void);//отбрасывание самого правого символа (если он есть)
	~CString(void);
};
CString::CString(void){
	data=0;
	size=0;
	buffer=0;
}
CString::~CString(void){
	delete [] data;
	size=0;
	buffer=0;

}
CString::CString(const CString& other){
	buffer=other.buffer;
	size=other.size;
	if(buffer)
	{
	data=new char[buffer];
	strcpy(data,other.data);
	}
}
CString::CString(char* str){
	size=(int)strlen(str);
	buffer=size+1;
	data=new char[buffer];
	strcpy(data,str);
}
void CString::operator=(const CString& other){
	if(this==&other)
		return;
	delete [] data;
	size=other.size;
	buffer=other.buffer;
	data=new char[buffer];
	strcpy(data, other.data);
}
CString CString::operator+(const CString& other){
	char *temp=new char[size+other.size+1];
	if(data)
		strcpy(temp,data);
	if(other.data)
	strcat(temp,other.data);
	CString res(temp);
	delete [] temp;
	return res;
}
bool CString::operator!=(const CString& other){
	if(size!=other.size || strcmp(data,other.data)!=0)
		return true;
	else
		return false;
}
bool CString::operator<(const CString& other){
		if(strcmp(data,other.data)<0)
			return true;
		else
			return false;
}
bool CString::operator>(const CString& other){
	if(strcmp(data,other.data)>0)
		return true;
	else
		return false;
}
bool CString::operator<=(const CString& other){
	int n=strcmp(data,other.data);
	if(n==0 || n<0 && size==other.size)
		return true;
	else
		return false;
}
bool CString::operator>=(const CString& other){
	int n=strcmp(data,other.data);
	if(n==0 || n>0 && size==other.size)
		return true;
	else
		return false;
}
void CString::LeftCut(const CString& other){
	if(!other.size || other.size>size)
		throw "Error LeftCut: can't cut";
	if(other.size==size){
		delete [] data;
		data=new char[1];
		data[0]='\0';
		size=0;
		buffer=1;
	}
	else
	{
		//char *temp=new char[size-other.size+2];
		for(int i=0;i<=size-other.size;i++){
			data[i]=data[i+other.size];
		}
		CString a(data);
		*this=a;
	}

}
void CString::RightCut(const CString& other){
	if(!other.size || other.size>size)
		throw "Error RightCut: can't cut";
	if(other.size==size){
		delete [] data;
		data=new char[1];
		data[0]='\0';
		size=0;
		buffer=1;
	}
	else
	{
		data[size-other.size]='\0';
		CString a(data);
		*this=a;
	}

}
void CString::DelLeftSym(void){
	if(!size)
		throw "Error <-: size=0";
	CString x(data+1);
	*this=x;
}
void CString::DelRightSym(void){
	if(!size)
		throw "Error ->: size=0";
	data[size-1]='\0';
	CString x(data);
	*this=x;
}
ostream& operator<<(ostream& out, const CString& str ){
	out<<str.data;
	return out;
}
istream& operator>>(istream& in, CString& input){
	char temp[1000];
	in>>temp;
	input=temp;
	return in;
}