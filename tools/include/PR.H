//Reshenie SLAU - metod polnogo iskl'ucheniya peremennih (po prav. pr'amoug.)
#include <iostream.h>
#include <conio.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#ifndef PR_INCLUDED
#define PR_INCLUDED

double epsilon = 0.001;	// dl'a Scan() - poisk el-ta
double InputNum();
void Print(double **(&B),int n, int m=0);
void Input(double **(&B), int n, int m=0);
void NewMatr(double **(&B),int n,int m=0);
void Copy(double **(&B),double **(&C),int,int m=0);
void Clear(double **(&B),int n,int m=0);
int Scan(double **B,int n,double elem,int &ix,int &jx);
double Pryam(double a,double b,double c,double d,double razresh);

void SLAU_rectangle(double **A,int n,int m,double &X,char mode='a');
#endif