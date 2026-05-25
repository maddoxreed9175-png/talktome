#!/bin/bash

while true; do
  #read -rsn1 key
  #if [[ "$key" == "q" || "$key" == "Q" ]]; then
  #  echo -e "\nScript stopped by user."
  #  exit 0
  #fi
  
  touch prompt.txt
  printf "Ask question..."
  spd-say -w "Ask question"

  #Calling whisper
  ./whisper.cpp/bin/whisper-stream -m ./whisper.cpp/models/ggml-tiny.en.bin -t 8 --step 0 --length 5000 -f prompt.txt 2>/dev/null &
  PID=$!

  #getting the last line from prompt.txt
  while true; do
    grepOut=$(grep -a -oP ']   \K.*' prompt.txt | tail -1)

    [[ -n "$grepOut" ]] && break

  done

  kill -9 $PID

  printf '%s\n' "$grepOut" > finalPrompt.txt
  unset grepOut

  printf "Please wait..."
  spd-say -w "Please wait"

  model="${1:-gemma3:270m-it-qat}"
  curl http://localhost:11434/api/generate -d '{
    "model": "'"$model"'",
    "prompt": "'"$(cat finalPrompt.txt)"'",
    "stream": false
  }' > llmOutput.json
  jq -r '.response' llmOutput.json > llmOutput.txt
  ./src/cleanOutput.out
  printf "\nResponse:\n"
  spd-say -e -w < cleanOutput.txt
  printf "\n"

  rm prompt.txt

done

./cleanup.sh
