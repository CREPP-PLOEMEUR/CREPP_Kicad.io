#Zip library

JSON_PACKAGE="package.json"
LIBRARY_COMPONENTS="Library.zip"

function commit() 
{
    git add .
    git commit -am "$1"
    branch=$(git rev-parse --abbrev-ref HEAD)
    git push origin $branch
}


(cd CREPP.Components; zip -q -r ../$LIBRARY_COMPONENTS ./)

commit "$1"

#
cp "$JSON_PACKAGE" "${JSON_PACKAGE}.bak"

if [ ! -f package.json ]; then
    echo "Error: File your_file.json does not exist."
    exit 1
fi

TOTAL_PACKAGES=$(jq '.packages | length' "$JSON_PACKAGE")
echo -e "Packages found : $TOTAL_PACKAGES"


for ((INDEX=0; INDEX<TOTAL_PACKAGES; INDEX++)); do

    FILE_URL=$(jq -r ".packages[$INDEX].versions[0].download_url" "$JSON_PACKAGE")
    echo -n "Computing SHA256 of $FILE_URL"

    FILE_NAME="temp_file_$INDEX.zip"
    curl -s -o "$FILE_NAME" "$FILE_URL"

    NEW_SHA256=$(sha256sum "$FILE_NAME" | awk '{print $1}')
    echo " : done"
    echo ">>> "$NEW_SHA256

    #Compressed zip storage
    size_zip=`du -sb $FILE_NAME | cut -f1`

    unzip temp_file_$INDEX.zip -q -d tmp_unzip_dir
    size_unzip=`du -sb tmp_unzip_dir | cut -f1`
    echo $size_unzip
    rm -r tmp_unzip_dir


    jq --argjson index "$INDEX" --arg sha256 "$NEW_SHA256" --argjson download_size "$size_zip" --argjson install_size "$size_unzip" \
    '.packages[$index].versions[0].download_sha256 = $sha256 | .packages[$index].versions[0].download_size = $download_size | .packages[$index].versions[0].install_size = $install_size' \
    "$JSON_PACKAGE" > temp.json 
    mv temp.json "$JSON_PACKAGE"
    
    rm "$FILE_NAME"
    echo -e "Library is updated !"

done

#Update the SHA256 of repository.json
echo -n "Update the SHA256 of package.json into repository.json"
SHA256=$(sha256sum package.json | awk '{print $1}') && \
sed -i "s/\"sha256\": \".*\"/\"sha256\": \"$SHA256\"/" repository.json
echo -e " : done"

commit "$1 - ($SHA256)"