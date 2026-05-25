//TESTING

#include <iostream>
#include <fstream>
#include <string>

int main() {
  std::ifstream file("prompt.txt");
  
  if (!file.is_open()) {
    std::cerr << "Error opening file.\n";
    return 1;
  }

  std::string line;
  std::string lastLine;

  while (std::getline(file, line)) {
    if (line != "" && line != "[BLANK_AUDIO]"){
      lastLine = line;
    }
  }
  file.close();

  std::ofstream outFile("finalPrompt.txt");

  if (outFile.is_open()){
    outFile << lastLine;
    outFile.close();
  } else {
    std::cout << "Unable to open file";
  }

  return 0;
}

