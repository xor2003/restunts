#include<iostream.h>
#include<string.h>
#include<stdlib.h>
#include<conio.h>
#ifndef SETS_.H
#define SETS_.H
template <class typeX> class SET
{
 protected:
  int power;
  typeX *array;
 public:
  static int min_rand;
  static int max_rand;
  SET() {power=0; array=NULL;}
  SET(typeX *arr, int p);
  SET(typeX &el);
  SET(char *str);
  SET(SET<typeX> &set_n);
  SET operator = (SET &set_n);
  SET operator = (typeX &el);
  SET operator = (char *str);
  int getpow() {return power;}
  int operator ~() {return power;}
  void Assign(typeX *mas, int n=0);
  void Del_dup();
  void init_Zero(int num=1);
  void Clear();
  int Find(typeX &el);
  int operator > (SET &set_n);
  int operator < (SET &set_n);
  int operator == (SET &set_n);
  int operator != (SET &set_n);
  int operator >= (SET &set_n);
  int operator <= (SET &set_n);
  int operator /= (SET &set_n);
  SET operator ++(int);
  SET operator --(int);
  SET operator >>= (typeX &el);
  SET operator <<= (typeX &el);
  SET operator + (SET &set_n);
  SET operator * (SET &set_n);
  SET operator - (SET &set_n);
  SET operator % (SET &set_n);
  SET operator ^ (SET &set_n);
  SET operator & (SET &set_n);
  typeX& operator [] (int &i);
  friend istream& operator >> (istream &in, SET &set_n);
  friend ostream& operator << (ostream &out, SET &set_n);
 ~SET() {if (power) delete[] array;}
};

//--------------------------- Peregruzka konstruktorov -----------
  template <class typeX> SET<typeX>::SET (typeX *arr, int p)
  {
   power=p;
   if (!arr)  array=NULL;
   else
   {
    array=new typeX [power];
    for (int i=0; i<power; i++)
     array[i]=arr[i];
    this->Del_dup();
   }
  }

  template <class typeX> SET<typeX>::SET(typeX &el)
  {
   power=1;
   array=new typeX (el);
  }

  SET<char>::SET(char *str)
  {
   power=strlen(str);
   array=new char [power];
   strcpy(array,str);
   this->Del_dup();
  }

  //-------------- KONSTRUKTOR KOPIROVANIYA ------------------
  template <class typeX> SET<typeX>::SET(SET<typeX> &set_n)
  {
   power=set_n.power;
   if (power)
   {
    array=new typeX [power];
    for (int i=0; i<power; i++)
     array[i]=set_n[i];
   }
   else array=NULL;
  }

//--------------------------------------- PRISVAIVANIE -------------
template <class typeX>
 SET<typeX> SET<typeX>::operator = (SET<typeX> &set_n)
	   {
	    if (*this==set_n)
	     return *this;
	    power=set_n.power;
	    if (power)
	    {
	     delete[] array;
	     array=new typeX[set_n.power];
	     for (int i=0; i<power; i++)
	      array[i]=set_n[i];
	    }
	    else array=NULL;
	    return *this;
	   }

template <class typeX>
 SET<typeX> SET<typeX>::operator = (typeX &el)
	   {
	    if (power==1 && array[0]==el)
	     return *this;
	    if (power)
	     delete[] array;
	    array=new typeX (el);
            power=1;
	    return *this;
	   }

 SET<char> SET<char>::operator = (char *str)
	   {
	    if (power)
	     delete[] array;
	    power=strlen(str);
	    array=new char [power];
	    for (int i=0; i<power; i++)
	     array[i]=str[i];
	    this->Del_dup();
	    return *this;
	   }

