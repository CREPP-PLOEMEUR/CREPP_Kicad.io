#Update repo
src_lib="CREPP.Components"
sha256=`sha256sum package.json | cut -d ' ' -f1`
echo "$sha256"
size_1=`du -sb $src_lib/footprints | cut -f1`
echo "$size_1"
size_2=`du -sb $src_lib/3dmodels | cut -f1`
echo "$size_2"
size_3=`du -sb $src_lib/symbols | cut -f1`
echo "$size_3"


JSON_PACKAGE="package.json"

# Crée une copie de sauvegarde du fichier original
cp "$JSON_PACKAGE" "${JSON_PACKAGE}.bak"

if [ ! -f package.json ]; then
    echo "Error: File your_file.json does not exist."
    exit 1
fi

TOTAL_PACKAGES=$(jq '.packages | length' "$JSON_PACKAGE")

echo $TOTAL_PACKAGES


for ((INDEX=0; INDEX<TOTAL_PACKAGES; INDEX++)); do
    # Extraire l'URL de téléchargement

    if jq -e '.packages' package.json > /dev/null; then
        echo "Name : "`jq -r '.packages[0].name' package.json`
    else
        echo "Not found"
        
    fi
    FILE_URL=$(jq -r ".packages[$INDEX].versions[0].download_url" "$JSON_PACKAGE")
    echo $FILE_URL
    
    # Télécharger le fichier temporaire
    #FILE_NAME="temp_file_$INDEX.zip"
    #curl -s -o "$FILE_NAME" "$FILE_URL"



    FILE_NAME="temp_file_$INDEX.zip"
    curl -s -o "$FILE_NAME" "$FILE_URL"


    # Calculer le SHA256
    NEW_SHA256=$(sha256sum "$FILE_NAME" | awk '{print $1}')
    echo $NEW_SHA256

    #Mettre à jour le JSON
    jq --argjson index "$INDEX" --arg sha256 "$NEW_SHA256" \
        '.packages[$index].versions[0].download_sha256 = $sha256' \
        "$JSON_FILE" > temp.json && mv temp.json "$JSON_PACKAGE"

    # Nettoyer le fichier temporaire
    rm "$FILE_NAME"

    echo "SHA256 mis à jour pour l'index $INDEX."
done

#Update the SHA256 of repository.json
echo -n "Update the SHA256 of package.json into repository.json"
SHA256=$(sha256sum package.json | awk '{print $1}') && \
sed -i "s/\"sha256\": \".*\"/\"sha256\": \"$SHA256\"/" repository.json
echo -e " : done"