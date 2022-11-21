#include<stdio.h>
#include<stdlib.h>
#include<sys/types.h>
#include<sys/stat.h>
#include<unistd.h>
#include<fcntl.h>
#include<string.h>

int main()
{
FILE *fp;
 int fd1,fd2;
 char ch;
 //creating the file
 char *myfifo1="file1",str1[100],str2[100];
 char *myfifo2="file2";
 int c=0,i,l=0,w=1;
 
 
 //read the data from First FIFO file
 fd1=open(myfifo1,O_RDONLY);
 read(fd1,str1,100);
 printf("\nData Read from Pipe1: %s",str1);
 
 //count number of characters,words,lines
 i=0;
 while(str1[i]!='\0'){
 if(str1[i]=='\n')
 	l++;
 else if( str1[i]==' ')
 	w++;
 else if(str1[i]!=' ')
 	c++;
 
 i++;
 }

printf("\n Number of characters- %d",c);
printf("\n Number of lines- %d",l);
printf("\n Number of words- %d\n",w);


//write the counted lines,words,characters into a text file
fp=fopen("data.txt","w");
fprintf(fp,"\nNo of lines: %d",l);
fprintf(fp,"\nNo of words: %d",w);
fprintf(fp,"\nNo of charachters: %d\n",c);
fclose(fp);

fp=fopen("data.txt","r");
ch=fgetc(fp);

i=0;
while(ch!=EOF){
str2[i]=ch;
i++;
ch=fgetc(fp);
}
str2[i]='\0';
fclose(fp);

close(fd1);

//write data on second FIFO pipe
fd2=open(myfifo2,O_WRONLY);
write(fd2,str2,strlen(str2)+1);
close(fd2);
}
