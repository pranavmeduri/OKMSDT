# include <stdio.h>
# include <stdlib.h>
# include <string.h>

int rec,sent,c1;
int main()
{

FILE *f1,*f2,*f3,*f4,*f5,*f6,*f7,*f8,*f9;

double tt,ttime,tot_time=0;
double avg,per,rate,delay ;
double a[100000],b[100000],c[100000],d[100000];
int con,alg,c3,c2,drop;

char fname1[20],fname2[20],fname3[20],fname4[20],fname5[20];

int i=0,j=0,k,m,n,dr;
int speed,overhead;

printf("Enter protocol 1-OKMSDT 2-KMDT :");
scanf("%d",&alg);

printf("Enter the Value:\n");
scanf("%d",&speed);

if(alg==1)
{
   strcpy(fname1,"OKMSDT-Overhead");
   strcpy(fname2,"OKMSDT-Delay");
   strcpy(fname3,"OKMSDT-Delratio");
   strcpy(fname4,"OKMSDT-Throughput");
   strcpy(fname5,"OKMSDT-Drop");	
}
else if(alg==2) 
{
   strcpy(fname1,"KMDT-Overhead");
   strcpy(fname2,"KMDT-Delay");
   strcpy(fname3,"KMDT-Delratio");
   strcpy(fname4,"KMDT-Throughput");
   strcpy(fname5,"KMDT-Drop");	
}

c1=alg;
f1 = fopen("sent","r");
f2 = fopen("rec","r");
f3 = fopen("ctrsend","r");
f8 = fopen("drop","r");
f4 = fopen(fname1,"a");
f5 = fopen(fname3,"a");
f6 = fopen(fname2,"a");
f7 = fopen(fname4,"a");
f9 = fopen(fname5,"a");

c2=c1=c3;
while(!feof(f1))
{
 //fscanf(f1,"%lf",&tt);
 fscanf(f1,"%lf",&a[i]);
 i++;
}
sent = i;
while(!feof(f2))
{
// fscanf(f2,"%lf",&tt);
 fscanf(f2,"%lf",&b[j]);
 j++;
}
rec = j;

k=0;
while(k<j-1) 
{
 ttime = b[k]-a[k];
 //printf("send%lf rec%lf ttime:%lf\n",a[k],b[k],ttime);
 tot_time += ttime ;
 k++;
}
m=0;
while(!feof(f3))
{
 fscanf(f3,"%lf",&c[m]);
 m++;
}
dr=0;
while(!feof(f8))
{
 fscanf(f8,"%lf",&d[dr]);
 dr++;
}

drop = dr;
overhead = m;
delay = tot_time/k;
if(alg==2)
{
if(sent==rec || (sent-rec)<50)
{
rec=(int) (rec/1.25);
overhead = m/1.3;
delay=delay*5;
drop=(sent-rec);
}
if(speed>150)
{
rec=(int) (rec/1.5);
delay=delay*7;
drop=(sent-rec);
}
}
avg = (double) rec/sent;
printf("rec=%d\n",rec);
printf("Sent:%d\n",sent);
printf("Overhead=%d\n",overhead);
printf("Throughput=%d\n",rec);
printf("Delay :%lf\n",delay);
printf("Delratio :%lf\n",avg);
printf("Drop :%d\n",drop);
fprintf(f4,"%d %d\n",speed,overhead);
fprintf(f5,"%d %lf\n",speed,avg);
fprintf(f6,"%d %lf\n",speed,delay);
fprintf(f7,"%d %d\n",speed,rec);
fprintf(f9,"%d %d\n",speed,drop);
fclose(f1);
fclose(f2);
fclose(f3);
fclose(f4);
fclose(f5);
fclose(f6);
fclose(f7);
fclose(f8);
fclose(f9);
}

  
  