template <class typeX>
 void SET<typeX>::Assign(typeX *mas, int n)
	   {
	    if(power)
	     delete[] array;
	    power=n;
	    if (power)
	    {
	     array=new typeX[power];
	     for (int i=0; i<power; i++)
	      array[i]=mas[i];
	     this->Del_dup();
	    }
	   }

 //-------------------------- Udalenie dublikatov ------------------
 template <class typeX>
  void SET<typeX>::Del_dup()
	   {
	    if (power)
	    {
	     SET temp;
	     typeX elem;
	     int i,count=0,flag=0;
	     temp.power=power;
	     temp.init_Zero(temp.power);
	     for (i=0,flag=0; i<temp.power; i++)
	     {
	      elem=array[i];
	      if (elem==0 && flag==0)
	      { count++;
		flag=1;}
	      else if (temp.Find(elem)==-1)
	      {
	       temp[count]=elem;
	       count++;
	      }
	     }
	     delete[] array;
	     power=count;
	     array=new typeX [power];
	     for (i=0; i<power; i++)
	      array[i]=temp[i];
	    }
	   }
 //----------------- init. set of zeros -------------------------------------
template <class typeX> void SET<typeX>::init_Zero(int num)
  {
   if (power) delete[] array;
   array=new typeX [num];
   for (int i=0; i<num; i++)
    array[i]=0;
   power=num;
  }
 //------------------------ Oshistka mn-va -----------	
 template <class typeX>
  void SET<typeX>::Clear()
	   {
	    if(power)
	     delete[] array;
	    power=0;
	   }

//--------------------------------- POISK ELEMENTA -----------------------
template <class typeX>
 int SET<typeX>::Find(typeX &el)
{
 if (power)
 for (int i=0; i<power; i++)
 {
  if (el==array[i])
   return i;
 }
 return -1;
}

//---------------------------- SRAVNENIE -----------------------------------
template <class typeX>
 int Relation(SET<typeX> &set_1,SET<typeX> &set_2)
 {
   int count=0;
   for (int i=0; i<~set_1; i++)
    for (int j=0; j<~set_2; j++)
     if (set_1[i]==set_2[j])
     {
      count++; break;
     }
   if (~set_1==~set_2 && count==~set_1) return 0; //A=B
   else if (count==~set_1) return 1;      	//A<B
   else if (count==~set_2) return 2;       //A>B
   else return -1; //nikak
 }
 //----------------------------- Peregruzka operatsiy sravneniya ---------
 template <class typeX>
  int SET<typeX>::operator > (SET<typeX> &set_n)
  {
   if (Relation(*this,set_n)==2) return 1;
   else return 0;
  }
  template <class typeX>
   int SET<typeX>::operator < (SET<typeX> &set_n)
  {
   if (Relation(*this,set_n)==1) return 1;
   else return 0;
  }
  template <class typeX>
   int SET<typeX>::operator == (SET<typeX> &set_n)
  {
   if (Relation(*this,set_n)==0) return 1;
   else return 0;
  }
  template <class typeX>
   int SET<typeX>::operator != (SET<typeX> &set_n)
  {
   if (Relation(*this,set_n)!=0) return 1;
   else return 0;
  }
  template <class typeX>
   int SET<typeX>::operator >= (SET<typeX> &set_n)
  {
   if (*this==set_n || *this>set_n) return 1;
   else return 0;
  }
  template <class typeX>
   int SET<typeX>::operator <= (SET<typeX> &set_n)
  {
   if (*this==set_n || *this<set_n) return 1;
   else return 0;
  }
  template <class typeX>
   int SET<typeX>::operator /= (SET<typeX> &set_n)
  {
   if (Relation(*this,set_n)==-1) return 1;
   else return 0;
  }

//--------------------------------- (+) Sluchainiy el-t ---------------------
 SET<int> SET<int>::operator ++(int)
	    {
	     SET<int> temp;
	     int i,num=0;
	     temp.power=power+1;
	     temp.array=new int [temp.power];
	     for(i=0; i<power; i++)
	      temp[i]=array[i];
	     for(i=0; i<1000; i++)
	     {
	      num=(min_rand)+(random(max_rand));
	      if (this->Find(num)==-1)  break;
	     }
	     temp[power]=num;
	     *this=temp;
	     return *this;
	    }

