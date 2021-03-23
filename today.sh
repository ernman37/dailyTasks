#!/bin/bash
NO='\033[0m'
R='\033[0;31m'
G='\033[0;32m'
O='\033[0;33m'
P='\033[0;35m'
UO='\033[4;33m'
UG='\033[4;32m'
today=$(date +%b-%d-%Y)
file=$(pwd)/dates/$today.txt

begin(){
   if [[ -f "$file" ]]; 
   then
      run="t"
   else
      g++ -std=c++17 -o tasks tasks.cpp
      touch $file
      ./tasks $file
      run="f"
   fi
   list
   if [ "$run" == "f" ];
   then
      exit
   fi
}
count(){
   let i=0
   while read -r line
   do
      let i=$i+1
   done < $file
   echo $i
}
list(){
   if [ $(count) == "0" ] 
   then
      echo -e "${R}No Current Tasks for ${UO}$today${NO}"
      exit
   else
      echo -e "${G}Tasks for ${UO}$today${G} are...${O}"
      while read -r line
      do
         echo " $line"
      done < $file
   fi
}
getOpt(){
   echo -e "${UO}Options are:\n${UG}1.${O} add task    ${UG}2.${O} remove task\n${UG}3.${O} print       ${UG}4.${O} exit${G}"
   read -p "Enter #: " option
   echo
   if [ $option == ""] &> error
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
   else
      echo -e "${G}Done"
      exit
   fi
}
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
   if [ "$delete" == "" ];
   then
      return
   elif [ "$delete" == "0" ];
   then
      getopt
   fi
   let delete=$delete
   if [[ $delete > $lines ]];
   then
      echo -e "${R}Index $delete out of bounds, list length = $lines${NO}"
      list
      exit
   fi
   removed=$(./tasks $file $delete)
   mv copy.txt $file
   echo -e "${G}Completed task${O}$removed${G}"
   echo
   getOpt
}

begin
getOpt

