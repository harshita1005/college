#!/bin/bash

create (){
    echo -n -e "\nEnter the filename which you want to create = "
    read db
    res=`ls| grep $db | wc -w `      #check the file is already existing or not,if res value greater than 0 file is there else create a file
    if [ $res -gt 0 ]
    then
    	echo -e "\nERROR- File already exists"
    else
    	touch $db
    	echo -e "\nFile created\n"
    fi
}


insert(){
    echo -n -e "\nEnter address book name = "
    read ab
    res=`ls| grep $ab | wc -w `      #check the file is already existing or not,if res value greater than 0 file is there else create a file
    if [ $res -eq 0 ]
    then
    	echo -e "\nERROR- No file exists...create a new file"
    else
    	echo -n -e "\nEnter the number of records to be added = "
	read no
    	while [ $no -gt 0 ]
    	do
      	echo -e -n "\nEnter roll no: "
      	read rno
      	srno=`cat $ab | grep $rno | wc -w`
      	if [ $srno -gt 0 ]
      	then
      		echo -e -n "\nRoll no already exists..\n"
         	
         else
         	echo -n -e "Enter Name: "
         	read name
         	echo -n -e "Enter Address : "
         	read address
         	record=`echo $rno" -> "$name" -> "$address`
         	echo $record >> $ab
         	no=$(($no-1))
         fi
    	 done
    echo -e "\n*******Records Inserted**********\n"
    	
    fi

}

search(){
    echo -e -n "\n\nEnter roll no: "
    read rno
    record=`grep "^$rno" "$db"`
    if [ $? -ne 0 ]; then
       echo -e -n "\n\n**********Record doesnt exist******** "
    else
       echo -e -n "\n\n**********Record found*********\n\n"
       echo $record
    fi
}

modify(){
    echo -n -e "\nEnter address book name = "
    read ab
    res=`ls| grep $ab | wc -w `      #check the file is already existing or not,if res value greater than 0 file is there else create a file
    if [ $res -eq 0 ]
    then
    	echo -e "\nERROR- No file exists...create a new file"
    else
      	echo -e -n "\nEnter roll no: "
      	read rno
      	srno=`cat $ab | grep $rno | wc -w`
      	if [ $srno -gt 0 ]
      	then
      		echo -e -n "\nEnter modified name and address- "
      		read name address
      		new=`echo $rno" -> "$name" -> "$address`
      		old=`cat $ab | grep $rno `
      		
      		echo -n -e "Old record- $old"
      		echo -n -e "New record- $new"
         	
         	sed -i s/"$old"/"$new"/g $ab
         	echo -n -e "Record Modified!"
         else
         	echo -n -e "Roll no doesn't exists..."
         fi
  
    fi

}

delete(){
    echo -n -e "\nEnter address book name = "
    read ab
    res=`ls| grep $ab | wc -w `      #check the file is already existing or not,if res value greater than 0 file is there else create a file
    if [ $res -eq 0 ]
    then
    	echo -e "\nERROR- No file exists...create a new file"
    else
      	echo -e -n "\nEnter roll no: "
      	read rno
      	srno=`cat $ab | grep $rno | wc -w`
      	if [ $srno -gt 0 ]
      	then
      		old=`cat $ab | grep $rno `
      
         	sed -i s/"$old"//g $ab
         	sed -i /^$/d $ab
         	echo -n -e "Record Deleted!"
         else
         	echo -n -e "Roll no doesn't exists..."
         fi
  
    fi
}

display(){
 	echo -n -e "\nEnter the filename which you want to display= "
    	read db
    	res=`ls| grep $db | wc -w `      #check the file is already existing or not,if res value greater than 0 file is there else create a file
    	if [ $res -gt 0 ]
    	then
    		cat $db
    	else
    		echo -e "\nFile is not existing"
    	fi
}

MENU1="
         ****Menu****

1)Create
2)Insert
3)Search
4)Modify
5)Delete
6)Display
7)Exit
"

while true
do
   echo -n "$MENU1"
   echo -n "Enter the choice: "
   read  n
   case $n in
   1) create
   ;;
   2)insert
   ;;
   3) search
   ;;
   4) modify
   ;;
   5) delete
   ;;
   6) display
   ;;
   7) exit
   ;;
   esac
   done
