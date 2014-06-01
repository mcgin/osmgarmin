del bounds/*
del *.pbf
del *.o5m
del *.img
.\tools\wget.exe -O .\full-maps\england-latest.osm.pbf http://download.geofabrik.de/europe/great-britain/england-latest.osm.pbf
cd splitter-r404 
java -Xmx2000m -jar splitter.jar ../full-maps/england-latest.osm.pbf > splitter.log
cd ..
move splitter-r404\*.pbf .
tools\osmconvert full-maps\england-latest.osm.pbf -o=england.o5m
tools\osmfilter england.o5m --keep-nodes= --keep-ways-relations="boundary=administrative =postal_code postal_code=" -o=england-boundaries.o5m
java -cp mkgmap-r3288\mkgmap.jar uk.me.parabola.mkgmap.reader.osm.boundary.BoundaryPreprocessor england-boundaries.o5m bounds
java -jar mkgmap-r3288\mkgmap.jar --route --add-pois-to-areas --bounds=bounds --index --gmapsupp *.osm.pbf
pause