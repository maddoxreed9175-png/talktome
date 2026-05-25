//TESTING

#include <iostream>
#include <fstream>
#include <string>
#include <algorithm>

int main() {
  std::ifstream in("llmOutput.txt");
  std::ofstream out("cleanOutput.txt");

  if (!in.is_open() || !out.is_open()) {
    std::cerr << "Error opening file.\n";
    return 1;
  }

  std::string line;
  while (std::getline(in, line)) {
    line.erase(std::remove(line.begin(), line.end(), '*'), line.end());
    std::replace(line.begin(), line.end(), ':', '.'), line.end();

    out << line;
  }
  in.close();
  out.close();

  return 0;
}

