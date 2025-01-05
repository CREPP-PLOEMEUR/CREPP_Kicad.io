#Update repo
echo "INIT"

./compressLib.sh
./gitCommit.sh "Add repo of lib Kicad before analyzing..."
./uploadLib.sh
./gitCommit.sh "Add lib"
