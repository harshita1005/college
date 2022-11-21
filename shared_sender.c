#include<stdlib.h>
#include<stdio.h>
#include<unistd.h>
#include<string.h>
#include<sys/shm.h>
#include<sys/ipc.h>

int main(){
void *shared_memory;
char buff[100];
int shmid;

shmid=shmget((key_t)1122,1024,0666|IPC_CREAT);
printf("Key of shared memory- %d\n",shmid);
shared_memory=shmat(shmid,NULL,0);
printf("Process attached at- %p\n",shared_memory);
printf("Enter data- \n");
read(0,buff,100);
strcpy(shared_memory,buff);
printf("You wrote- %s\n",(char*)shared_memory);
}

