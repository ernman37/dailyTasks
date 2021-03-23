#!/bin/bash
#Colors for output
NO='\033[0m'
R='\033[0;31m'
G='\033[0;32m'
O='\033[0;33m'
P='\033[0;35m'
UO='\033[4;33m'
UG='\033[4;32m'

#stores date and goal destination of file for the day
today=$(date +%b-%d-%Y)
file=$(pwd)/dates/$today.txt

#start program
begin(){
   if [[ -f "$file" ]]; #File exists
   then
      run="t"
   else #It doesn't exist
      g++ -std=c++17 -o tasks tasks.cpp
      touch $file
      ./tasks $file #gets user input for file
      run="f"
   fi
   list
   if [ "$run" == "f" ];
   then
      exit #only on creation of file
   fi
   getOpt
}

#how many lines are in goals file
count(){
   let i=0
   while read -r line
   do
      let i=$i+1
   done < $file
   echo $i #grabs echo
}

#lists what is inside of goals file
list(){
   if [ $(count) == "0" ] #0 lines in file 
   then
      echo -e "${R}No Current Tasks for ${UO}$today${NO}"
      exit
   else #More than 0 lines 
      echo -e "${G}Tasks for ${UO}$today${G} are...${O}"
      while read -r line
      do
         echo " $line"
      done < $file
   fi
}

#gets options for file modification/output
getOpt(){
   echo -e "${UO}Options are:\n${UG}1.${O} add task    ${UG}2.${O} remove task\n${UG}3.${O} print       ${UG}4.${O} exit${G}"
   read -p "Enter #: " option #gets option
   echo
   if [ $option == ""] &> error #always a error message when comparing if empty
   then
      echo -e "${G}Done"
      exit
   elif [ $option == "1" ]
   then
      add
   elif [ $option == "2" ]
   then
      remove
   elif [ $option == "3" ]
   then
      list
      echo
      getOpt
   else #exits on anything that isnt a selected option
      echo -e "${G}Done"
      exit
   fi
}

#adds new goal to file
add(){
   echo -e "${G}ADDING..."
   let lines=$(count)+1
   read -p "$lines. " new
   if [ "$new" == "" ];
   then
      exit
   fi
   new="$lines. $new" 
   let lines=$lines+1
   echo $new >> $file
   echo
   getOpt
}

#removes certain index
remove(){
   echo -e "${R}REMOVING..."
   list
   touch copy.txt
   let lines=$(count)
   if [ $lines == 0 ];
   then
      echo -e "${G}Completed all tasks${NO}"
      exit
   fi
   read -p "Index to remove: " delete
   let d=$delete
   if [ "$delete" == "" ];
   then
      return
   elif [ $d -lt 1 ] &> error #cant delete anything below 1 option
   then
      getOpt
   fi
   let delete=$delete
   if [[ $delete > $lines ]];
   then
      echo -e "${R}Index $delete out of bounds, list length = $lines${NO}"
      list
      getOpt
   fi
   removed=$(./tasks $file $delete)
   mv copy.txt $file
   echo -e "${G}Completed task${O}$removed${G}"
   echo
   getOpt
}

#Start of the progarm:) so simple and beautiful
begin

