#include<stdio.h>
#include<stdlib.h>
#include<sys/types.h>
#include<sys/stat.h>
#include<unistd.h>
#include<fcntl.h>
#include<string.h>

int main()
{
 int fd1,fd2;
 
 //assiging pathname of the file
 char *myfifo1="file1",str1[100],str2[100];
 char *myfifo2="file2";
 
 //creating fifo pipe(files)
 fd1=mkfifo(myfifo1,0666);
 fd2=mkfifo(myfifo2,0666);
 
 
 //take user input data to write on  first fifo pipe
 printf("\nEnter string- ");
 fgets(str1,100, stdin);              //if you want to  read a string with spaces use fget scanf doesn't consider sentences with spaces
                    

//write data on first FIFO pipe
fd1=open(myfifo1,O_WRONLY);
write(fd1,str1,strlen(str1)+1);    //fd1-address of the file written or given by open function
close(fd1);


fd2=open(myfifo2,O_RDONLY);
write(fd2,str2,100);
printf("\nmesaage- %s\n",str2);
close(fd2);
}

