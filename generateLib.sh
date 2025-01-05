#Update repo
echo "INIT"

./compressLib.sh
./gitCommit.sh "Add repo of lib Kicad before analyzing..."
./uploadLibrary.sh
./gitCommit.sh "Add lib"
