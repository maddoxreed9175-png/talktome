#!/bin/bash

while true; do
  
  touch prompt.txt
  printf "Listening..."
  spd-say -w "Listening"

  #Calling whisper
  ./whisper.cpp/bin/whisper-stream -m ./whisper.cpp/models/ggml-tiny.en.bin -t 8 --step 0 --length 5000 -vth 0.6 -f prompt.txt 2>/dev/null &
  PID=$!

  #getting the last line from prompt.txt
  while true; do
    grep -a -oP ']   \K.*' prompt.txt | tail -1
    grepOut=$(grep -a -oP ']   \K.*' prompt.txt | tail -1)

    [[ -n "$grepOut" ]] && break

  done

  kill -9 $PID > /dev/null 2>&1

  if [[ "$grepOut" == "Stop." ]] || [[ "$grepOut" == "Quit." ]]; then
    break
  fi

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

printf "Goodbye."
spd-say -w "Goodbye."
./cleanup.sh