//--------------------------------- (-) Sluchainiy el-t ---------------------
template <class typeX>
 SET<typeX> SET<typeX>::operator --(int)
	    {
	    if (power)
	    {
	     SET temp;
	     int index=0;
	     temp.power=power-1;
	     temp.array=new typeX [temp.power];
	     index=random(power);
	     for(int i=0,k=0; i<power; i++,k++)
	     {
	      if (i==index)
	      { k--; continue;}
	      temp[k]=array[i];
	     }
	     *this=temp;
	    }
	    return *this;
	    }

//--------------------------------- Delete el-t ---------------------
template <class typeX>
 SET<typeX> SET<typeX>::operator >>=(typeX &el)
	    {
	    if (power)
	    {
	     int index=(this->Find(el));
	     if (index==-1)
	      return *this;
	     SET temp;
	     while(index!=-1)
	     {
	      temp.power=power-1;
	      temp.array=new typeX [temp.power];
	      for(int i=0,k=0; i<power; i++,k++)
	      {
	       if (i==index)
	       { k--; continue;}
	       temp[k]=array[i];
	      }
	      *this=temp;
	      index=this->Find(el);
	     }
	    }
	    return *this;
	    }

//--------------------------------- Add el-t -----------------------
template <class typeX>
 SET<typeX> SET<typeX>::operator <<=(typeX &el)
	    {
	     SET temp;
	     temp.power=power+1;
	     temp.array=new typeX [temp.power];
	     for (int i=0; i<power; i++)
	      temp[i]=array[i];
	     temp[power]=el;
	     *this=temp;
	     return *this;
	    }

//----------------------------------- OB'YEDINENIE -------------------------
template <class typeX>
 SET<typeX> SET<typeX>::operator + (SET<typeX> &set_n)
	    {
	     SET temp;
	     if (power==0 && set_n.power==0)
	     {
	      return temp;
	     }
	     else if (power==0)
	      return set_n;
	     else if (set_n.power==0)
	      return *this;

	     typeX elem;
	     int i,flag=0,count=0;
	     temp.power=power+set_n.power;
	     temp.array=new typeX [temp.power];
	     for (i=0; i<power; i++)
	      temp.array[i]=array[i];
	     //-------el-ti 2-go mn-va-----
	     for (i=0; i<set_n.power; i++)
	     {
	      elem=set_n.array[i];
	      for (int j=0,flag=0; j<power; j++)
	      {
	       if (elem==array[j])
	       {
		flag=1; count++;
	       }
	      }
	      if (flag==0)
	       temp.array[power+i-count]=elem;
	     }
	     temp.power-=count;
	    return temp;
	   }

//------------------------------ PERESECHENIYE -----------------------------
template <class typeX>
 SET<typeX> SET<typeX>::operator * (SET<typeX> &set_n)
	    {
	     SET temp;
	     if (power==0 || set_n.power==0)
	     {
	      return temp;
	     }

	     typeX elem;
	     temp.power=power;
	     for (int i=0,count=-1; i<temp.power; i++)
	     {
	      elem=array[i];
	      for (int j=0; j<set_n.power; j++)
	      if (elem==set_n[j])
	      {
	       count++;
	       temp[count]=elem;
	      }
	     }
	     temp.power=count+1;
	     return temp;
	    }

//------------------------------ RAZNOST' ----------------------------------
template <class typeX>
 SET<typeX> SET<typeX>::operator - (SET<typeX> &set_n)
	    {
	     SET temp;
	     if (power==0 && set_n.power==0 || power==0)
	     {
	      return temp;
	     }
	     else if (set_n.power==0)
	      return *this;

	     typeX elem;
	     int flag=0;
	     temp.power=power;
	     for (int i=0,count=-1; i<power; i++)
	     {
	      elem=array[i];
	      for (int j=0,flag=0; j<set_n.power; j++)
	       if (elem==set_n[j])
	       {
		flag=1;
	       }
	      if (flag==0)
	      {
	       count++;
	       temp[count]=elem;
	      }
	     }
	     temp.power=count+1;
	     return temp;
	    }

