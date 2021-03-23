/*
 *   Creator: Ernest M Duckworth IV
 *   Date: $(date +%D) 
 *   For:
 *   Description:
*/
#include <iostream>
#include <fstream>
#include <vector>
#include <string>

using namespace std;
void deleteline(string file, int index){
   ifstream in(file);
   if(in){
      ofstream out("copy.txt");
      int counter = 0;
      string completed = "";
      for(int i = 1; in; i++){
         string junk;
         in >> junk;
         getline(in, junk);
         if(junk == "") return;   
         if(i != index)
            out << ++counter << '.' << junk << '\n';
         else
            cout << junk;
      }
   }
}

int main(int argc, char *argv[]) {
   if(argc == 3) {
      string s = argv[2];
      int index = stoi(s);
      s = argv[1];
      deleteline(s, index);
      return 0;
   }
   ofstream today(argv[1]);
   string line = "!";
   if(today.is_open()){
      cout << "Enter Todays tasks by order of most importance\n";
      for(int i = 0; line.find('~') == string::npos && line != "";i++){
         if(line != "" && line != "!") today << i << ". " << line << '\n';
         cout << i+1 << ". ";
         getline(cin, line);
      }
   }
   today.close();
   return 0;
}
