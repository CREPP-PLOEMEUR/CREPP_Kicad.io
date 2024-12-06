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
