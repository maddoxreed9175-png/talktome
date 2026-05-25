curl -fsSL https://ollama.com/install.sh | sh
git clone https://github.com/ggml-org/whisper.cpp.git
sudo apt-get install libsdl2-dev
cmake -B build -DWHISPER_SDL2=ON
cmake --build build -j --config Release
