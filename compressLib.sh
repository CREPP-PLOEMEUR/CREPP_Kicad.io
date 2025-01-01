#Update repo


#Zip library
#zip -r -D Library.zip CREPP.Components/3dmodels CREPP.Components/footprints CREPP.Components/symbols 
#zip -r -j Library.zip CREPP.Components/*
(cd CREPP.Components; zip -q -r ../Library.zip ./)
