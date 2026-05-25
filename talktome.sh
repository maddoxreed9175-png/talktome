#!/bin/bash
timeout 5 ./whisper.cpp/build/bin/whisper-stream -m ./whisper.cpp/models/ggml-tiny.en.bin -t 8 --step 500 --length 5000 -f prompt.txt 2>/dev/null
spd-say -w "Please wait"
./src/getPrompt.out
curl http://localhost:11434/api/generate -d '{
  "model": "gemma3:270m-it-qat",
  "prompt": "'"$(cat finalPrompt.txt)"'",
  "stream": false
}' > llmOutput.json
jq -r '.response' llmOutput.json > llmOutput.txt
./src/cleanOutput.out
printf "\nResponse:\n"
spd-say -e -w < cleanOutput.txt
printf "\n"
./cleanup.sh
