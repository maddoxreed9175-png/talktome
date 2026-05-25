#!/bin/bash
sudo apt update
sudo apt install cmake
sudo apt install jq
sudo apt install speech-dispatcher
sudo apt install libsdl2-dev
curl -fsSL https://ollama.com/install.sh | sh
ollama pull ${1:-gemma3:270m-it-qat}
git clone https://github.com/ggml-org/whisper.cpp.git
cd whisper.cpp
sh ./models/download-ggml-model.sh tiny.en
cmake -DWHISPER_SDL2=ON .
make whisper-stream
cd ..