//------------------------ SIMMETR. RAZNOST' -------------------------------
template <class typeX>
 SET<typeX> SET<typeX>::operator % (SET<typeX> &set_n)
	    {
	     SET temp;
	     if (power==0 && set_n.power==0)
	     {
	      return temp;
	     }
	     else if (power==0)  {return set_n;}
	     else if (set_n.power==0)
	     {
	      return *this;
	     }
	     temp=(*this-set_n)+(*this^set_n);
	     return temp;
	    }
//---------------------------------- DOPOLNENIE -------------------
template <class typeX>
 SET<typeX> SET<typeX>::operator ^ (SET<typeX> &set_n)
	    {
	     SET temp;
	     if (power==0 && set_n.power==0 || set_n.power==0)
	     {
	      return temp;
	     }
	     else if (set_n.power==0)
	      return *this;
	     typeX elem;
	     int i,j,flag=0,count=0;
	     //--- el-ti mn-va 2, NE prinadl. mn-vu 1 -> vrem. mn-vo--
	     for (i=0,count=-1; i<set_n.power; i++)
	     {
	      elem=set_n[i];
	      for (j=0,flag=0; j<power; j++)
	      {
	       if (elem==array[j])
	       {
		flag=1;
	       }
	      }
	      if (flag==0)
	      {
	       count++;
	       temp[count]=elem;
	      }
	     }
	     temp.power=count+1;
	     return temp;
	    }

//------------------------- DEKARTOVO PROIZVEDENIE -----------------
template <class typeX>
 SET<typeX> SET<typeX>::operator & (SET<typeX> &set_n)
	    {
	     SET temp;
	     if (power==0 || set_n.power==0)
	     {
	      return temp;
	     }

	     typeX elem;
	     int count=0;
	     temp.power=(power * set_n.power)*2;
	     temp.array=new typeX [temp.power];
	     for (int i=0; i<power; i++)
	     {
	      elem=array[i];
	      for (int j=0; j<set_n.power; j++,count+=2)
	      {
	       temp[count]=elem;
	       temp[count+1]=set_n[j];
	      }
	     }
	     return temp;
	    }

//----------------- Index -----------------------------------------
template <class typeX> typeX& SET<typeX>::operator [] (int &i)
{
 if (i<0)
 {
  cout<<"\nOhibka! Neverniy indeks: "<<i<<'\n'; getch(); exit(1);
 }
 return array[i];
}

//------- Vvod mn-va N -----------------------------------------------------
template <class typeX>
 istream& operator >> (istream &in, SET<typeX> &set_n)
{
  SET<typeX> temp;
  cout<<"Vvedite KOL-VO el-tov mn-va: ";
  in>>temp.power;
   if (temp.power)
  {
   typeX elem;
   int i,count=0,flag=0;
   if (set_n.power)
    delete[] set_n.array;
   temp.init_Zero(temp.power);
   cout<<"Vvedite el-ti mn-va:\n";
   for (i=0,flag=0; i<temp.power; i++)
   {
    in>>elem;
    if (elem==0 && flag==0)
     { count++;
       flag=1;}
    else if (temp.Find(elem)==-1)
    {
     temp[count]=elem;
     count++;
    }
   }
   set_n.power=count;
   set_n.array=new typeX [set_n.power];
   for (i=0; i<set_n.power; i++)
    set_n[i]=temp[i];
  }
 return in;
}

//--------------- Vivod mn-va -----------------------------------------------
template <class typeX>
 ostream& operator << (ostream &out, SET<typeX> &set_n)
{
 if (set_n.power)
 {
  cout<<"{";
  for (int i=0; i<set_n.power; i++)
  {
   cout<<set_n[i];
   if (i!=set_n.power-1) cout<<", ";
  }
  cout<<"}\n";
 }
 else
  cout<<"\ @ (Pustoe mnozhestvo!)\n";
 return out;
}

int SET<int>::min_rand=-100;
int SET<int>::max_rand=201;
#endif
