Setup:

clone the repository:
git clone https://github.com/maddoxreed9175-png/talktome.git

cd into the repository:
cd talktome

run setup.sh:
(NOTE: This will install several different things. I recommend using your favorite text editor to read setup.sh before you run it.)
./setup.sh

If you want to specify a language model to download, you can pass the model in as a parameter.
For example:
./setup.sh gemma4:e2b

gemma3:270m-it-qat is used as a default if a model is not specified.

run talktome.sh:
./talktome.sh

If you want to specify a language model to run, you can pass the model in as a parameter.
For example:
./talktome.sh gemma4:e2b

gemma3:270m-it-qat is used as a default if a model is not specified.
