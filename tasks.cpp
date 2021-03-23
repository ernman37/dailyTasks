/*
 *   Creator: Ernest M Duckworth IV
 *   Date: 3/23/2021 
 *   For: Today bash function
 *   Description: Creates a file of daily goals
 *                or removes line from created file
*/
#include <iostream>
#include <fstream>
#include <vector>
#include <string>

using namespace std;
//This is for the delete method
void deleteline(const string &file, const int &index){
   ifstream in(file);
   if(in){
      ofstream out("copy.txt");
      int counter = 0;
      string completed = "";
      for(int i = 1; in; i++){
         string junk;
         in >> junk; //junk is the numbers infront of task
         getline(in, junk);
         if(junk == "") return; //There should be no empty lines  
         if(i != index)
            //writes all tasks to copy file expect choosen index
            out << ++counter << '.' << junk << '\n';
         else
            //allows to store what was removed in bash file
            cout << junk;
      }
   }
}

//Creates new file
void newFile(const string &s){
   ofstream today(s);
   string line = "!";
   if(today.is_open()){
      //Getting input to store in file
      cout << "Enter Todays tasks by order of most importance\n";
      for(int i = 0; line.find('~') == string::npos && line != "";i++){
         if(line != "" && line != "!") today << i << ". " << line << '\n';
         cout << i+1 << ". ";
         getline(cin, line);
      }  
   }  
   today.close(); //closes file
}

int main(int argc, char *argv[]) {
   //file always stored in argv[1]
   const string file = argv[1];
   //determins if we need to use delete method
   if(argc == 3) {
      string s = argv[2];
      int index = stoi(s);
      deleteline(file, index);
   //Looks if right amount of args is passed for newFile
   }else if (argc == 2){
      newFile(file);
   //else there is something wrong with arguements
   }else{
      cerr << argv[0] << ": REQUIRES 2-3 ARGUEMENTS ONLY\n";
      return 1;
   }
   return 0; //returns successfully
}
